-- This script groups together like vital signs on the same row
--  "major" vital signs (frequently measured) -> pivoted_vital
--  "minor" vital signs (infrequently measured) -> pivoted_vital_other
DROP TABLE IF EXISTS pivoted_vital_other CASCADE;
CREATE TABLE pivoted_vital_other as
-- create columns with only numeric data
with nc as
(
select
    patientunitstayid
  , nursingchartoffset
  , nursingchartentryoffset
  -- pivot data - choose column names for consistency with vitalperiodic
  , case
        WHEN nursingchartcelltypevallabel = 'PA'
        AND  nursingchartcelltypevalname = 'PA Systolic'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as pasystolic
  , case
        WHEN nursingchartcelltypevallabel = 'PA'
        AND  nursingchartcelltypevalname = 'PA Diastolic'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as padiastolic
  , case
        WHEN nursingchartcelltypevallabel = 'PA'
        AND  nursingchartcelltypevalname = 'PA Mean'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as pamean
  , case
        WHEN nursingchartcelltypevallabel = 'SV'
        AND  nursingchartcelltypevalname = 'SV'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as sv
  , case
        WHEN nursingchartcelltypevallabel = 'CO'
        AND  nursingchartcelltypevalname = 'CO'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as co
  , case
        WHEN nursingchartcelltypevallabel = 'SVR'
        AND  nursingchartcelltypevalname = 'SVR'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as svr
  , case
        WHEN nursingchartcelltypevallabel = 'ICP'
        AND  nursingchartcelltypevalname = 'ICP'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as icp
  , case
        WHEN nursingchartcelltypevallabel = 'CI'
        AND  nursingchartcelltypevalname = 'CI'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as ci
  , case
        WHEN nursingchartcelltypevallabel = 'SVRI'
        AND  nursingchartcelltypevalname = 'SVRI'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as svri
  , case
        WHEN nursingchartcelltypevallabel = 'CPP'
        AND  nursingchartcelltypevalname = 'CPP'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as cpp
  , case
        WHEN nursingchartcelltypevallabel = 'SVO2'
        AND  nursingchartcelltypevalname = 'SVO2'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as svo2
  , case
        WHEN nursingchartcelltypevallabel = 'PAOP'
        AND  nursingchartcelltypevalname = 'PAOP'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as paop
  , case
        WHEN nursingchartcelltypevallabel = 'PVR'
        AND  nursingchartcelltypevalname = 'PVR'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as pvr
  , case
        WHEN nursingchartcelltypevallabel = 'PVRI'
        AND  nursingchartcelltypevalname = 'PVRI'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as pvri
  , case
      WHEN nursingchartcelltypevallabel = 'IAP'
      AND  nursingchartcelltypevalname = 'IAP'
      -- verify it's numeric
      AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    else null end
  as iap
  from nursecharting
  -- speed up by only looking at a subset of charted data
  where nursingchartcelltypecat = 'Vital Signs'
)
select
  patientunitstayid
, nursingchartoffset as chartoffset
, nursingchartentryoffset as entryoffset
, AVG(CASE WHEN pasystolic >= 0 AND pasystolic <= 1000 THEN pasystolic ELSE NULL END) AS pasystolic
, AVG(CASE WHEN padiastolic >= 0 AND padiastolic <= 1000 THEN padiastolic ELSE NULL END) AS padiastolic
, AVG(CASE WHEN pamean >= 0 AND pamean <= 1000 THEN pamean ELSE NULL END) AS pamean
, AVG(CASE WHEN sv >= 0 AND sv <= 1000 THEN sv ELSE NULL END) AS sv
, AVG(CASE WHEN co >= 0 AND co <= 1000 THEN co ELSE NULL END) AS co
, AVG(CASE WHEN svr >= 0 AND svr <= 1000 THEN svr ELSE NULL END) AS svr
, AVG(CASE WHEN icp >= 0 AND icp <= 1000 THEN icp ELSE NULL END) AS icp
, AVG(CASE WHEN ci >= 0 AND ci <= 1000 THEN ci ELSE NULL END) AS ci
, AVG(CASE WHEN svri >= 0 AND svri <= 1000 THEN svri ELSE NULL END) AS svri
, AVG(CASE WHEN cpp >= 0 AND cpp <= 1000 THEN cpp ELSE NULL END) AS cpp
, AVG(CASE WHEN svo2 >= 0 AND svo2 <= 1000 THEN svo2 ELSE NULL END) AS svo2
, AVG(CASE WHEN paop >= 0 AND paop <= 1000 THEN paop ELSE NULL END) AS paop
, AVG(CASE WHEN pvr >= 0 AND pvr <= 1000 THEN pvr ELSE NULL END) AS pvr
, AVG(CASE WHEN pvri >= 0 AND pvri <= 1000 THEN pvri ELSE NULL END) AS pvri
, AVG(CASE WHEN iap >= 0 AND iap <= 1000 THEN iap ELSE NULL END) AS iap
from nc
WHERE pasystolic IS NOT NULL
OR padiastolic IS NOT NULL
OR pamean IS NOT NULL
OR sv IS NOT NULL
OR co IS NOT NULL
OR svr IS NOT NULL
OR icp IS NOT NULL
OR ci IS NOT NULL
OR svri IS NOT NULL
OR cpp IS NOT NULL
OR svo2 IS NOT NULL
OR paop IS NOT NULL
OR pvr IS NOT NULL
OR pvri IS NOT NULL
OR iap IS NOT NULL
group by patientunitstayid, nursingchartoffset, nursingchartentryoffset
order by patientunitstayid, nursingchartoffset, nursingchartentryoffset;
