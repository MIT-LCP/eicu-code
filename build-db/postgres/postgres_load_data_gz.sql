-- -------------------------------------------------------------------------------
--
-- Load data from compressed files into the schema
--
-- -------------------------------------------------------------------------------

\set ON_ERROR_STOP 1

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

\copy ADMISSIONDX FROM program 'gzip -c -d admissionDx.csv.gz' DELIMITER ',' CSV HEADER NULL ''

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
--  Load Data for Table PATIENTS
--------------------------------------------------------

\copy PATIENT FROM program 'gzip -c -d patient.csv.gz' DELIMITER ',' CSV HEADER NULL ''
