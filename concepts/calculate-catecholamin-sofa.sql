# Calculate catecholamin scores for SOFA score
# Needs calculated catecholamin rates in mcg/kg/min (calculate_catecholamins.sql)

SELECT
  *,
  CASE
    WHEN catecholamin_type = "Dopamine" AND drug_calculated <= 5 THEN 2
    WHEN catecholamin_type = "Dobutamine" THEN 2
    # smaller 0.1 = 3 points
    WHEN catecholamin_type = "Dopamine" AND drug_calculated > 5 THEN 3
    WHEN catecholamin_type = "Norepinephrine" AND drug_calculated <= 0.1 THEN 3
    WHEN catecholamin_type = "Epinephrine" AND drug_calculated <= 0.1 THEN 3
    # larger 0.1 = 4 points
    WHEN catecholamin_type = "Dopamine" AND drug_calculated > 15 THEN 4
    WHEN catecholamin_type = "Norepinephrine" AND drug_calculated > 0.1 THEN 4
    WHEN catecholamin_type = "Epinephrine" AND drug_calculated > 0.1 THEN 4
    
    ELSE 0
  END AS score
FROM
  calculated_catecholamins
