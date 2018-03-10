# Checks whether a patients has a chronic disease mentioned in APACHE II score (used for score calculation)

SELECT
  patientunitstayid, 
  CASE
    WHEN pasthistorypath LIKE "%UGI Bleeding%" THEN True
    WHEN pasthistorypath LIKE "%Encephalopathy%" THEN True
    WHEN pasthistorypath LIKE "%CHF - class IV%" THEN True
    WHEN pasthistorypath LIKE "%Cirrhosis/UGI bleeding%" THEN True
    WHEN pasthistorypath LIKE "%Cirrhosis/biopsy proven%" THEN True
    WHEN pasthistorypath LIKE "%Cirrhosis/coma%" THEN True
    WHEN pasthistorypath LIKE "%COPD - severe%" THEN True
    WHEN pasthistorypath LIKE "%polycythemia%" THEN True
    WHEN pasthistorypath LIKE "%dialysis%" THEN True
    WHEN pasthistorypath LIKE "%Chemotherapy%" THEN True
    WHEN pasthistorypath LIKE "%Immunosuppression%" THEN True
    WHEN pasthistorypath LIKE "%Radiation%" THEN True
    WHEN pasthistorypath LIKE "%Lymphoma%" THEN True
    WHEN pasthistorypath LIKE "%AIDS%" THEN True
    WHEN pasthistorypath LIKE "%Leukemia%" THEN True
    WHEN pasthistorypath LIKE "%Recent Steroid Use%" THEN True
    ELSE FALSE 
  END AS organ_insuff
FROM
  [eicu.pastHistory]
WHERE pasthistorynotetype = "Admission" 
ORDER BY patientunitstayid 
