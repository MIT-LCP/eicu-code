-- ------------------------------------------------------------------
-- Title: ICU stay detail
-- Description: Each row represents a single ICU stay. Patient demographics
--        are summarised for each stay.
-- ------------------------------------------------------------------

-- (Optional) Define which schema to work on
-- SET search_path TO eicu_crd;

DROP MATERIALIZED VIEW IF EXISTS icustay_detail CASCADE;
CREATE MATERIALIZED VIEW icustay_detail as (

SELECT pt.uniquepid, pt.patienthealthsystemstayid, pt.patientunitstayid, pt.unitvisitnumber,
       pt.hospitalid, h.region, pt.unittype,
       pt.hospitaladmitoffset, pt.hospitaldischargeoffset,
       0 AS unitadmitoffset, pt.unitdischargeoffset,
       ap.apachescore AS apache_iv,
       pt.hospitaldischargeyear,
       pt.age,
       CASE WHEN lower(pt.hospitaldischargestatus) like '%alive%' THEN 0
            WHEN lower(pt.hospitaldischargestatus) like '%expired%' THEN 1
            ELSE NULL END AS hosp_mort,
       CASE WHEN lower(pt.gender) like '%female%' THEN 0
            WHEN lower(pt.gender) like '%male%' THEN 1
            ELSE NULL END AS gender,
       pt.ethnicity, pt.admissionheight, pt.admissionweight, pt.dischargeweight,
       ROUND(pt.unitdischargeoffset/60) AS icu_los_hours
FROM patient pt
LEFT JOIN hospital h
    ON pt.hospitalid = h.hospitalid
LEFT JOIN apachepatientresult ap
    ON pt.patientunitstayid = ap.patientunitstayid
    AND ap.apacheversion = 'IV'
ORDER BY pt.uniquepid, pt.unitvisitnumber, pt.age
);
