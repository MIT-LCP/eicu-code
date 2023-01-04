
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
pre_ICU_LOS_OASIS AS (
SELECT patientunitstayid AS pid_LOS
  ,CASE
      WHEN hospitaladmitoffset > (-0.17*60) THEN 5
      WHEN hospitaladmitoffset BETWEEN (-4.94*60) AND (-0.17*60) THEN 3
      WHEN hospitaladmitoffset BETWEEN (-24*60) AND (-4.94*60) THEN 0
      WHEN hospitaladmitoffset BETWEEN (-311.80*60) AND (-24.0*60) THEN 2
      WHEN hospitaladmitoffset < (-311.80*60) THEN 1
      ELSE NULL
      END AS pre_ICU_LOS_OASIS
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
, age_OASIS AS (
    SELECT patientunitstayid AS pid_age
    , CASE
    WHEN MAX(age_num) < 24 THEN 0
    WHEN MAX(age_num) BETWEEN 24 AND 53 THEN 3
    WHEN MAX(age_num) BETWEEN 54 AND 77 THEN 6
    WHEN MAX(age_num) BETWEEN 78 AND 89 THEN 9
    WHEN MAX(age_num) > 89 THEN 7
    ELSE NULL
    END AS age_OASIS
    FROM age_numeric
)

-- GCS, Glasgow Coma Scale
-- Merge information from two tables into one
, merged_GCS AS (
    
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

-- Only keep minimal GCS from merged_GCS table
, least_GCS AS (
    SELECT patientunitstayid,
    LEAST(gcs1, gcs2) as gcs
    FROM merged_GCS
)

-- Call merged_GCS table in one go
, GCS_OASIS AS (
    SELECT patientunitstayid AS pid_GCS
    , CASE
    WHEN MIN(gcs) < 8 THEN 10
    WHEN MIN(gcs) BETWEEN 8 AND 13 THEN 4
    WHEN MIN(gcs) = 14 THEN 3
    WHEN MIN(gcs) = 15 THEN 0
    ELSE NULL
    END AS GCS_OASIS
    FROM least_GCS
    --WHERE (chartoffset > 0 AND chartoffset <= 1440) -- already considered in step above
    GROUP BY pid_GCS
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

, electivesurgery_OASIS AS (
  SELECT patientunitstayid AS pid_adm
  , CASE
    WHEN electivesurgery1 = 0 THEN 6
    WHEN electivesurgery1 IS NULL THEN 6
    WHEN adm_elective1 = 0 THEN 6
    ELSE 0
    END AS electivesurgery_OASIS
  FROM elective_surgery
)

-- Heart rate 
, heartrate_OASIS AS (
SELECT patientunitstayid AS pid_HR
  , CASE
    WHEN MIN(heartrate) < 33 THEN 4
    WHEN MAX(heartrate) BETWEEN 33 AND 88 THEN 0
    WHEN MAX(heartrate) BETWEEN 89 AND 106 THEN 1
    WHEN MAX(heartrate) BETWEEN 107 AND 125 THEN 3
    WHEN MAX(heartrate) > 125 THEN 6
    ELSE NULL
    END AS heartrate_OASIS
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND heartrate IS NOT NULL
  GROUP BY pid_HR
)

-- Mean arterial pressure
, MAP_OASIS AS (
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
    END AS MAP_OASIS
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
  GROUP BY pid_MAP
)

-- Respiratory rate
, respiratoryrate_OASIS AS (
SELECT patientunitstayid AS pid_RR
  , CASE
    WHEN MIN(respiratoryrate) < 6 THEN 10
    WHEN MIN(respiratoryrate) BETWEEN 6 AND 12 THEN 1
    WHEN MIN(respiratoryrate) BETWEEN 13 AND 22 THEN 0
    WHEN MAX(respiratoryrate) BETWEEN 23 AND 30 THEN 1
    WHEN MAX(respiratoryrate) BETWEEN 31 AND 44 THEN 6
    WHEN MAX(respiratoryrate) > 44 THEN 9
    ELSE NULL
    END AS respiratoryrate_OASIS

  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND respiratoryrate IS NOT NULL
  GROUP BY pid_RR
)

-- Temperature 
, temperature_OASIS AS (
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
    END AS temperature_OASIS
  FROM `physionet-data.eicu_crd_derived.pivoted_vital`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND temperature IS NOT NULL
  GROUP BY pid_temp
)

-- Urine output
, urineoutput_OASIS AS (
  SELECT patientunitstayid AS pid_urine
  , CASE
    WHEN SUM(urineoutput) <671 THEN 10
    WHEN SUM(urineoutput) BETWEEN 671 AND 1426.99 THEN 5
    WHEN SUM(urineoutput) BETWEEN 1427 AND 2543.99 THEN 1
    WHEN SUM(urineoutput) BETWEEN 2544 AND 6896 THEN 0
    WHEN SUM(urineoutput) >6896 THEN 8
    ELSE NULL
    END AS urineoutput_OASIS

  FROM `physionet-data.eicu_crd_derived.pivoted_uo`
  WHERE (chartoffset > 0 AND chartoffset <= 1440) -- consider only first 24h
    AND urineoutput IS NOT NULL
  GROUP BY pid_urine
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
, VENT_OASIS AS (
    SELECT patientunitstayid AS pid_vent
    , CASE
    WHEN vent_1 = 1 THEN 9
    WHEN vent_2 = 1 THEN 9
    WHEN vent_3 = 1 THEN 9
    WHEN vent_4 = 1 THEN 9
    ELSE 0
    END AS VENT_OASIS
    FROM merged_vent
    --WHERE (chartoffset > 0 AND chartoffset <= 1440) -- already considered in step above
)

, cohort_OASIS AS (
  SELECT cohort.patientunitstayid, 
  pre_ICU_LOS_OASIS.pre_ICU_LOS_OASIS, 
  age_OASIS.age_OASIS, 
  GCS_OASIS.GCS_OASIS,
  heartrate_OASIS.heartrate_OASIS,
  MAP_OASIS.MAP_OASIS,
  respiratoryrate_OASIS.respiratoryrate_OASIS,
  temperature_OASIS.temperature_OASIS,
  urineoutput_OASIS.urineoutput_OASIS,
  VENT_OASIS.VENT_OASIS,
  electivesurgery_OASIS.electivesurgery_OASIS
  FROM  `physionet-data.eicu_crd.patient` AS cohort

  LEFT JOIN pre_ICU_LOS_OASIS
  ON cohort.patientunitstayid = pre_ICU_LOS_OASIS.pid_LOS

  LEFT JOIN age_OASIS
  ON cohort.patientunitstayid = age_OASIS.pid_age 

  LEFT JOIN GCS_OASIS
  ON cohort.patientunitstayid = GCS_OASIS.pid_GCS 

  LEFT JOIN heartrate_OASIS
  ON cohort.patientunitstayid = heartrate_OASIS.pid_HR 

  LEFT JOIN MAP_OASIS
  ON cohort.patientunitstayid = MAP_OASIS.pid_MAP 

  LEFT JOIN respiratoryrate_OASIS
  ON cohort.patientunitstayid = respiratoryrate_OASIS.pid_RR

  LEFT JOIN temperature_OASIS
  ON cohort.patientunitstayid = temperature_OASIS.pid_temp

  LEFT JOIN urineoutput_OASIS
  ON cohort.patientunitstayid = urineoutput_OASIS.pid_urine

  LEFT JOIN VENT_OASIS
  ON cohort.patientunitstayid = VENT_OASIS.pid_vent

  LEFT JOIN electivesurgery_OASIS
  ON cohort.patientunitstayid = electivesurgery_OASIS.pid_adm

)

, score_impute AS (

SELECT cohort_OASIS.*,

  IFNULL(pre_ICU_LOS_OASIS, 0) AS pre_ICU_LOS_OASIS_Imp,
  IFNULL(age_OASIS, 0) AS age_OASIS_Imp, 
  IFNULL(GCS_OASIS, 0) AS GCS_OASIS_Imp, 
  IFNULL(heartrate_OASIS, 0) AS heartrate_OASIS_Imp,
  IFNULL(MAP_OASIS, 0) AS MAP_OASIS_Imp,
  IFNULL(respiratoryrate_OASIS, 0) AS respiratoryrate_OASIS_Imp,
  IFNULL(temperature_OASIS, 0) AS temperature_OASIS_Imp, 
  IFNULL(urineoutput_OASIS, 0) AS urineoutput_OASIS_Imp, 
  IFNULL(VENT_OASIS, 0) AS VENT_OASIS_Imp, 
  IFNULL(electivesurgery_OASIS, 0) AS electivesurgery_OASIS_Imp, 

FROM cohort_OASIS
)

--Compute overall score
-- OASIS_NULL -> only cases where all components have a Non-NULL value
-- OASIS_Imp -> Imputation in case of NULL values, with 0's (common approach for severity of illness scores)
, score AS (
SELECT patientunitstayid, 
    MAX(pre_ICU_LOS_OASIS) AS pre_ICU_LOS_OASIS,
    MAX(age_OASIS) AS age_OASIS,
    MAX(GCS_OASIS) AS GCS_OASIS,
    MAX(heartrate_OASIS) AS heartrate_OASIS,
    MAX(MAP_OASIS) AS MAP_OASIS,
    MAX(respiratoryrate_OASIS) AS respiratoryrate_OASIS,
    MAX(temperature_OASIS) AS temperature_OASIS,
    MAX(urineoutput_OASIS) AS urineoutput_OASIS,
    MAX(VENT_OASIS) AS VENT_OASIS,
    MAX(electivesurgery_OASIS) AS electivesurgery_OASIS,
    MAX(pre_ICU_LOS_OASIS + 
        age_OASIS + 
        GCS_OASIS + 
        heartrate_OASIS + 
        MAP_OASIS + 
        respiratoryrate_OASIS + 
        temperature_OASIS + 
        urineoutput_OASIS + 
        VENT_OASIS + 
        electivesurgery_OASIS) AS OASIS_NULL,
  
  MAX(pre_ICU_LOS_OASIS_Imp) AS pre_ICU_LOS_OASIS_Imp,
  MAX(age_OASIS_Imp) AS age_OASIS_Imp, 
  MAX(GCS_OASIS_Imp) AS GCS_OASIS_Imp, 
  MAX(heartrate_OASIS_Imp) AS heartrate_OASIS_Imp,
  MAX(MAP_OASIS_Imp) AS MAP_OASIS_Imp,
  MAX(respiratoryrate_OASIS_Imp) AS respiratoryrate_OASIS_Imp,
  MAX(temperature_OASIS_Imp) AS temperature_OASIS_Imp, 
  MAX(urineoutput_OASIS_Imp) AS urineoutput_OASIS_Imp, 
  MAX(VENT_OASIS_Imp) AS VENT_OASIS_Imp,
  MAX(electivesurgery_OASIS_Imp) AS electivesurgery_OASIS_Imp, 
  MAX(pre_ICU_LOS_OASIS_Imp + 
      age_OASIS_Imp + 
      GCS_OASIS_Imp + 
      heartrate_OASIS_Imp + 
      MAP_OASIS_Imp + 
      respiratoryrate_OASIS_Imp + 
      temperature_OASIS_Imp + 
      urineoutput_OASIS_Imp + 
      VENT_OASIS_Imp + 
      electivesurgery_OASIS_Imp) AS OASIS_Imp

FROM score_impute
GROUP BY patientunitstayid

)

SELECT patientunitstayid, 
pre_ICU_LOS_OASIS, pre_ICU_LOS_OASIS_Imp,
age_OASIS, age_OASIS_Imp,
GCS_OASIS, GCS_OASIS_Imp,
heartrate_OASIS, heartrate_OASIS_Imp,
MAP_OASIS, MAP_OASIS_Imp,
respiratoryrate_OASIS, respiratoryrate_OASIS_Imp,
temperature_OASIS, temperature_OASIS_Imp,
urineoutput_OASIS, urineoutput_OASIS_Imp,
VENT_OASIS, VENT_OASIS_Imp,
electivesurgery_OASIS, electivesurgery_OASIS_Imp,
OASIS_Null, OASIS_Imp
-- Calculate the probability of in-hospital mortality
, 1 / (1 + exp(- (-6.1746 + 0.1275*(OASIS_Null) ))) AS OASIS_Prob_Null
, 1 / (1 + exp(- (-6.1746 + 0.1275*(OASIS_Imp) ))) AS OASIS_Prob_Imp

FROM score
;

