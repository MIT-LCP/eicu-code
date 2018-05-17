# Create weight based dosing of catecholamins (e.g. used for calculation of SOFA score)
# Requires two tables: one with admissionweight, one with all catecholamins and respective  (see other concepts)
# In case dosing is not in mcg/kg/min, this script will calculate it (there are two sets of dosing types included)

SELECT
  a.patientunitstayid,
  CASE
    WHEN c.drugname LIKE "%Dopamine%" THEN "Dopamine"
    WHEN c.drugname LIKE "%Dobutamine%" THEN "Dobutamine"
    WHEN c.drugname LIKE "%Epinephrine%" THEN "Epinephrine"
    WHEN c.drugname LIKE "%Norepinephrine%" THEN "Norepinephrine"
  END AS catecholamin_type,
  CASE
    WHEN c.drugname LIKE "%(mcg/min)%" THEN ROUND(c.drugrate / a.admissionweight)
    ELSE c.drugrate
  END AS drug_calculated
FROM
  eicu.admissionweights a
INNER JOIN
  eicu.catecholamins c
ON
  c.patientunitstayid = a.patientunitstayid
