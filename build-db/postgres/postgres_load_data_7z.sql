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

\copy admissionDrug FROM program '7z e -so admissionDrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

\copy admissionDx FROM program '7z e -so admissionDx.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

\copy allergy FROM program '7z e -so allergy.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

\copy apacheApsVar FROM program '7z e -so apacheApsVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

\copy apachePatientResult FROM program '7z e -so apachePatientResult.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

\copy apachePredVar FROM program '7z e -so apachePredVar.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

\copy carePlanCareProvider FROM program '7z e -so carePlanCareProvider.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

\copy carePlanEOL FROM program '7z e -so carePlanEOL.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

\copy carePlanGeneral FROM program '7z e -so carePlanGeneral.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

\copy carePlanGoal FROM program '7z e -so carePlanGoal.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

\copy carePlanInfectiousDisease FROM program '7z e -so carePlanInfectiousDisease.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table CUSTOMLAB
--------------------------------------------------------

\copy customLab FROM program '7z e -so customLab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

\copy diagnosis FROM program '7z e -so diagnosis.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

\copy hospital FROM program '7z e -so hospital.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy infusionDrug FROM program '7z e -so infusionDrug.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

\copy intakeOutput FROM program '7z e -so intakeOutput.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

\copy lab FROM program '7z e -so lab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MEDICATION
--------------------------------------------------------

\copy medication FROM program '7z e -so medication.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table MICROLAB
--------------------------------------------------------

\copy microLab FROM program '7z e -so microLab.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NOTE
--------------------------------------------------------

\copy note FROM program '7z e -so note.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSEASSESSMENT
--------------------------------------------------------

\copy nurseAssessment FROM program '7z e -so nurseAssessment.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECARE
--------------------------------------------------------

\copy nurseCare FROM program '7z e -so nurseCare.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table NURSECHARTING
--------------------------------------------------------

\copy nurseCharting FROM program '7z e -so nurseCharting.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

\copy pastHistory FROM program '7z e -so pastHistory.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

\copy patient FROM program '7z e -so patient.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table PHYSICALEXAM
--------------------------------------------------------

\copy physicalExam FROM program '7z e -so physicalExam.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCARE
--------------------------------------------------------

\copy respiratoryCare FROM program '7z e -so respiratoryCare.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCHARTING
--------------------------------------------------------

\copy respiratoryCharting FROM program '7z e -so respiratoryCharting.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

\copy treatment FROM program '7z e -so treatment.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

\copy vitalAperiodic FROM program '7z e -so vitalAperiodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

\copy vitalPeriodic FROM program '7z e -so vitalPeriodic.csv.gz' DELIMITER ',' CSV HEADER NULL ''
