
-- ------------------------------------------------------------------
-- Title: Oxford Acute Severity of Illness Score (OASIS)
-- This query extracts the Oxford acute severity of illness score.
-- This score is a measure of severity of illness for patients in the ICU.
-- The score is calculated on the first day of each ICU patients' stay.
-- OASIS score was originally created for MIMIC
-- This script creates a pivoted table containing the OASIS score in eICU 
-- ------------------------------------------------------------------

-- Authors:
-- Tristan Struja, MD, MSc, MPH (ORCID 0000-0003-0199-0184) and João Matos, MS (ORICD 0000-0002-0312-1647)

-- Reference for OASIS:
--    Johnson, Alistair EW, Andrew A. Kramer, and Gari D. Clifford.
--    "A new severity of illness scale using a subset of acute physiology and chronic health evaluation data elements shows comparable predictive accuracy*."
--    Critical care medicine 41, no. 7 (2013): 1711-1718.
-- https://alistairewj.github.io/project/oasis/

-- Variables used in OASIS (first 24h only):
--  Heart rate, MAP, Temperature, Respiratory rate
--  (sourced FROM `physionet-data.eicu_crd_derived.pivoted_vital`)
--  GCS
--  (sourced FROM `physionet-data.eicu_crd_derived.pivoted_vital` and `physionet-data.eicu_crd_derived.physicalexam`)
--  Urine output 
--  (sourced  FROM `physionet-data.eicu_crd_derived.pivoted_uo`)
--  Pre-ICU in-hospital length of stay 
--  (sourced FROM `physionet-data.eicu_crd.patient`)
--  Age 
--  (sourced FROM `physionet-data.eicu_crd.patient`)
--  Elective surgery 
--  (sourced FROM `physionet-data.eicu_crd.patient` and `physionet-data.eicu_crd.apachepredvar`)
--  Ventilation status 
--  (sourced FROM `physionet-data.eicu_crd_derived.ventilation_events`, `physionet-data.eicu_crd.apacheapsvar`, 
--   `physionet-data.eicu_crd.apachepredvar`, and `physionet-data.eicu_crd.respiratorycare`)

-- Regarding missing values:
-- Elective stay: If there is no information on surgery in an elective stay, we assumed all cases to be -> "no elective surgery"
-- There are a lot of missing values, especially for urine output. Hence, we have created 2 OASIS summary scores:
-- 1) No imputation, values as is with missings. 2) Imputation in case of NULL values, with 0's (common approach for severity of illness scores)

-- Note:
--  The score is calculated for *all* ICU patients, with the assumption that the user will subselect appropriate patientunitstayid.

DROP TABLE IF EXISTS `physionet-data.eicu_crd_derived.pivoted_OASIS` ;
CREATE TABLE `physionet-data.eicu_crd_derived.pivoted_OASIS` AS

WITH 

-- Pre-ICU stay LOS -> directly convert from minutes to hours
pre_icu_los_oasis AS (
SELECT patientunitstayid AS pid_LOS
  ,CASE
      WHEN hospitaladmitoffset > (-0.17*60) THEN 5
      WHEN hospitaladmitoffset BETWEEN (-4.94*60) AND (-0.17*60) THEN 3
      WHEN hospitaladmitoffset BETWEEN (-24*60) AND (-4.94*60) THEN 0
      WHEN hospitaladmitoffset BETWEEN (-311.80*60) AND (-24.0*60) THEN 2
      WHEN hospitaladmitoffset < (-311.80*60) THEN 1
      ELSE NULL
      END AS pre_icu_los_oasis
    FROM `physionet-data.eicu_crd.patient`
)

-- Age 
-- Change age from string to integer
, age_numeric AS (
  
  SELECT patientunitstayid 
  , CASE
    WHEN age = "> 89" THEN 91
    ELSE SAFE_CAST(age AS INT64) 
    END AS age_num
    FROM `physionet-data.eicu_crd.patient`
)

-- Get the information itself in a second step
, age_oasis AS (
    SELECT patientunitstayid AS pid_age
    , CASE
    WHEN MAX(age_num) < 24 THEN 0
    WHEN MAX(age_num) BETWEEN 24 AND 53 THEN 3
    WHEN MAX(age_num) BETWEEN 54 AND 77 THEN 6
    WHEN MAX(age_num) BETWEEN 78 AND 89 THEN 9
    WHEN MAX(age_num) > 89 THEN 7
    ELSE NULL
    END AS age_oasis
    FROM age_numeric
    GROUP BY pid_age
)

