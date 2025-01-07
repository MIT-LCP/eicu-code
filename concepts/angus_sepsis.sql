-- ------------------------------------------------------------------
-- Title: Query to create materialized view of Angus sepsis criteria
-- Description: This code is based on the angus_sepsis query for MIMIC 
-- https://github.com/MIT-LCP/mimic-code/blob/master/concepts/sepsis/angus.sql
-- 
-- Case selection and definitions
-- To identify cases with severe sepsis, we selected all acute care
-- hospitalizations with ICD-9-CM codes for both:
-- (a) a bacterial or fungal infectious process AND
-- (b) a diagnosis of acute organ dysfunction (Appendix 2).
-- eICU version: v1.1 
-- References: Angus et al, 2001. Epidemiology of severe sepsis in 
-- the United States http://www.ncbi.nlm.nih.gov/pubmed/11445675. 
-- ------------------------------------------------------------------

SET search_path TO eicu;

DROP MATERIALIZED VIEW IF EXISTS angus_sepsis CASCADE;
CREATE MATERIALIZED VIEW angus_sepsis as

-- ICD-9 codes for infection - as sourced from Appendix 1 of above paper
WITH infection_group AS
(
    SELECT patientUnitStayID, 
    CASE
    	WHEN substring(icd9code,1,3) IN ('001','002','003','004','005','008',
			   '009','010','011','012','013','014','015','016','017','018',
			   '020','021','022','023','024','025','026','027','030','031',
			   '032','033','034','035','036','037','038','039','040','041',
			   '090','091','092','093','094','095','096','097','098','100',
			   '101','102','103','104','110','111','112','114','115','116',
			   '117','118','320','322','324','325','420','421','451','461',
			   '462','463','464','465','481','482','485','486','494','510',
			   '513','540','541','542','566','567','590','597','601','614',
			   '615','616','681','682','683','686','730') THEN 1
		WHEN substring(icd9code,1,5) IN ('569.5','572.0','572.1','575.0','599.0','711.0',
				'790.7','996.6','998.5','999.3') THEN 1
		WHEN substring(icd9code,1,6) IN ('491.21','562.01','562.03','562.11','562.13',
				'569.83') THEN 1
		ELSE 0 END AS infection 
        FROM diagnosis
),
-- ICD-9 codes for organ dysfunction - as sourced from Appendix 2 of above paper
organ_diag_group AS
(
    SELECT patientUnitStayID,
    CASE
    	WHEN substring(icd9code,1,3) IN ('458','293','570','584') THEN 1
		WHEN substring(icd9code,1,5) IN ('785.5','348.3','348.1',
				'287.4','287.5','286.9','286.6','573.4')  THEN 1
		ELSE 0 END AS organ_dysfunction,
		-- Explicit diagnosis of severe sepsis or septic shock
		CASE
		WHEN substring(icd9code,1,6) IN ('995.92','785.52')  THEN 1
		ELSE 0 END AS explicit_sepsis
	FROM diagnosis
),
-- Mechanical ventilation
organ_proc_group as
(
	SELECT patientUnitStayID,
		CASE
		WHEN treatmentstring LIKE '%mechanical ventilation%' THEN 1
		ELSE 0 END AS mech_vent
	FROM treatment
),
-- Aggregate above views together
aggregate as
(
	SELECT patientUnitStayID,
		CASE
			WHEN patientUnitStayID in
					(SELECT DISTINCT patientUnitStayID
					FROM infection_group
					WHERE infection = 1)
				THEN 1
			ELSE 0 END AS infection,
		CASE
			WHEN patientUnitStayID in
					(SELECT DISTINCT patientUnitStayID
					FROM organ_diag_group
					WHERE explicit_sepsis = 1)
				THEN 1
			ELSE 0 END AS explicit_sepsis,
		CASE
			WHEN patientUnitStayID in
					(SELECT DISTINCT patientUnitStayID
					FROM organ_diag_group
					WHERE organ_dysfunction = 1)
				THEN 1
			ELSE 0 END AS organ_dysfunction,
		CASE
		WHEN patientUnitStayID in
				(SELECT DISTINCT patientUnitStayID
				FROM organ_proc_group
				WHERE mech_vent = 1)
			THEN 1
		ELSE 0 END AS mech_vent
	FROM patient
)
-- Output component flags (explicit sepsis, organ dysfunction) and final flag (angus)
SELECT patientUnitStayID, infection,
   explicit_sepsis, organ_dysfunction, mech_vent,
CASE
	WHEN explicit_sepsis = 1 THEN 1
	WHEN infection = 1 AND organ_dysfunction = 1 THEN 1
	WHEN infection = 1 AND mech_vent = 1 THEN 1
	ELSE 0 END
AS angus
FROM aggregate;