-- -------------------------------------------------------------------------------
--
-- Load data from compressed files into the schema
--
-- -------------------------------------------------------------------------------

\set ON_ERROR_STOP 1

--------------------------------------------------------
--  Load Data for Table ADMISSIONDRUG
--------------------------------------------------------

\copy ADMISSIONDRUG FROM program 'gzip -c -d admissiondrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

\copy ADMISSIONDX FROM program 'gzip -c -d admissionDx.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

\copy ALLERGY FROM program 'gzip -c -d allergy.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

\copy APACHEAPSVAR FROM program 'gzip -c -d apacheApsVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

\copy APACHEPATIENTRESULT FROM program 'gzip -c -d apachePatientResult.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

\copy APACHEPREDVAR FROM program 'gzip -c -d apachePredVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

\copy CAREPLANCAREPROVIDER FROM program 'gzip -c -d carePlanCareProvider.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

\copy CAREPLANEOL FROM program 'gzip -c -d carePlanEOL.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

\copy CAREPLANGENERAL FROM program 'gzip -c -d carePlanGeneral.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

\copy CAREPLANGOAL FROM program 'gzip -c -d carePlanGoal.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

\copy CAREPLANINFECTIOUSDISEASE FROM program 'gzip -c -d carePlanInfectiousDisease.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

\copy DIAGNOSIS FROM program 'gzip -c -d diagnosis.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

\copy HOSPITAL FROM program 'gzip -c -d hospital.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy INFUSIONDRUG FROM program 'gzip -c -d infusiondrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

\copy LAB FROM program 'gzip -c -d lab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

\copy medication FROM program 'gzip -c -d medication.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

\copy PASTHISTORY FROM program 'gzip -c -d pastHistory.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

\copy PATIENT FROM program 'gzip -c -d patient.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

\copy TREATMENT FROM program 'gzip -c -d treatment.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

\copy VITALAPERIODIC FROM program 'gzip -c -d vitalAperiodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

\copy VITALPERIODIC FROM program 'gzip -c -d vitalPeriodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''