-- GCS, Glasgow Coma Scale
-- Merge information from two tables into one
, merged_gcs AS (
    
  SELECT pat_gcs.patientunitstayid, physicalexam.gcs1, pivoted_gcs.gcs2
  FROM `physionet-data.eicu_crd.patient` AS pat_gcs
   
    LEFT JOIN(
      SELECT patientunitstayid, MIN(CAST(physicalexamvalue AS NUMERIC)) AS gcs1
      FROM `physionet-data.eicu_crd.physicalexam`
      WHERE  (
      (physicalExamPath LIKE "notes/Progress Notes/Physical Exam/Physical Exam/Neurologic/GCS/_" OR
       physicalExamPath LIKE "notes/Progress Notes/Physical Exam/Physical Exam/Neurologic/GCS/__")
      AND (physicalexamoffset > 0 AND physicalexamoffset <= 1440) -- consider only first 24h
      AND physicalexamvalue IS NOT NULL)
  GROUP BY patientunitstayid
  )
  AS physicalexam
  ON physicalexam.patientunitstayid = pat_gcs.patientunitstayid

    LEFT JOIN(
      SELECT pivoted_gcs.patientunitstayid, pivoted_gcs.gcs as gcs2
      FROM `physionet-data.eicu_crd_derived.pivoted_gcs` AS pivoted_gcs
      WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    )
  AS pivoted_gcs
  ON pivoted_gcs.patientunitstayid = pat_gcs.patientunitstayid
)

-- Only keep minimal gcs from merged_gcs table
, minimal_gcs AS (
    SELECT patientunitstayid,
    CASE WHEN gcs1 < gcs2 THEN gcs1
     WHEN gcs2 < gcs1 THEN gcs2
     ELSE gcs1 
     END AS gcs_min 
    FROM merged_gcs
)

-- Call merged_gcs table in one go
, gcs_oasis AS (
    SELECT patientunitstayid AS pid_gcs
    , CASE
    WHEN gcs_min < 8 THEN 10
    WHEN gcs_min BETWEEN 8 AND 13 THEN 4
    WHEN gcs_min = 14 THEN 3
    WHEN gcs_min = 15 THEN 0
    ELSE NULL
    END AS gcs_oasis
    FROM minimal_gcs
    --WHERE (chartoffset > 0 AND chartoffset <= 1440) -- already considered in step above
)

-- Elective admission

-- Mapping
-- Assume emergency admission if patient came from
-- Emergency Department
-- Assume elective admission if patient from other place, e.g. operating room, floor, Direct Admit, Chest Pain Center, Other Hospital, Observation, etc.
, elective_surgery AS (

    -- 1: pat table as base for patientunitstayid  
    SELECT pat.patientunitstayid, electivesurgery1
      , CASE
      WHEN unitAdmitSource LIKE "Emergency Department" THEN 0
      ELSE 1
      END AS adm_elective1
      FROM `physionet-data.eicu_crd.patient` AS pat

    -- 2: apachepredvar table
    LEFT JOIN (
    SELECT apache.patientunitstayid, electivesurgery AS electivesurgery1
    FROM `physionet-data.eicu_crd.apachepredvar` AS apache
    )
    AS apache
    ON pat.patientunitstayid = apache.patientunitstayid

)

, electivesurgery_oasis AS (
  SELECT patientunitstayid AS pid_adm
  , CASE
    WHEN electivesurgery1 = 0 THEN 6
    WHEN electivesurgery1 IS NULL THEN 6
    WHEN adm_elective1 = 0 THEN 6
    ELSE 0
    END AS electivesurgery_oasis
  FROM elective_surgery
)

-- Heart rate 
, heartrate_oasis AS (
SELECT patientunitstayid AS pid_HR
  , CASE
    WHEN MIN(heartrate) < 33 THEN 4
    WHEN MAX(heartrate) BETWEEN 33 AND 88 THEN 0
    WHEN MAX(heartrate) BETWEEN 89 AND 106 THEN 1
    WHEN MAX(heartrate) BETWEEN 107 AND 125 THEN 3
    WHEN MAX(heartrate) > 125 THEN 6
    ELSE NULL
    END AS heartrate_oasis
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND heartrate IS NOT NULL
  GROUP BY pid_HR
)

