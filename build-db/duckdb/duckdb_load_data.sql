-------------------------------------------------------------------------------

-- Load data from compressed files into the schema

-------------------------------------------------------------------------------

-----------------------------------------------------
--  Load Data for Table ADMISSIONDRUG
-----------------------------------------------------

COPY admissionDrug FROM 'admissionDrug.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table ADMISSIONDX
--------------------------------------------------------

COPY admissionDx FROM 'admissionDx.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table ALLERGY
--------------------------------------------------------

COPY allergy FROM 'allergy.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEAPSVAR
--------------------------------------------------------

COPY apacheApsVar FROM 'apacheApsVar.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEPATIENTRESULTS
--------------------------------------------------------

COPY apachePatientResult FROM 'apachePatientResult.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table APACHEPREDVAR
--------------------------------------------------------

COPY apachePredVar FROM 'apachePredVar.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

COPY carePlanCareProvider FROM 'carePlanCareProvider.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANEOL
--------------------------------------------------------

COPY carePlanEOL FROM 'carePlanEOL.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANGENERAL
--------------------------------------------------------

COPY carePlanGeneral FROM 'carePlanGeneral.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANGOAL
--------------------------------------------------------

COPY carePlanGoal FROM 'carePlanGoal.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

COPY carePlanInfectiousDisease FROM 'carePlanInfectiousDisease.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table CUSTOMLAB
--------------------------------------------------------

COPY customLab FROM 'customLab.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table DIAGNOSIS
--------------------------------------------------------

COPY diagnosis FROM 'diagnosis.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table HOSPITAL
--------------------------------------------------------

COPY hospital FROM 'hospital.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

COPY infusionDrug FROM 'infusionDrug.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table INFUSIONDRUG
--------------------------------------------------------

COPY intakeOutput FROM 'intakeOutput.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table LAB
--------------------------------------------------------

COPY lab FROM 'lab.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table MEDICATION
--------------------------------------------------------

COPY medication FROM 'medication.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table MICROLAB
--------------------------------------------------------

COPY microLab FROM 'microLab.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NOTE
--------------------------------------------------------

COPY note FROM 'note.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSEASSESSMENT
--------------------------------------------------------

COPY nurseAssessment FROM 'nurseAssessment.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSECARE
--------------------------------------------------------

COPY nurseCare FROM 'nurseCare.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table NURSECHARTING
--------------------------------------------------------

COPY nurseCharting FROM 'nurseCharting.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PASTHISTORY
--------------------------------------------------------

COPY pastHistory FROM 'pastHistory.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PATIENT
--------------------------------------------------------

COPY patient FROM 'patient.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table PHYSICALEXAM
--------------------------------------------------------

COPY physicalExam FROM 'physicalExam.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCARE
--------------------------------------------------------

COPY respiratoryCare FROM 'respiratoryCare.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table RESPIRATORYCHARTING
--------------------------------------------------------

COPY respiratoryCharting FROM 'respiratoryCharting.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table TREATMENT
--------------------------------------------------------

COPY treatment FROM 'treatment.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table VITALAPERIODIC
--------------------------------------------------------

COPY vitalAperiodic FROM 'vitalAperiodic.csv' ( DELIMITER ',', HEADER );

--------------------------------------------------------
--  Load Data for Table VITALPERIODIC
--------------------------------------------------------

COPY vitalPeriodic FROM 'vitalPeriodic.csv' ( DELIMITER ',', HEADER );

CHECKPOINT;
