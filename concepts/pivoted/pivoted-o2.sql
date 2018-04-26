DROP TABLE IF EXISTS pivoted_o2 CASCADE;
CREATE TABLE pivoted_o2 as
-- create columns with only numeric data
with nc as
(
select
    patientunitstayid
  , nursingchartoffset
  , nursingchartentryoffset
  , case
        WHEN nursingchartcelltypevallabel = 'O2 L/%'
        AND  nursingchartcelltypevalname = 'O2 L/%'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as o2_flow
  , case
        WHEN nursingchartcelltypevallabel = 'O2 Admin Device'
        AND  nursingchartcelltypevalname = 'O2 Admin Device'
          then nursingchartvalue
      else null end
    as o2_device
  , case
        WHEN nursingchartcelltypevallabel = 'End Tidal CO2'
        AND  nursingchartcelltypevalname = 'End Tidal CO2'
        -- verify it's numeric
        AND nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$' and nursingchartvalue not in ('-','.')
          then cast(nursingchartvalue as numeric)
      else null end
    as etco2
  from nursecharting
  -- speed up by only looking at a subset of charted data
  where nursingchartcelltypecat = 'Vital Signs'
)
select
  patientunitstayid
, nursingchartoffset as chartoffset
, nursingchartentryoffset as entryoffset
, AVG(CASE WHEN o2_flow >= 0 AND o2_flow <= 100 THEN o2_flow ELSE NULL END) AS o2_flow
, MAX(o2_device) AS o2_device
, AVG(CASE WHEN etco2 >= 0 AND etco2 <= 1000 THEN etco2 ELSE NULL END) AS etco2
from nc
WHERE o2_flow    IS NOT NULL
   OR o2_device  IS NOT NULL
   OR etco2      IS NOT NULL
group by patientunitstayid, nursingchartoffset, nursingchartentryoffset
order by patientunitstayid, nursingchartoffset, nursingchartentryoffset;
