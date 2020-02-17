with nc as
(
select
  patientunitstayid
  , nursingchartoffset as chartoffset
  , min(case
      when nursingchartcelltypevallabel = 'Glasgow coma score'
       and nursingchartcelltypevalname = 'GCS Total'
       and REGEXP_CONTAINS(nursingchartvalue, '^[-]?[0-9]+[.]?[0-9]*$')
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      when nursingchartcelltypevallabel = 'Score (Glasgow Coma Scale)'
       and nursingchartcelltypevalname = 'Value'
       and REGEXP_CONTAINS(nursingchartvalue, '^[-]?[0-9]+[.]?[0-9]*$')
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end)
    as gcs
  , min(case
      when nursingchartcelltypevallabel = 'Glasgow coma score'
       and nursingchartcelltypevalname = 'Motor'
       and REGEXP_CONTAINS(nursingchartvalue, '^[-]?[0-9]+[.]?[0-9]*$')
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end)
    as gcsmotor
  , min(case
      when nursingchartcelltypevallabel = 'Glasgow coma score'
       and nursingchartcelltypevalname = 'Verbal'
       and REGEXP_CONTAINS(nursingchartvalue, '^[-]?[0-9]+[.]?[0-9]*$')
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end)
    as gcsverbal
  , min(case
      when nursingchartcelltypevallabel = 'Glasgow coma score'
       and nursingchartcelltypevalname = 'Eyes'
       and REGEXP_CONTAINS(nursingchartvalue, '^[-]?[0-9]+[.]?[0-9]*$')
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end)
    as gcseyes
  from `physionet-data.eicu_crd.nursecharting`
  -- speed up by only looking at a subset of charted data
  where nursingchartcelltypecat in
  (
    'Scores', 'Other Vital Signs and Infusions'
  )
  group by patientunitstayid, nursingchartoffset
)
-- apply some preprocessing to fields
, ncproc AS
(
  select
    patientunitstayid
  , chartoffset
  , case when gcs > 2 and gcs < 16 then gcs else null end as gcs
  , gcsmotor, gcsverbal, gcseyes
  from nc
)
select
  patientunitstayid
  , chartoffset
  , gcs
  , gcsmotor, gcsverbal, gcseyes
FROM ncproc
WHERE gcs IS NOT NULL
OR gcsmotor IS NOT NULL
OR gcsverbal IS NOT NULL
OR gcseyes IS NOT NULL
ORDER BY patientunitstayid