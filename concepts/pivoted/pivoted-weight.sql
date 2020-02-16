WITH htwt as
(
SELECT
  patientunitstayid
  , hospitaladmitoffset as chartoffset
  , admissionheight as height
  , admissionweight as weight
  , CASE
    -- CHECK weight vs. height are swapped
    WHEN  admissionweight >= 100
      AND admissionheight >  25 AND admissionheight <= 100
      AND abs(admissionheight-admissionweight) >= 20
    THEN 'swap'
    END AS method
  FROM `physionet-data.eicu_crd.patient`
)
, htwt_fixed as
(
  SELECT
    patientunitstayid
    , chartoffset
    , 'admit' as weight_type
    , CASE
      WHEN method = 'swap' THEN weight
      WHEN height <= 0.30 THEN NULL
      WHEN height <= 2.5 THEN height*100
      WHEN height <= 10 THEN NULL
      WHEN height <= 25 THEN height*10
      -- CHECK weight in both columns
      WHEN height <= 100 AND abs(height-weight) < 20 THEN NULL
      WHEN height  > 250 THEN NULL
      ELSE height END as height_fixed
    , CASE
      WHEN method = 'swap' THEN height
      WHEN weight <= 20 THEN NULL
      WHEN weight  > 300 THEN NULL
      ELSE weight
      END as weight_fixed
    from htwt
)
-- extract weight from the charted data
, wt1 AS
(
  select
    patientunitstayid, nursingchartoffset as chartoffset
    -- all of the below weights are measured in kg
    , CASE WHEN nursingchartcelltypevallabel IN
        (
            'Admission Weight', 'Admit weight'
        ) THEN 'admit'
    ELSE 'daily' END AS weight_type
    , CAST(nursingchartvalue as NUMERIC) as weight
  from `physionet-data.eicu_crd.nursecharting`
  where nursingchartcelltypecat = 'Other Vital Signs and Infusions'
  and nursingchartcelltypevallabel in
  (
      'Admission Weight'
    , 'Admit weight'
    , 'WEIGHT in Kg'
  )
  -- ensure that nursingchartvalue is numeric
  and REGEXP_CONTAINS(nursingchartvalue, r'^([0-9]+\.?[0-9]*|\.[0-9]+)$')
  and nursingchartoffset < 60*24
)
-- weight from intake/output table
, wt2 as
(
  select
    patientunitstayid, intakeoutputoffset as chartoffset
    , 'daily' as weight_type
    , MAX(
        CASE WHEN cellpath = 'flowsheet|Flowsheet Cell Labels|I&O|Weight|Bodyweight (kg)'
        then cellvaluenumeric
      else NULL END
    ) AS weight_kg
    -- there are ~300 extra (lb) measurements compared to kg, so we include both
    , MAX(
        CASE WHEN cellpath = 'flowsheet|Flowsheet Cell Labels|I&O|Weight|Bodyweight (lb)'
        then cellvaluenumeric*0.453592
      else NULL END
    ) AS weight_kg2
  FROM `physionet-data.eicu_crd.intakeoutput`
  WHERE CELLPATH IN
  ( 'flowsheet|Flowsheet Cell Labels|I&O|Weight|Bodyweight (kg)'
  , 'flowsheet|Flowsheet Cell Labels|I&O|Weight|Bodyweight (lb)'
  )
  and INTAKEOUTPUTOFFSET < 60*24
  GROUP BY patientunitstayid, intakeoutputoffset
)
-- weight from infusiondrug
, wt3 as
(
  select
    patientunitstayid, infusionoffset as chartoffset
    , 'daily' as weight_type
    , cast(patientweight as NUMERIC) as weight
  from `physionet-data.eicu_crd.infusiondrug`
  where patientweight is not null
  and infusionoffset < 60*24
)
-- combine together all weights
SELECT patientunitstayid, chartoffset, 'patient' as source_table, weight_type, weight_fixed as weight
FROM htwt_fixed
WHERE weight_fixed IS NOT NULL
UNION ALL
SELECT patientunitstayid, chartoffset, 'nursecharting' as source_table, weight_type, weight
FROM wt1
WHERE weight IS NOT NULL
UNION ALL
SELECT patientunitstayid, chartoffset, 'intakeoutput' as source_table, weight_type, COALESCE(weight_kg, weight_kg2) as weight
FROM wt2
WHERE weight_kg IS NOT NULL
OR weight_kg2 IS NOT NULL
UNION ALL
SELECT patientunitstayid, chartoffset, 'infusiondrug' as source_table, weight_type, weight
FROM wt3
WHERE weight IS NOT NULL
ORDER BY 1, 2, 3;