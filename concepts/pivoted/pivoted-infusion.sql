-- Extract a subset of infusions
-- NOTE: I couldn't find warfarin/coumadin.

DROP TABLE IF EXISTS pivoted_infusion CASCADE;
CREATE TABLE pivoted_infusion as
with vw0 as
(
  select
    patientunitstayid
    , infusionoffset
    -- TODO: need dopamine rate
    , max(case when drugname in
              (
                   'Dopamine'
                 , 'Dopamine ()'
                 , 'DOPamine MAX 800 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'
                 , 'Dopamine (mcg/hr)'
                 , 'Dopamine (mcg/kg/hr)'
                 , 'dopamine (mcg/kg/min)'
                 , 'Dopamine (mcg/kg/min)'
                 , 'Dopamine (mcg/min)'
                 , 'Dopamine (mg/hr)'
                 , 'Dopamine (ml/hr)'
                 , 'Dopamine (nanograms/kg/min)'
                 , 'DOPamine STD 15 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'
                 , 'DOPamine STD 400 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'
                 , 'DOPamine STD 400 mg Dextrose 5% 500 ml  Premix (mcg/kg/min)'
                 , 'Dopamine (Unknown)'
              )
              -- note: no rows found for inotropin
                then 1
              else null end
            ) as dopamine

    -- this like statement is pretty reliable - no false positives when I checked
    -- also catches the brand name dobutrex
    , max(case when lower(drugname) like '%dobu%' then 1 else null end) as dobutamine
    , max(case
              when drugname in
              (
                 'Norepinephrine'
               , 'Norepinephrine ()'
               , 'Norepinephrine MAX 32 mg Dextrose 5% 250 ml (mcg/min)'
               , 'Norepinephrine MAX 32 mg Dextrose 5% 500 ml (mcg/min)'
               , 'Norepinephrine (mcg/hr)'
               , 'Norepinephrine (mcg/kg/hr)'
               , 'Norepinephrine (mcg/kg/min)'
               , 'Norepinephrine (mcg/min)'
               , 'Norepinephrine (mg/hr)'
               , 'Norepinephrine (mg/kg/min)'
               , 'Norepinephrine (mg/min)'
               , 'Norepinephrine (ml/hr)'
               , 'Norepinephrine STD 32 mg Dextrose 5% 282 ml (mcg/min)'
               , 'Norepinephrine STD 32 mg Dextrose 5% 500 ml (mcg/min)'
               , 'Norepinephrine STD 4 mg Dextrose 5% 250 ml (mcg/min)'
               , 'Norepinephrine STD 4 mg Dextrose 5% 500 ml (mcg/min)'
               , 'Norepinephrine STD 8 mg Dextrose 5% 250 ml (mcg/min)'
               , 'Norepinephrine STD 8 mg Dextrose 5% 500 ml (mcg/min)'
               , 'Norepinephrine (units/min)'
               , 'Norepinephrine (Unknown)'
               , 'norepinephrine Volume (ml)'
               , 'norepinephrine Volume (ml) (ml/hr)'
               -- levophed
              , 'Levophed (mcg/kg/min)'
              , 'levophed  (mcg/min)'
              , 'levophed (mcg/min)'
              , 'Levophed (mcg/min)'
              , 'Levophed (mg/hr)'
              , 'levophed (ml/hr)'
              , 'Levophed (ml/hr)'
              , 'NSS with LEVO (ml/hr)'
              , 'NSS w/ levo/vaso (ml/hr)'
              )
          then 1 else 0 end) as norepinephrine
    , max(case
          when drugname in
          (
             'Phenylephrine'
           , 'Phenylephrine ()'
           , 'Phenylephrine  MAX 100 mg Sodium Chloride 0.9% 250 ml (mcg/min)'
           , 'Phenylephrine (mcg/hr)'
           , 'Phenylephrine (mcg/kg/min)'
           , 'Phenylephrine (mcg/kg/min) (mcg/kg/min)'
           , 'Phenylephrine (mcg/min)'
           , 'Phenylephrine (mcg/min) (mcg/min)'
           , 'Phenylephrine (mg/hr)'
           , 'Phenylephrine (mg/kg/min)'
           , 'Phenylephrine (ml/hr)'
           , 'Phenylephrine  STD 20 mg Sodium Chloride 0.9% 250 ml (mcg/min)'
           , 'Phenylephrine  STD 20 mg Sodium Chloride 0.9% 500 ml (mcg/min)'
           , 'Volume (ml) Phenylephrine'
           , 'Volume (ml) Phenylephrine ()'
           -- neosynephrine is a synonym
           , 'neo-synephrine (mcg/min)'
           , 'neosynephrine (mcg/min)'
           , 'Neosynephrine (mcg/min)'
           , 'Neo Synephrine (mcg/min)'
           , 'Neo-Synephrine (mcg/min)'
           , 'NeoSynephrine (mcg/min)'
           , 'NEO-SYNEPHRINE (mcg/min)'
           , 'Neosynephrine (ml/hr)'
           , 'neosynsprine'
           , 'neosynsprine (mcg/kg/hr)'
          )
        then 1 else 0 end) as phenylephrine
    , max(case
            when drugname in
            (
                 'EPI (mcg/min)'
               , 'Epinepherine (mcg/min)'
               , 'Epinephrine'
               , 'Epinephrine ()'
               , 'EPINEPHrine(Adrenalin)MAX 30 mg Sodium Chloride 0.9% 250 ml (mcg/min)'
               , 'EPINEPHrine(Adrenalin)STD 4 mg Sodium Chloride 0.9% 250 ml (mcg/min)'
               , 'EPINEPHrine(Adrenalin)STD 4 mg Sodium Chloride 0.9% 500 ml (mcg/min)'
               , 'EPINEPHrine(Adrenalin)STD 7 mg Sodium Chloride 0.9% 250 ml (mcg/min)'
               , 'Epinephrine (mcg/hr)'
               , 'Epinephrine (mcg/kg/min)'
               , 'Epinephrine (mcg/min)'
               , 'Epinephrine (mg/hr)'
               , 'Epinephrine (mg/kg/min)'
               , 'Epinephrine (ml/hr)'
            ) then 1 else 0 end)
          as epinephrine
    , max(case
            when drugname in
            (
                'Vasopressin'
              , 'Vasopressin ()'
              , 'Vasopressin 20 Units Sodium Chloride 0.9% 100 ml (units/hr)'
              , 'Vasopressin 20 Units Sodium Chloride 0.9% 250 ml (units/hr)'
              , 'Vasopressin 40 Units Sodium Chloride 0.9% 100 ml (units/hr)'
              , 'Vasopressin 40 Units Sodium Chloride 0.9% 100 ml (units/kg/hr)'
              , 'Vasopressin 40 Units Sodium Chloride 0.9% 100 ml (units/min)'
              , 'Vasopressin 40 Units Sodium Chloride 0.9% 100 ml (Unknown)'
              , 'Vasopressin 40 Units Sodium Chloride 0.9% 200 ml (units/min)'
              , 'Vasopressin (mcg/kg/min)'
              , 'Vasopressin (mcg/min)'
              , 'Vasopressin (mg/hr)'
              , 'Vasopressin (mg/min)'
              , 'vasopressin (ml/hr)'
              , 'Vasopressin (ml/hr)'
              , 'Vasopressin (units/hr)'
              , 'Vasopressin (units/kg/min)'
              , 'vasopressin (units/min)'
              , 'Vasopressin (units/min)'
              , 'VAsopressin (units/min)'
              , 'Vasopressin (Unknown)'
            ) then 1 else 0 end)
          as vasopressin
    , max(case when drugname in
      (
           'Milrinone'
         , 'Milrinone ()'
         , 'Milrinone (mcg/kg/hr)'
         , 'Milrinone (mcg/kg/min)'
         , 'Milrinone (ml/hr)'
         , 'Milrinone (Primacor) 40 mg Dextrose 5% 200 ml (mcg/kg/min)'
         , 'Milronone (mcg/kg/min)'
         , 'primacore (mcg/kg/min)'
      ) then 1 else 0 end)
      as milrinone
    , max(case when drugname in
      (
          'Hepain (ml/hr)'
        , 'Heparin'
        , 'Heparin ()'
        , 'Heparin 25,000 Unit/D5w 250 ml (ml/hr)'
        , 'Heparin 25000 Units Dextrose 5% 500 ml  Premix (units/hr)'
        , 'Heparin 25000 Units Dextrose 5% 500 ml  Premix (units/kg/hr)'
        , 'Heparin 25000 Units Dextrose 5% 950 ml  Premix (units/kg/hr)'
        , 'HEPARIN #2 (units/hr)'
        , 'Heparin 8000u/1L NS (ml/hr)'
        , 'Heparin-EKOS (units/hr)'
        , 'Heparin/Femoral Sheath   (units/hr)'
        , 'Heparin (mcg/kg/hr)'
        , 'Heparin (mcg/kg/min)'
        , 'Heparin (ml/hr)'
        , 'heparin (units/hr)'
        , 'Heparin (units/hr)'
        , 'HEPARIN (units/hr)'
        , 'Heparin (units/kg/hr)'
        , 'Heparin (Unknown)'
        , 'Heparin via sheath (units/hr)'
        , 'Left  Heparin (units/hr)'
        , 'NSS carrier heparin (ml/hr)'
        , 'S-Heparin (units/hr)'
        , 'Volume (ml) Heparin-heparin 25,000 units in 0.45 % sodium chloride 500 mL infusion'
        , 'Volume (ml) Heparin-heparin 25,000 units in 0.45 % sodium chloride 500 mL infusion (ml/hr)'
        , 'Volume (ml) Heparin-heparin 25,000 units in dextrose 500 mL infusion'
        , 'Volume (ml) Heparin-heparin 25,000 units in dextrose 500 mL infusion (ml/hr)'
        , 'Volume (ml) Heparin-heparin infusion 2 units/mL in 0.9% sodium chloride (ARTERIAL LINE)'
        , 'Volume (ml) Heparin-heparin infusion 2 units/mL in 0.9% sodium chloride (ARTERIAL LINE) (ml/hr)'
      ) then 1 else 0 end)
      as heparin
  from infusiondrug
  group by patientunitstayid, infusionoffset
)
select
  patientunitstayid
  , infusionoffset as chartoffset
  , dopamine::SMALLINT as dopamine
  , dobutamine::SMALLINT as dobutamine
  , norepinephrine::SMALLINT as norepinephrine
  , phenylephrine::SMALLINT as phenylephrine
  , epinephrine::SMALLINT as epinephrine
  , vasopressin::SMALLINT as vasopressin
  , milrinone::SMALLINT as milrinone
  , heparin::SMALLINT as heparin
from vw0
-- at least one of our drugs should be non-zero
where dopamine = 1
OR dobutamine = 1
OR norepinephrine = 1
OR phenylephrine = 1
OR epinephrine = 1
OR vasopressin = 1
OR milrinone = 1
OR heparin = 1
order by patientunitstayid, infusionoffset;