-- Mean arterial pressure
, map_oasis AS (
  SELECT patientunitstayid AS pid_MAP
  , CASE
    WHEN MIN(ibp_mean) < 20.65 THEN 4
    WHEN MIN(ibp_mean) BETWEEN 20.65 AND 50.99 THEN 3
    WHEN MIN(ibp_mean) BETWEEN 51 AND 61.32 THEN 2
    WHEN MIN(ibp_mean) BETWEEN 61.33 AND 143.44 THEN 0
    WHEN MAX(ibp_mean) >143.44 THEN 3
    
    WHEN MIN(nibp_mean) < 20.65 THEN 4
    WHEN MIN(nibp_mean) BETWEEN 20.65 AND 50.99 THEN 3
    WHEN MIN(nibp_mean) BETWEEN 51 AND 61.32 THEN 2
    WHEN MIN(nibp_mean) BETWEEN 61.33 AND 143.44 THEN 0
    WHEN MAX(nibp_mean) >143.44 THEN 3
    ELSE NULL
    END AS map_oasis
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
  GROUP BY pid_MAP
)

-- Respiratory rate
, respiratoryrate_oasis AS (
SELECT patientunitstayid AS pid_RR
  , CASE
    WHEN MIN(respiratoryrate) < 6 THEN 10
    WHEN MIN(respiratoryrate) BETWEEN 6 AND 12 THEN 1
    WHEN MIN(respiratoryrate) BETWEEN 13 AND 22 THEN 0
    WHEN MAX(respiratoryrate) BETWEEN 23 AND 30 THEN 1
    WHEN MAX(respiratoryrate) BETWEEN 31 AND 44 THEN 6
    WHEN MAX(respiratoryrate) > 44 THEN 9
    ELSE NULL
    END AS respiratoryrate_oasis

  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND respiratoryrate IS NOT NULL
  GROUP BY pid_RR
)

-- Temperature 
, temperature_oasis AS (
  SELECT patientunitstayid AS pid_temp
  , CASE
    WHEN MIN(temperature) < 33.22 THEN 3
    WHEN MIN(temperature) BETWEEN 33.22 AND 35.93 THEN 4
    WHEN MAX(temperature) BETWEEN 33.22 AND 35.93 THEN 4
    WHEN MIN(temperature) BETWEEN 35.94 AND 36.39 THEN 2
    WHEN MAX(temperature) BETWEEN 36.40 AND 36.88 THEN 0
    WHEN MAX(temperature) BETWEEN 36.89 AND 39.88 THEN 2
    WHEN MAX(temperature) >39.88 THEN 6
    ELSE NULL
    END AS temperature_oasis
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND temperature IS NOT NULL
  GROUP BY pid_temp
)

-- Urine output
, merged_uo AS (
  
  -- pat table as base for patientunitstayid 
  SELECT pat.patientunitstayid, COALESCE(pivoted_uo.urineoutput, apache_urine.urine) AS uo_comb -- consider pivoted_uo first, if missing -> apacheapsvar
  FROM `physionet-data.eicu_crd.patient` AS pat
  
  -- Join information from pivoted_uo table
  LEFT JOIN(
  SELECT patientunitstayid AS pid_uo, SUM(urineoutput) AS urineoutput
  FROM `physionet-data.eicu_crd_derived.pivoted_uo` 
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
  AND urineoutput > 0 AND urineoutput IS NOT NULL -- ignore biologically implausible values <0
  GROUP BY pid_uo
  ) AS pivoted_uo
  ON pivoted_uo.pid_uo = pat.patientunitstayid

  -- Join information from apacheapsvar table
  LEFT JOIN(
  SELECT patientunitstayid AS pid_auo, urine
  FROM `physionet-data.eicu_crd.apacheapsvar` 
  WHERE urine > 0 AND urine IS NOT NULL -- ignore biologically implausible values <0
  ) AS apache_urine
  ON apache_urine.pid_auo = pat.patientunitstayid

)

-- Call merged_uo table for score computation
, urineoutput_oasis AS (
  SELECT merged_uo.patientunitstayid AS pid_urine, merged_uo.uo_comb
  , CASE
    WHEN uo_comb <671 THEN 10
    WHEN uo_comb BETWEEN 671 AND 1426.99 THEN 5
    WHEN uo_comb BETWEEN 1427 AND 2543.99 THEN 1
    WHEN uo_comb BETWEEN 2544 AND 6896 THEN 0
    WHEN uo_comb >6896 THEN 8
    ELSE NULL
    END AS urineoutput_oasis
  FROM merged_uo
)

