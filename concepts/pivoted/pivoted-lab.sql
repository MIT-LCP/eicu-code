DROP TABLE IF EXISTS pivoted_lab CASCADE;
CREATE TABLE pivoted_lab as
-- remove duplicate labs if they exist at the same time
with vw0 as
(
  select
      patientunitstayid
    , labname
    , labresultoffset
    , labresultrevisedoffset
  from lab
  where labname in
  (
      'albumin'
    , 'total bilirubin'
    , 'BUN'
    , 'calcium'
    , 'chloride'
    , 'creatinine'
    , 'bedside glucose', 'glucose'
    , 'bicarbonate' -- HCO3
    , 'Total CO2'
    , 'Hct'
    , 'Hgb'
    , 'PT - INR'
    , 'PTT'
    , 'lactate'
    , 'platelets x 1000'
    , 'potassium'
    , 'sodium'
    , 'WBC x 1000'
    , '-bands'
    -- Liver enzymes
    , 'ALT (SGPT)'
    , 'AST (SGOT)'
    , 'alkaline phos.'
  )
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
    , lab.labresultrevisedoffset
    , lab.labresult
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
  -- only valid lab values
  WHERE
       (lab.labname = 'albumin' and lab.labresult >= 0.5 and lab.labresult <= 6.5)
    OR (lab.labname = 'total bilirubin' and lab.labresult >= 0.2 and lab.labresult <= 70.175)
    OR (lab.labname = 'BUN' and lab.labresult >= 1 and lab.labresult <= 280)
    OR (lab.labname = 'calcium' and lab.labresult > 0 and lab.labresult <= 9999)
    OR (lab.labname = 'chloride' and lab.labresult > 0 and lab.labresult <= 9999)
    OR (lab.labname = 'creatinine' and lab.labresult >= 0.1 and lab.labresult <= 28.28)
    OR (lab.labname in ('bedside glucose', 'glucose') and lab.labresult >= 25 and lab.labresult <= 1500)
    OR (lab.labname = 'bicarbonate' and lab.labresult >= 0 and lab.labresult <= 9999)
    OR (lab.labname = 'Total CO2' and lab.labresult >= 0 and lab.labresult <= 9999)
    -- will convert hct unit to fraction later
    OR (lab.labname = 'Hct' and lab.labresult >= 5 and lab.labresult <= 75)
    OR (lab.labname = 'Hgb' and lab.labresult >  0 and lab.labresult <= 9999)
    OR (lab.labname = 'PT - INR' and lab.labresult >= 0.5 and lab.labresult <= 15)
    OR (lab.labname = 'lactate' and lab.labresult >= 0.1 and lab.labresult <= 30)
    OR (lab.labname = 'platelets x 1000' and lab.labresult >  0 and lab.labresult <= 9999)
    OR (lab.labname = 'potassium' and lab.labresult >= 0.05 and lab.labresult <= 12)
    OR (lab.labname = 'PTT' and lab.labresult >  0 and lab.labresult <= 500)
    OR (lab.labname = 'sodium' and lab.labresult >= 90 and lab.labresult <= 215)
    OR (lab.labname = 'WBC x 1000' and lab.labresult > 0 and lab.labresult <= 100)
    OR (lab.labname = '-bands' and lab.labresult >= 0 and lab.labresult <= 100)
    OR (lab.labname = 'ALT (SGPT)' and lab.labresult > 0)
    OR (lab.labname = 'AST (SGOT)' and lab.labresult > 0)
    OR (lab.labname = 'alkaline phos.' and lab.labresult > 0)
)
select
    patientunitstayid
  , labresultoffset as chartoffset
  , MAX(case when labname = 'albumin' then labresult else null end) as albumin
  , MAX(case when labname = 'total bilirubin' then labresult else null end) as bilirubin
  , MAX(case when labname = 'BUN' then labresult else null end) as BUN
  , MAX(case when labname = 'calcium' then labresult else null end) as calcium
  , MAX(case when labname = 'chloride' then labresult else null end) as chloride
  , MAX(case when labname = 'creatinine' then labresult else null end) as creatinine
  , MAX(case when labname in ('bedside glucose', 'glucose') then labresult else null end) as glucose
  , MAX(case when labname = 'bicarbonate' then labresult else null end) as bicarbonate
  , MAX(case when labname = 'Total CO2' then labresult else null end) as TotalCO2
  , MAX(case when labname = 'Hct' then labresult else null end) as hematocrit
  , MAX(case when labname = 'Hgb' then labresult else null end) as hemoglobin
  , MAX(case when labname = 'PT - INR' then labresult else null end) as INR
  , MAX(case when labname = 'lactate' then labresult else null end) as lactate
  , MAX(case when labname = 'platelets x 1000' then labresult else null end) as platelets
  , MAX(case when labname = 'potassium' then labresult else null end) as potassium
  , MAX(case when labname = 'PTT' then labresult else null end) as ptt
  , MAX(case when labname = 'sodium' then labresult else null end) as sodium
  , MAX(case when labname = 'WBC x 1000' then labresult else null end) as wbc
  , MAX(case when labname = '-bands' then labresult else null end) as bands
  , MAX(case when labname = 'ALT (SGPT)' then labresult else null end) as alt
  , MAX(case when labname = 'AST (SGOT)' then labresult else null end) as ast
  , MAX(case when labname = 'alkaline phos.' then labresult else null end) as alp
from vw1
where rn = 1
group by patientunitstayid, labresultoffset
order by patientunitstayid, labresultoffset;
