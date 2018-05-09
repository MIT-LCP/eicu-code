-- -------------------------------------------------------------------------------
--
-- Load data from compressed files into the schema
--
-- -------------------------------------------------------------------------------

-- Change to the directory containing the data files
\cd :datadir

--------------------------------------------------------
--  Load Data for Table ADMISSIONDRUG
--------------------------------------------------------

\copy admissionDrug FROM program 'gzip -c -d admissionDrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

\copy admissionDx FROM program 'gzip -c -d admissionDx.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

\copy allergy FROM program 'gzip -c -d allergy.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

\copy apacheApsVar FROM program 'gzip -c -d apacheApsVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

\copy apachePatientResult FROM program 'gzip -c -d apachePatientResult.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

\copy apachePredVar FROM program 'gzip -c -d apachePredVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

\copy carePlanCareProvider FROM program 'gzip -c -d carePlanCareProvider.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

\copy carePlanEOL FROM program 'gzip -c -d carePlanEOL.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

\copy carePlanGeneral FROM program 'gzip -c -d carePlanGeneral.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

\copy carePlanGoal FROM program 'gzip -c -d carePlanGoal.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

\copy carePlanInfectiousDisease FROM program 'gzip -c -d carePlanInfectiousDisease.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CUSTOMLAB
--------------------------------------------------------

\copy customLab FROM program 'gzip -c -d customLab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

\copy diagnosis FROM program 'gzip -c -d diagnosis.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

\copy hospital FROM program 'gzip -c -d hospital.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy infusionDrug FROM program 'gzip -c -d infusionDrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy intakeOutput FROM program 'gzip -c -d intakeOutput.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

\copy lab FROM program 'gzip -c -d lab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MEDICATION
--------------------------------------------------------

\copy medication FROM program 'gzip -c -d medication.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MICROLAB
--------------------------------------------------------

\copy microLab FROM program 'gzip -c -d microLab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NOTE
--------------------------------------------------------

\copy note FROM program 'gzip -c -d note.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSEASSESSMENT
--------------------------------------------------------

\copy nurseAssessment FROM program 'gzip -c -d nurseAssessment.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECARE
--------------------------------------------------------

\copy nurseCare FROM program 'gzip -c -d nurseCare.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECHARTING
--------------------------------------------------------

\copy nurseCharting FROM program 'gzip -c -d nurseCharting.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

\copy pastHistory FROM program 'gzip -c -d pastHistory.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

\copy patient FROM program 'gzip -c -d patient.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PHYSICALEXAM
--------------------------------------------------------

\copy physicalExam FROM program 'gzip -c -d physicalExam.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCARE
--------------------------------------------------------

\copy respiratoryCare FROM program 'gzip -c -d respiratoryCare.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCHARTING
--------------------------------------------------------

\copy respiratoryCharting FROM program 'gzip -c -d respiratoryCharting.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

\copy treatment FROM program 'gzip -c -d treatment.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

\copy vitalAperiodic FROM program 'gzip -c -d vitalAperiodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

\copy vitalPeriodic FROM program 'gzip -c -d vitalPeriodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''