-- Ventiliation -> Note: This information is stored in 5 tables
-- Create unified vent_table first
, merged_vent AS (

    -- 1: use patient table as base 
    SELECT pat.patientunitstayid, vent_1, vent_2, vent_3, vent_4
    FROM `physionet-data.eicu_crd.patient` AS pat

    -- 2: ventilation_events table
      LEFT JOIN(
        SELECT patientunitstayid,
        CASE WHEN ( MAX(event) = "mechvent start" OR MAX(event) = "mechvent end")THEN 1
        ELSE NULL
        END as vent_1
        FROM `physionet-data.eicu_crd_derived.ventilation_events` AS vent_events
        GROUP BY patientunitstayid
  )
  AS vent_events
  ON vent_events.patientunitstayid = pat.patientunitstayid 

    -- 3: apacheapsvar table
    LEFT JOIN(
      SELECT patientunitstayid, intubated as vent_2
      FROM `physionet-data.eicu_crd.apacheapsvar` AS apacheapsvar
      WHERE (intubated = 1)
  )
  AS apacheapsvar
  ON apacheapsvar.patientunitstayid = pat.patientunitstayid 
  
    -- 4: apachepredvar table
    LEFT JOIN(
      SELECT patientunitstayid, oobintubday1 as vent_3
      FROM `physionet-data.eicu_crd.apachepredvar` AS apachepredvar
      WHERE (oobintubday1 = 1)
  )
  AS apachepredvar
  ON apachepredvar.patientunitstayid = pat.patientunitstayid 
    
    
    -- 5: respiratory care table 
    LEFT JOIN(
      SELECT patientunitstayid, 
      CASE
      WHEN COUNT(airwaytype) >= 1 THEN 1
      WHEN COUNT(airwaysize) >= 1 THEN 1
      WHEN COUNT(airwayposition) >= 1 THEN 1
      WHEN COUNT(cuffpressure) >= 1 THEN 1
      WHEN COUNT(setapneatv) >= 1 THEN 1
      ELSE NULL
      END AS vent_4
      FROM `physionet-data.eicu_crd.respiratorycare` AS resp_care
      WHERE (respCareStatusOffset > 0 AND respCareStatusOffset <= 1440)
      GROUP BY patientunitstayid
  )
  AS resp_care
  ON resp_care.patientunitstayid = pat.patientunitstayid 
)

-- Call merged vent table in one go
, vent_oasis AS (
    SELECT patientunitstayid AS pid_vent
    , CASE
    WHEN vent_1 = 1 THEN 9
    WHEN vent_2 = 1 THEN 9
    WHEN vent_3 = 1 THEN 9
    WHEN vent_4 = 1 THEN 9
    ELSE 0
    END AS vent_oasis
    FROM merged_vent
    --WHERE (chartoffset > 0 AND chartoffset <= 1440) -- already considered in step above
)

, cohort_oasis AS (
  SELECT cohort.patientunitstayid, 
  pre_icu_los_oasis.pre_icu_los_oasis, 
  age_oasis.age_oasis, 
  gcs_oasis.gcs_oasis,
  heartrate_oasis.heartrate_oasis,
  map_oasis.map_oasis,
  respiratoryrate_oasis.respiratoryrate_oasis,
  temperature_oasis.temperature_oasis,
  urineoutput_oasis.urineoutput_oasis,
  vent_oasis.vent_oasis,
  electivesurgery_oasis.electivesurgery_oasis
  FROM `physionet-data.eicu_crd.patient` AS cohort

  LEFT JOIN pre_icu_los_oasis
  ON cohort.patientunitstayid = pre_icu_los_oasis.pid_LOS

  LEFT JOIN age_oasis
  ON cohort.patientunitstayid = age_oasis.pid_age 

  LEFT JOIN gcs_oasis
  ON cohort.patientunitstayid = gcs_oasis.pid_gcs 

  LEFT JOIN heartrate_oasis
  ON cohort.patientunitstayid = heartrate_oasis.pid_HR 

  LEFT JOIN map_oasis
  ON cohort.patientunitstayid = map_oasis.pid_MAP 

  LEFT JOIN respiratoryrate_oasis
  ON cohort.patientunitstayid = respiratoryrate_oasis.pid_RR

  LEFT JOIN temperature_oasis
  ON cohort.patientunitstayid = temperature_oasis.pid_temp

  LEFT JOIN urineoutput_oasis
  ON cohort.patientunitstayid = urineoutput_oasis.pid_urine

  LEFT JOIN vent_oasis
  ON cohort.patientunitstayid = vent_oasis.pid_vent

  LEFT JOIN electivesurgery_oasis
  ON cohort.patientunitstayid = electivesurgery_oasis.pid_adm

)

