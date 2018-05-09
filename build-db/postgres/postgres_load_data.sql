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

\copy ADMISSIONDRUG FROM 'admissionDrug.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

\copy ADMISSIONDX FROM 'admissionDx.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

\copy ALLERGY FROM 'allergy.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

\copy APACHEAPSVAR FROM 'apacheApsVar.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

\copy APACHEPATIENTRESULT FROM 'apachePatientResult.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

\copy APACHEPREDVAR FROM 'apachePredVar.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

\copy CAREPLANCAREPROVIDER FROM 'carePlanCareProvider.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

\copy CAREPLANEOL FROM 'carePlanEOL.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

\copy CAREPLANGENERAL FROM 'carePlanGeneral.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

\copy CAREPLANGOAL FROM 'carePlanGoal.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

\copy CAREPLANINFECTIOUSDISEASE FROM 'carePlanInfectiousDisease.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CUSTOMLAB
--------------------------------------------------------

\copy CUSTOMLAB FROM 'customLab.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

\copy DIAGNOSIS FROM 'diagnosis.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

\copy HOSPITAL FROM 'hospital.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy INFUSIONDRUG FROM 'infusionDrug.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy intakeoutput FROM 'intakeOutput.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

\copy lab FROM 'lab.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MEDICATION
--------------------------------------------------------

\copy medication FROM 'medication.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MICROLAB
--------------------------------------------------------

\copy microlab FROM 'microLab.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NOTE
--------------------------------------------------------

\copy note FROM 'note.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSEASSESSMENT
--------------------------------------------------------

\copy nurseassessment FROM 'nurseAssessment.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECARE
--------------------------------------------------------

\copy nursecare FROM 'nurseCare.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECHARTING
--------------------------------------------------------

\copy nursecharting FROM 'nurseCharting.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

\copy PASTHISTORY FROM 'pastHistory.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

\copy PATIENT FROM 'patient.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PHYSICALEXAM
--------------------------------------------------------

\copy physicalexam FROM 'physicalExam.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCARE
--------------------------------------------------------

\copy respiratorycare FROM 'respiratoryCare.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCHARTING
--------------------------------------------------------

\copy respiratorycharting FROM 'respiratoryCharting.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

\copy TREATMENT FROM 'treatment.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

\copy VITALAPERIODIC FROM 'vitalAperiodic.csv' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

\copy VITALPERIODIC FROM 'vitalPeriodic.csv' DELIMITER ',' CSV HEADER NULL ''
