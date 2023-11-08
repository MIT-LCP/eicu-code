 
-- This query extracts durations of vasopressin administration. 
-- It is heavily based on the MIMIC-III duration code
-- Consecutive durations are numbered and administations are ended after 18 hours without 
-- a charted value. 18 hours is a little arbitrary, but there are some vasopressin infusions
-- that are long standing and non-titrated (and will have 14 hour gaps in charting)

CREATE OR REPLACE FUNCTION SAFE_CAST_TO_NUMERIC(v_input text) RETURNS NUMERIC AS $$
-- This casts a string to a numeric value without throwing an exception if the 
-- sting is not 'numeric-like'. For BigQuery, use SAFE_CAST(x AS NUMERIC)
DECLARE v_numeric_value NUMERIC DEFAULT NULL;
BEGIN
    BEGIN
        v_numeric_value := v_input::NUMERIC;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
RETURN v_numeric_value;
END;
$$ LANGUAGE plpgsql;

DROP MATERIALIZED VIEW IF EXISTS vasopressindurations;
CREATE MATERIALIZED VIEW vasopressindurations AS 
WITH drug_events AS (
  SELECT
      patientunitstayid
    , infusionoffset
    , drugrate
    , CASE WHEN SAFE_CAST_TO_NUMERIC(drugrate) > 0 THEN 1 ELSE 0 END AS vasopressor_event
    , CASE WHEN drugrate LIKE '%OFF%' THEN 1
        WHEN SAFE_CAST_TO_NUMERIC(drugrate) = 0 THEN 1
        ELSE 0 END AS stop_event
  FROM
    infusiondrug
  WHERE
    LOWER(drugname) LIKE 'vasopressin%'
), d0 AS (
  SELECT
    patientunitstayid 
    , infusionoffset 
    , drugrate 
    , vasopressor_event
    , stop_event
    , LAG(InfusionOffset, 1) OVER (PARTITION BY patientunitstayid ORDER BY infusionoffset) AS InfusionOffsetLag
  FROM
    drug_events 
), d1 AS (
  SELECT
      patientunitstayid 
      , infusionoffset 
      , drugrate 
      , vasopressor_event
      , stop_event
      , CASE 
        -- Case 1: The row prior was a stop event. This is either part of a string of zeros
        -- or the start of a new event
          WHEN Lag(stop_event, 1, 1) OVER (PARTITION BY patientunitstayid  ORDER BY infusionoffset) = 1 THEN
          	CASE WHEN stop_event = 1 THEN 0 ELSE 1 END
        -- Case 2: If the row prior was more than 18 hours ago, end this is a new event
          WHEN InfusionOffset - InfusionOffsetLag > (18*60) THEN 1
        -- Otherwise, This is _not_ a new event.
          ELSE 0
       END AS new_event
  FROM d0
), d2 AS (
  SELECT
    d1.*
    -- Generate a sequential integer for convience
    , SUM(new_event) OVER (PARTITION BY patientunitstayid ORDER BY infusionoffset) AS vasopressor_episode
  FROM
    d1
)
SELECT
  patientunitstayid
  , 'Vasopressin' AS Drug
  , vasopressor_episode
  , MIN(infusionoffset) AS start_offset
  , MAX(infusionoffset) AS end_offset
FROM d2
GROUP BY patientunitstayid, vasopressor_episode;
