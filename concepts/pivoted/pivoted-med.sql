DROP TABLE IF EXISTS pivoted_med CASCADE;
CREATE TABLE pivoted_med as
-- remove duplicate labs if they exist at the same time
with vw0 as
(
  select
    patientunitstayid
    -- due to issue in ETL, times of 0 should likely be null
    , case when drugorderoffset = 0 then null else drugorderoffset end as drugorderoffset
    , case when drugstartoffset = 0 then null else drugstartoffset end as drugstartoffset
    , case when drugstopoffset = 0 then null else drugstopoffset end as drugstopoffset

    -- assign our own identifier based off HICL codes
    -- the following codes have multiple drugs: 35779, 1874, 189
    , case
        when drughiclseqno in (37410, 36346, 2051) then 'norepinephrine'
        when drughiclseqno in (37407, 39089, 36437, 34361, 2050) then 'epinephrine'
        when drughiclseqno in (8777, 40) then 'dobutamine'
        when drughiclseqno in (2060, 2059) then 'dopamine'
        when drughiclseqno in (37028, 35517, 35587, 2087) then 'phenylephrine'
        when drughiclseqno in (38884, 38883, 2839) then 'vasopressin'
        when drughiclseqno in (9744) then 'milrinone'
        when drughiclseqno in (39654, 9545, 2807, 33442, 8643, 33314, 2808, 2810) then 'heparin'
        when drughiclseqno in (2812, 24859) then 'warfarin'
        -- now do missing HICL
        when drughiclseqno is null
          and lower(drugname) like '%heparin%' then 'heparin'
        when drughiclseqno is null
          and (lower(drugname) like '%warfarin%' OR lower(drugname) like '%coumadin%') then 'warfarin'

        when drughiclseqno is null
          and lower(drugname) like '%dobutamine%' then 'dobutamine'
        when drughiclseqno is null
          and lower(drugname) like '%dobutrex%' then 'dobutamine'
        when drughiclseqno is null
          and lower(drugname) like '%norepinephrine%' then 'norepinephrine'
        when drughiclseqno is null
          and lower(drugname) like '%levophed%' then 'norepinephrine'
        when drughiclseqno is null
          and lower(drugname) like 'epinephrine%' then 'epinephrine'
        when drughiclseqno is null
          and lower(drugname) like '%phenylephrine%' then 'phenylephrine'
        when drughiclseqno is null
          and lower(drugname) like '%neosynephrine%' then 'neosynephrine'
        when drughiclseqno is null
          and lower(drugname) like '%vasopressin%' then 'vasopressin'
        when drughiclseqno is null
          and lower(drugname) like '%milrinone%' then 'milrinone'
      else null end
        as drugname_structured

    -- raw identifiers
    , drugname, drughiclseqno, gtc

    -- delivery info
    , dosage, routeadmin, prn
    -- , loadingdose
  from medication m
  -- only non-zero dosages
  where dosage is not null
  -- not cancelled
  and drugordercancelled = 'No'
)
select
    patientunitstayid
  , drugorderoffset
  , drugstartoffset as chartoffset
  , drugstopoffset
  , max(case when drugname_structured = 'norepinephrine' then 1 else 0 end)::SMALLINT as norepinephrine
  , max(case when drugname_structured = 'epinephrine' then 1 else 0 end)::SMALLINT as epinephrine
  , max(case when drugname_structured = 'dopamine' then 1 else 0 end)::SMALLINT as dopamine
  , max(case when drugname_structured = 'dobutamine' then 1 else 0 end)::SMALLINT as dobutamine
  , max(case when drugname_structured = 'phenylephrine' then 1 else 0 end)::SMALLINT as phenylephrine
  , max(case when drugname_structured = 'vasopressin' then 1 else 0 end)::SMALLINT as vasopressin
  , max(case when drugname_structured = 'milrinone' then 1 else 0 end)::SMALLINT as milrinone
  , max(case when drugname_structured = 'heparin' then 1 else 0 end)::SMALLINT as heparin
  , max(case when drugname_structured = 'warfarin' then 1 else 0 end)::SMALLINT as warfarin
from vw0
WHERE
  -- have to have a start time
  drugstartoffset is not null
GROUP BY
  patientunitstayid, drugorderoffset, drugstartoffset, drugstopoffset
ORDER BY
  patientunitstayid, drugstartoffset, drugstopoffset, drugorderoffset;
