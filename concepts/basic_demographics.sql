-- ------------------------------------------------------------------
-- Title: Basic Demographics
-- Description: Extracts patient unique identifier, gender, age,
--              admission diagnosis, hospital mortality and
--              icu length of stay.
-- ------------------------------------------------------------------

SELECT pt.patientunitstayid, pt.age, pt.apacheadmissiondx,
       CASE WHEN pt.gender = 'Male' THEN 1
            WHEN pt.gender = 'Female' THEN 2
            ELSE NULL END AS gender,
       CASE WHEN pt.hospitaldischargestatus = 'Alive' THEN 0
            WHEN pt.hospitaldischargestatus = 'Expired' THEN 1
            ELSE NULL END AS hosp_mortality,
       ROUND(pt.unitdischargeoffset/60) AS icu_los_hours
FROM eicu_crd.patient pt
ORDER BY pt.patientunitstayid;