, score_impute AS (

SELECT cohort_oasis.*,

  IFNULL(pre_icu_los_oasis, 0) AS pre_icu_los_oasis_imp,
  IFNULL(age_oasis, 0) AS age_oasis_imp, 
  IFNULL(gcs_oasis, 0) AS gcs_oasis_imp, 
  IFNULL(heartrate_oasis, 0) AS heartrate_oasis_imp,
  IFNULL(map_oasis, 0) AS map_oasis_imp,
  IFNULL(respiratoryrate_oasis, 0) AS respiratoryrate_oasis_imp,
  IFNULL(temperature_oasis, 0) AS temperature_oasis_imp, 
  IFNULL(urineoutput_oasis, 0) AS urineoutput_oasis_imp, 
  IFNULL(vent_oasis, 0) AS vent_oasis_imp, 
  IFNULL(electivesurgery_oasis, 0) AS electivesurgery_oasis_imp, 

FROM cohort_oasis
)

--Compute overall score
-- oasis_null -> only cases where all components have a Non-NULL value
-- oasis_imp -> Imputation in case of NULL values, with 0's (common approach for severity of illness scores)
, score AS (
SELECT patientunitstayid, 
    MAX(pre_icu_los_oasis) AS pre_icu_los_oasis,
    MAX(age_oasis) AS age_oasis,
    MAX(gcs_oasis) AS gcs_oasis,
    MAX(heartrate_oasis) AS heartrate_oasis,
    MAX(map_oasis) AS map_oasis,
    MAX(respiratoryrate_oasis) AS respiratoryrate_oasis,
    MAX(temperature_oasis) AS temperature_oasis,
    MAX(urineoutput_oasis) AS urineoutput_oasis,
    MAX(vent_oasis) AS vent_oasis,
    MAX(electivesurgery_oasis) AS electivesurgery_oasis,
    MAX(pre_icu_los_oasis + 
        age_oasis + 
        gcs_oasis + 
        heartrate_oasis + 
        map_oasis + 
        respiratoryrate_oasis + 
        temperature_oasis + 
        urineoutput_oasis + 
        vent_oasis + 
        electivesurgery_oasis) AS oasis_null,
  
  MAX(pre_icu_los_oasis_imp) AS pre_icu_los_oasis_imp,
  MAX(age_oasis_imp) AS age_oasis_imp, 
  MAX(gcs_oasis_imp) AS gcs_oasis_imp, 
  MAX(heartrate_oasis_imp) AS heartrate_oasis_imp,
  MAX(map_oasis_imp) AS map_oasis_imp,
  MAX(respiratoryrate_oasis_imp) AS respiratoryrate_oasis_imp,
  MAX(temperature_oasis_imp) AS temperature_oasis_imp, 
  MAX(urineoutput_oasis_imp) AS urineoutput_oasis_imp, 
  MAX(vent_oasis_imp) AS vent_oasis_imp,
  MAX(electivesurgery_oasis_imp) AS electivesurgery_oasis_imp, 
  MAX(pre_icu_los_oasis_imp + 
      age_oasis_imp + 
      gcs_oasis_imp + 
      heartrate_oasis_imp + 
      map_oasis_imp + 
      respiratoryrate_oasis_imp + 
      temperature_oasis_imp + 
      urineoutput_oasis_imp + 
      vent_oasis_imp + 
      electivesurgery_oasis_imp) AS oasis_imp

FROM score_impute
GROUP BY patientunitstayid

)

-- Final statement to generate view
-- Note: single components contain NULL values, but not final OASIS score (NULL's replaced by 0, see above)
-- Code for above columns is retrained as convienience for user wanting to modify the view for other puroposes
SELECT patientunitstayid, 
pre_icu_los_oasis,
age_oasis,
gcs_oasis,
heartrate_oasis,
map_oasis,
respiratoryrate_oasis,
temperature_oasis,
urineoutput_oasis,
vent_oasis,
electivesurgery_oasis,
oasis_imp AS oasis
-- Calculate the probability of in-hospital mortality
, 1 / (1 + exp(- (-6.1746 + 0.1275*(oasis_imp) ))) AS oasis_prob

FROM score
;

