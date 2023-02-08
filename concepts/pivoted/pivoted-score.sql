DROP TABLE IF EXISTS pivoted_score CASCADE;
CREATE TABLE pivoted_score as
-- create columns with only numeric data
with nc as
(
select
    patientunitstayid
  , nursingchartoffset
  , nursingchartentryoffset
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Glasgow coma score'
     and nursingchartcelltypevalname = 'GCS Total'
     and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
     and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    when nursingchartcelltypecat = 'Other Vital Signs and Infusions'
     and nursingchartcelltypevallabel = 'Score (Glasgow Coma Scale)'
     and nursingchartcelltypevalname = 'Value'
     and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
     and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    else null end
  as gcs
  -- components of GCS
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Glasgow coma score'
     and nursingchartcelltypevalname = 'Motor'
     and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
     and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    when nursingchartcelltypecat = 'Other Vital Signs and Infusions'
     and nursingchartcelltypevallabel = 'Best Motor Response'
        then case
          when nursingchartvalue in ('1', '1-->(M1) none', 'Flaccid') then 1
          when nursingchartvalue in ('2', '2-->(M2) extension to pain', 'Abnormal extension') then 2
          when nursingchartvalue in ('3', '3-->(M3) flexion to pain', 'Abnormal flexion') then 3
          when nursingchartvalue in ('4', '4-->(M4) withdraws from pain', 'Withdraws') then 4
          when nursingchartvalue in ('5', '5-->(M5) localizes pain', 'Localizes to noxious stimuli') then 5
          when nursingchartvalue in ('6','6-->(M6) obeys commands', 'Obeys simple commands') then 6
        else null end
    else null end
  as gcs_motor
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Glasgow coma score'
     and nursingchartcelltypevalname = 'Verbal'
     and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
     and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    when nursingchartcelltypecat = 'Other Vital Signs and Infusions'
     and nursingchartcelltypevallabel = 'Best Verbal Response'
        then case
          -- when nursingchartvalue in ('Trached or intubated') then 0
          when nursingchartvalue in ('1', '1-->(V1) none', 'None', 'Clearly unresponsive') then 1
          when nursingchartvalue in ('2', '2-->(V2) incomprehensible speech', 'Incomprehensible sounds') then 2
          when nursingchartvalue in ('3', '3-->(V3) inappropriate words', 'Inappropriate words') then 3
          when nursingchartvalue in ('4', '4-->(V4) confused', 'Confused') then 4
          when nursingchartvalue in ('5', '5-->(V5) oriented', 'Oriented',
                                    'Orientation/ability to communicate questionable',
                                    'Clearly oriented/can indicate needs') then 5
        else null end
    else null end
  as gcs_verbal
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Glasgow coma score'
     and nursingchartcelltypevalname = 'Eyes'
     and nursingchartvalue ~ '^[-]?[0-9]+[.]?[0-9]*$'
     and nursingchartvalue not in ('-','.')
        then cast(nursingchartvalue as numeric)
    when nursingchartcelltypecat = 'Other Vital Signs and Infusions'
     and nursingchartcelltypevallabel = 'Best Eye Response'
        then case
          when nursingchartvalue in ('1', '1-->(E1) none') then 1
          when nursingchartvalue in ('2', '2-->(E2) to pain') then 2
          when nursingchartvalue in ('3', '3-->(E3) to speech') then 3
          when nursingchartvalue in ('4', '4-->(E4) spontaneous') then 4
        else null end
    else null end
  as gcs_eyes
  -- unable/other misc info
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Glasgow coma score'
     and nursingchartcelltypevalname = 'GCS Total'
     and nursingchartvalue = 'Unable to score due to medication'
        then 1
    else null end
  as gcs_unable
  , case
    when nursingchartcelltypecat = 'Other Vital Signs and Infusions'
     and nursingchartcelltypevallabel = 'Best Verbal Response'
     and nursingchartvalue = 'Trached or intubated'
        then 1
    else null end
  as gcs_intub
  -- fall risk
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Fall Risk'
     and nursingchartcelltypevalname = 'Fall Risk'
        then case
          when nursingchartvalue = 'Low' then 1
          when nursingchartvalue = 'Medium' then 2
          when nursingchartvalue = 'High' then 3
        else null end
    else null end::numeric
  as fall_risk
  -- delirium
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Delirium Scale/Score'
     and nursingchartcelltypevalname = 'Delirium Scale'
        then nursingchartvalue
    else null end
  as delirium_scale
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Delirium Scale/Score'
     and nursingchartcelltypevalname = 'Delirium Score'
        then case
          when nursingchartvalue in ('No', 'NO') then 0
          when nursingchartvalue in ('Yes', 'YES') then 1
          when nursingchartvalue = 'N/A' then NULL
        else cast(nursingchartvalue as numeric) end
    else null end
  as delirium_score
  -- sedation
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Sedation Scale/Score/Goal'
     and nursingchartcelltypevalname = 'Sedation Scale'
        then nursingchartvalue
    else null end
  as sedation_scale
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Sedation Scale/Score/Goal'
     and nursingchartcelltypevalname = 'Sedation Score'
        then cast(nursingchartvalue as numeric)
    else null end
  as sedation_score
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Sedation Scale/Score/Goal'
     and nursingchartcelltypevalname = 'Sedation Goal'
        then cast(nursingchartvalue as numeric)
    else null end
  as sedation_goal
  -- pain
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Pain Score/Goal'
     and nursingchartcelltypevalname = 'Pain Score'
        then cast(nursingchartvalue as numeric)
    else null end
  as pain_score
  , case
    when nursingchartcelltypecat = 'Scores'
     and nursingchartcelltypevallabel = 'Pain Score/Goal'
     and nursingchartcelltypevalname = 'Pain Goal'
        then cast(nursingchartvalue as numeric)
    else null end
  as pain_goal
  from nursecharting
  -- speed up by only looking at a subset of charted data
  where nursingchartcelltypecat IN
  (
        'Scores'
      , 'Other Vital Signs and Infusions'
  )
)
select
  patientunitstayid
, nursingchartoffset as chartoffset
, nursingchartentryoffset as entryoffset
, AVG(gcs) as gcs
, AVG(gcs_motor) as gcs_motor
, AVG(gcs_verbal) as gcs_verbal
, AVG(gcs_eyes) as gcs_eyes
, MAX(gcs_unable) as gcs_unable
, MAX(gcs_intub) as gcs_intub
, AVG(fall_risk) as fall_risk
, MAX(delirium_scale) as delirium_scale
, AVG(delirium_score) as delirium_score
, MAX(sedation_scale) as sedation_scale
, AVG(sedation_score) as sedation_score
, AVG(sedation_goal) as sedation_goal
, AVG(pain_score) as pain_score
, AVG(pain_goal) as pain_goal
from nc
WHERE gcs IS NOT NULL
OR gcs_motor IS NOT NULL
OR gcs_verbal IS NOT NULL
OR gcs_eyes IS NOT NULL
OR gcs_unable IS NOT NULL
OR gcs_intub IS NOT NULL
OR fall_risk IS NOT NULL
OR delirium_scale IS NOT NULL
OR delirium_score IS NOT NULL
OR sedation_scale IS NOT NULL
OR sedation_score IS NOT NULL
OR sedation_goal IS NOT NULL
OR pain_score IS NOT NULL
OR pain_goal IS NOT NULL
group by patientunitstayid, nursingchartoffset, nursingchartentryoffset
order by patientunitstayid, nursingchartoffset, nursingchartentryoffset;
