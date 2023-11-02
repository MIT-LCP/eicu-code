-------------------------------------------------------------------------------

-- Load data from compressed files into the schema

-------------------------------------------------------------------------------

-----------------------------------------------------
--  Load Data for Table ADMISSIONDRUG
-----------------------------------------------------

COPY admissionDrug FROM 'admissionDrug.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

COPY admissionDx FROM 'admissionDx.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

COPY allergy FROM 'allergy.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

COPY apacheApsVar FROM 'apacheApsVar.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

COPY apachePatientResult FROM 'apachePatientResult.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

COPY apachePredVar FROM 'apachePredVar.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

COPY carePlanCareProvider FROM 'carePlanCareProvider.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

COPY carePlanEOL FROM 'carePlanEOL.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

COPY carePlanGeneral FROM 'carePlanGeneral.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

COPY carePlanGoal FROM 'carePlanGoal.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

COPY carePlanInfectiousDisease FROM 'carePlanInfectiousDisease.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CUSTOMLAB
--------------------------------------------------------

COPY customLab FROM 'customLab.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

COPY diagnosis FROM 'diagnosis.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

COPY hospital FROM 'hospital.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

COPY infusionDrug FROM 'infusionDrug.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

COPY intakeOutput FROM 'intakeOutput.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

COPY lab FROM 'lab.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table MEDICATION
--------------------------------------------------------

COPY medication FROM 'medication.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table MICROLAB
--------------------------------------------------------

COPY microLab FROM 'microLab.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NOTE
--------------------------------------------------------

COPY note FROM 'note.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSEASSESSMENT
--------------------------------------------------------

COPY nurseAssessment FROM 'nurseAssessment.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSECARE
--------------------------------------------------------

COPY nurseCare FROM 'nurseCare.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSECHARTING
--------------------------------------------------------

COPY nurseCharting FROM 'nurseCharting.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

COPY pastHistory FROM 'pastHistory.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

COPY patient FROM 'patient.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PHYSICALEXAM
--------------------------------------------------------

COPY physicalExam FROM 'physicalExam.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCARE
--------------------------------------------------------

COPY respiratoryCare FROM 'respiratoryCare.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCHARTING
--------------------------------------------------------

COPY respiratoryCharting FROM 'respiratoryCharting.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

COPY treatment FROM 'treatment.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

COPY vitalAperiodic FROM 'vitalAperiodic.csv.gz' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

COPY vitalPeriodic FROM 'vitalPeriodic.csv.gz' ( DELIMITER ',', HEADER );

CHECKPOINT;
