-- ------------------------------------------------------------------  
-- Title: Basic Demographics
-- Description: Extracts patient unique identifier, gender, age, admission diagnosis, hospital mortality and icu length of stay.
-- Matthieu Komorowski, LCP MIT, 12/23/2016
-- eICU-CRD v1.0
-- ------------------------------------------------------------------  

select pt.patientunitstayid,
(case when pt.gender = 'Male' then 1 when pt.gender='Female' then 2 else null end) as gender,
pt.age,
pt.apacheadmissiondx,
(case When pt.hospitaldischargestatus = 'Alive' Then 0
when pt.hospitaldischargestatus = 'Expired' Then 1 else Null End ) as hospital_mortality,
round(pt.unitdischargeoffset/60) as icu_los_hours
from eicu.patient pt
order by pt.patientunitstayid
