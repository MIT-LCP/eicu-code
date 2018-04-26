-- This script duplicates the nurse charting table, making the following changes:
--  "major" vital signs -> pivoted_vital
--  "minor" vital signs -> pivoted_vital_other
DROP TABLE IF EXISTS pivoted_vital CASCADE;
CREATE TABLE pivoted_vital as
-- create columns with only numeric data
with nc as
(
select
    patientunitstayid
  , nursingchartoffset
  , nursingchartentryoffset
  , case
      when nursingchartcelltypevallabel = 'Heart Rate'
       and nursingchartcelltypevalname = 'Heart Rate'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as heartrate
  , case
      when nursingchartcelltypevallabel = 'Respiratory Rate'
       and nursingchartcelltypevalname = 'Respiratory Rate'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as RespiratoryRate
  , case
      when nursingchartcelltypevallabel = 'O2 Saturation'
       and nursingchartcelltypevalname = 'O2 Saturation'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as o2saturation
  , case
      when nursingchartcelltypevallabel = 'Non-Invasive BP'
       and nursingchartcelltypevalname = 'Non-Invasive BP Systolic'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as nibp_systolic
  , case
      when nursingchartcelltypevallabel = 'Non-Invasive BP'
       and nursingchartcelltypevalname = 'Non-Invasive BP Diastolic'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as nibp_diastolic
  , case
      when nursingchartcelltypevallabel = 'Non-Invasive BP'
       and nursingchartcelltypevalname = 'Non-Invasive BP Mean'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as nibp_mean
  , case
      when nursingchartcelltypevallabel = 'Temperature'
       and nursingchartcelltypevalname = 'Temperature (C)'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as temperature
  , case
      when nursingchartcelltypevallabel = 'Temperature'
       and nursingchartcelltypevalname = 'Temperature Location'
          then nursingchartvalue
      else null end
    as TemperatureLocation
  , case
      when nursingchartcelltypevallabel = 'Invasive BP'
       and nursingchartcelltypevalname = 'Invasive BP Systolic'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as ibp_systolic
  , case
      when nursingchartcelltypevallabel = 'Invasive BP'
       and nursingchartcelltypevalname = 'Invasive BP Diastolic'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as ibp_diastolic
  , case
      when nursingchartcelltypevallabel = 'Invasive BP'
       and nursingchartcelltypevalname = 'Invasive BP Mean'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      -- other map fields
      when nursingchartcelltypevallabel = 'MAP (mmHg)'
       and nursingchartcelltypevalname = 'Value'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      when nursingchartcelltypevallabel = 'Arterial Line MAP (mmHg)'
       and nursingchartcelltypevalname = 'Value'
       and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
       and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as ibp_mean
  from nursecharting
  -- speed up by only looking at a subset of charted data
  where nursingchartcelltypecat in
  (
    'Vital Signs','Scores','Other Vital Signs and Infusions'
  )
)
select
  patientunitstayid
, nursingchartoffset as chartoffset
, nursingchartentryoffset as entryoffset
, avg(case when heartrate >= 25 and heartrate <= 225 then heartrate else null end) as heartrate
, avg(case when RespiratoryRate >= 0 and RespiratoryRate <= 60 then RespiratoryRate else null end) as RespiratoryRate
, avg(case when o2saturation >= 0 and o2saturation <= 100 then o2saturation else null end) as spo2
, avg(case when nibp_systolic >= 25 and nibp_systolic <= 250 then nibp_systolic else null end) as nibp_systolic
, avg(case when nibp_diastolic >= 1 and nibp_diastolic <= 200 then nibp_diastolic else null end) as nibp_diastolic
, avg(case when nibp_mean >= 1 and nibp_mean <= 250 then nibp_mean else null end) as nibp_mean
, avg(case when temperature >= 25 and temperature <= 46 then temperature else null end) as temperature
, max(temperaturelocation) as temperaturelocation
, avg(case when ibp_systolic >= 1 and ibp_systolic <= 300 then ibp_systolic else null end) as ibp_systolic
, avg(case when ibp_diastolic >= 1 and ibp_diastolic <= 200 then ibp_diastolic else null end) as ibp_diastolic
, avg(case when ibp_mean >= 1 and ibp_mean <= 250 then ibp_mean else null end) as ibp_mean
from nc
WHERE heartrate IS NOT NULL
OR RespiratoryRate IS NOT NULL
OR o2saturation IS NOT NULL
OR nibp_systolic IS NOT NULL
OR nibp_diastolic IS NOT NULL
OR nibp_mean IS NOT NULL
OR temperature IS NOT NULL
OR temperaturelocation IS NOT NULL
OR ibp_systolic IS NOT NULL
OR ibp_diastolic IS NOT NULL
OR ibp_mean IS NOT NULL
group by patientunitstayid, nursingchartoffset, nursingchartentryoffset
order by patientunitstayid, nursingchartoffset, nursingchartentryoffset;
