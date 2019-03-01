-- Pivot creatinine so each patient has 1 observation per row
-- Note that, unlike pivoted-lab.sql, this query searches for data across the
-- entire patient's hospitalization. If found, it copies the data to the current
-- patient unit stay id, and adjusts the offsets accordingly. This means that
-- if a patient is admitted to the ICU twice, all of their creatinine measurements
-- for that hospitalization are stored in this table under two distinct patientunitstayid.
DROP TABLE IF EXISTS pivoted_creatinine CASCADE;
CREATE TABLE pivoted_creatinine as
-- vw0 used to remove duplicate labs if they exist at the same time
with vw0 as
(
  select
      patientunitstayid
    , labname
    , labresultoffset
    , labresultrevisedoffset
  from lab
  where labname = 'creatinine'
  group by patientunitstayid, labname, labresultoffset, labresultrevisedoffset
  having count(distinct labresult)<=1
)
-- get the last lab to be revised
, vw1 as
(
  select
      lab.patientunitstayid
    , lab.labname
    , lab.labresultoffset
    -- convert values of "<0.1" to 0.1 (float)
    , CASE
        WHEN labresult IS NULL AND (labresulttext IS NULL OR labresulttext = '')
            THEN NULL
        WHEN labresult IS NULL 
            THEN CAST(REGEXP_REPLACE(labresulttext, '([><])', '') AS NUMERIC)
        ELSE labresult
      END as labresult
    , ROW_NUMBER() OVER
    (
        PARTITION BY lab.patientunitstayid, lab.labname, lab.labresultoffset
        ORDER BY lab.labresultrevisedoffset DESC
    ) as rn
  from lab
  inner join vw0
    ON  lab.patientunitstayid = vw0.patientunitstayid
    AND lab.labname = vw0.labname
    AND lab.labresultoffset = vw0.labresultoffset
    AND lab.labresultrevisedoffset = vw0.labresultrevisedoffset
  -- filter values based on physiologic plausibility
  WHERE (lab.labname = 'creatinine' and lab.labresult >= 0.1 and lab.labresult <= 28.28)
)
, vw2 as
(
    select
      patientunitstayid
    , labresultoffset as chartoffset
    , MAX(case when labname = 'creatinine' then labresult else null end) as creatinine
    from vw1
    where rn = 1
    group by patientunitstayid, labresultoffset
)
-- join to patient table to add in hospital identifier and offset
, vw3 as
(
    select pt.patienthealthsystemstayid
    -- , vw2.chartoffset
    , vw2.chartoffset - pt.hospitaladmitoffset as admitoffset
    , vw2.creatinine
    from vw2
    inner join patient pt
      on vw2.patientunitstayid = pt.patientunitstayid
)
-- duplicate rows within a hospitalization
-- this ensures each patientunitstayid has all data associated with that hospitalization
SELECT pt.patientunitstayid
-- readjust the data to be based off this patient's ICU admission
, vw3.admitoffset + pt.hospitaladmitoffset as chartoffset
, vw3.creatinine
FROM vw3
-- intentionally duplicate rows
INNER JOIN patient pt
    ON vw3.patienthealthsystemstayid = pt.patienthealthsystemstayid
ORDER BY patientunitstayid, chartoffset;