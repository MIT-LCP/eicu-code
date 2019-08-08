-- ----------------------------------------------------------------
--
-- This is a script to add the eICU-CRD constraints for Postgres.
--
-- ----------------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO eicu_crd;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;

ALTER TABLE patient DROP CONSTRAINT IF EXISTS patient_pk_ptunid_id;
ALTER TABLE patient
ADD CONSTRAINT patient_pk_ptunit_id
  PRIMARY KEY (patientunitstayid);

--------------------------------------------------------
--  DDL for Table ADMISSIONDX
--------------------------------------------------------

ALTER TABLE ADMISSIONDX DROP CONSTRAINT IF EXISTS ADMISSIONDX_fk_ptunit_id;
ALTER TABLE ADMISSIONDX
ADD CONSTRAINT ADMISSIONDX_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table ADMISSIONDRUG
--------------------------------------------------------

ALTER TABLE ADMISSIONDRUG DROP CONSTRAINT IF EXISTS ADMISSIONDRUG_fk_ptunit_id;
ALTER TABLE ADMISSIONDRUG
ADD CONSTRAINT ADMISSIONDRUG_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table ALLERGY
--------------------------------------------------------

ALTER TABLE ALLERGY DROP CONSTRAINT IF EXISTS ALLERGY_fk_ptunit_id;
ALTER TABLE ALLERGY
ADD CONSTRAINT ALLERGY_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table APACHEAPSVAR
--------------------------------------------------------

ALTER TABLE APACHEAPSVAR DROP CONSTRAINT IF EXISTS APACHEAPSVAR_fk_ptunit_id;
ALTER TABLE APACHEAPSVAR
ADD CONSTRAINT APACHEAPSVAR_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table APACHEPATIENTRESULTS
--------------------------------------------------------

ALTER TABLE APACHEPATIENTRESULT DROP CONSTRAINT IF EXISTS APACHEPATIENTRESULT_fk_ptunit_id;
ALTER TABLE APACHEPATIENTRESULT
ADD CONSTRAINT APACHEPATIENTRESULT_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table APACHEPREDVAR
--------------------------------------------------------

ALTER TABLE APACHEPREDVAR DROP CONSTRAINT IF EXISTS APACHEPREDVAR_fk_ptunit_id;
ALTER TABLE APACHEPREDVAR
ADD CONSTRAINT APACHEPREDVAR_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

ALTER TABLE CAREPLANCAREPROVIDER DROP CONSTRAINT IF EXISTS CAREPLANCAREPROVIDER_fk_ptunit_id;
ALTER TABLE CAREPLANCAREPROVIDER
ADD CONSTRAINT CAREPLANCAREPROVIDER_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CAREPLANEOL
--------------------------------------------------------

ALTER TABLE CAREPLANEOL DROP CONSTRAINT IF EXISTS CAREPLANEOL_fk_ptunit_id;
ALTER TABLE CAREPLANEOL
ADD CONSTRAINT CAREPLANEOL_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CAREPLANGENERAL
--------------------------------------------------------

ALTER TABLE CAREPLANGENERAL DROP CONSTRAINT IF EXISTS CAREPLANGENERAL_fk_ptunit_id;
ALTER TABLE CAREPLANGENERAL
ADD CONSTRAINT CAREPLANGENERAL_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CAREPLANGOAL
--------------------------------------------------------

ALTER TABLE CAREPLANGOAL DROP CONSTRAINT IF EXISTS CAREPLANGOAL_fk_ptunit_id;
ALTER TABLE CAREPLANGOAL
ADD CONSTRAINT CAREPLANGOAL_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

ALTER TABLE CAREPLANINFECTIOUSDISEASE DROP CONSTRAINT IF EXISTS CAREPLANINFECTIOUSDISEASE_fk_ptunit_id;
ALTER TABLE CAREPLANINFECTIOUSDISEASE
ADD CONSTRAINT CAREPLANINFECTIOUSDISEASE_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table CUSTOMLAB
--------------------------------------------------------

ALTER TABLE CUSTOMLAB DROP CONSTRAINT IF EXISTS CUSTOMLAB_fk_ptunit_id;
ALTER TABLE CUSTOMLAB
ADD CONSTRAINT CUSTOMLAB_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table DIAGNOSIS
--------------------------------------------------------

ALTER TABLE DIAGNOSIS DROP CONSTRAINT IF EXISTS DIAGNOSIS_fk_ptunit_id;
ALTER TABLE DIAGNOSIS
ADD CONSTRAINT DIAGNOSIS_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table HOSPITAL
--------------------------------------------------------

-- No foreign keys.

--------------------------------------------------------
--  DDL for Table INFUSIONDRUG
--------------------------------------------------------

ALTER TABLE INFUSIONDRUG DROP CONSTRAINT IF EXISTS INFUSIONDRUG_fk_ptunit_id;
ALTER TABLE INFUSIONDRUG
ADD CONSTRAINT INFUSIONDRUG_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table INTAKEOUTPUT
--------------------------------------------------------

ALTER TABLE INTAKEOUTPUT DROP CONSTRAINT IF EXISTS INTAKEOUTPUT_fk_ptunit_id;
ALTER TABLE INTAKEOUTPUT
ADD CONSTRAINT INTAKEOUTPUT_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table LAB
--------------------------------------------------------

ALTER TABLE LAB DROP CONSTRAINT IF EXISTS LAB_fk_ptunit_id;
ALTER TABLE LAB
ADD CONSTRAINT LAB_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table MEDICATION
--------------------------------------------------------

ALTER TABLE MEDICATION DROP CONSTRAINT IF EXISTS MEDICATION_fk_ptunit_id;
ALTER TABLE MEDICATION
ADD CONSTRAINT MEDICATION_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table MICROLAB
--------------------------------------------------------

ALTER TABLE MICROLAB DROP CONSTRAINT IF EXISTS MICROLAB_fk_ptunit_id;
ALTER TABLE MICROLAB
ADD CONSTRAINT MICROLAB_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table NOTE
--------------------------------------------------------

ALTER TABLE NOTE DROP CONSTRAINT IF EXISTS NOTE_fk_ptunit_id;
ALTER TABLE NOTE
ADD CONSTRAINT NOTE_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table NURSEASSESSMENT
--------------------------------------------------------

ALTER TABLE NURSEASSESSMENT DROP CONSTRAINT IF EXISTS NURSEASSESSMENT_fk_ptunit_id;
ALTER TABLE NURSEASSESSMENT
ADD CONSTRAINT NURSEASSESSMENT_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table NURSECARE
--------------------------------------------------------

ALTER TABLE NURSECARE DROP CONSTRAINT IF EXISTS NURSECARE_fk_ptunit_id;
ALTER TABLE NURSECARE
ADD CONSTRAINT NURSECARE_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table NURSECHARTING
--------------------------------------------------------

ALTER TABLE NURSECHARTING DROP CONSTRAINT IF EXISTS NURSECHARTING_fk_ptunit_id;
ALTER TABLE NURSECHARTING
ADD CONSTRAINT NURSECHARTING_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table PASTHISTORY
--------------------------------------------------------

ALTER TABLE PASTHISTORY DROP CONSTRAINT IF EXISTS PASTHISTORY_fk_ptunit_id;
ALTER TABLE PASTHISTORY
ADD CONSTRAINT PASTHISTORY_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table PATIENT
--------------------------------------------------------

ALTER TABLE PATIENT DROP CONSTRAINT IF EXISTS PATIENT_fk_hospital_id;
ALTER TABLE PATIENT
ADD CONSTRAINT PATIENT_fk_hospital_id
  FOREIGN KEY (hospitalid)
  REFERENCES HOSPITAL(hospitalid);

--------------------------------------------------------
--  DDL for Table PHYSICALEXAM
--------------------------------------------------------

ALTER TABLE PHYSICALEXAM DROP CONSTRAINT IF EXISTS PHYSICALEXAM_fk_ptunit_id;
ALTER TABLE PHYSICALEXAM
ADD CONSTRAINT PHYSICALEXAM_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table RESPIRATORYCARE
--------------------------------------------------------

ALTER TABLE RESPIRATORYCARE DROP CONSTRAINT IF EXISTS RESPIRATORYCARE_fk_ptunit_id;
ALTER TABLE RESPIRATORYCARE
ADD CONSTRAINT RESPIRATORYCARE_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table RESPIRATORYCHARTING
--------------------------------------------------------

ALTER TABLE RESPIRATORYCHARTING DROP CONSTRAINT IF EXISTS RESPIRATORYCHARTING_fk_ptunit_id;
ALTER TABLE RESPIRATORYCHARTING
ADD CONSTRAINT RESPIRATORYCHARTING_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table TREATMENT
--------------------------------------------------------

ALTER TABLE TREATMENT DROP CONSTRAINT IF EXISTS TREATMENT_fk_ptunit_id;
ALTER TABLE TREATMENT
ADD CONSTRAINT TREATMENT_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table VITALAPERIODIC
--------------------------------------------------------

ALTER TABLE VITALAPERIODIC DROP CONSTRAINT IF EXISTS VITALAPERIODIC_fk_ptunit_id;
ALTER TABLE VITALAPERIODIC
ADD CONSTRAINT VITALAPERIODIC_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);

--------------------------------------------------------
--  DDL for Table VITALPERIODIC
--------------------------------------------------------

ALTER TABLE VITALPERIODIC DROP CONSTRAINT IF EXISTS VITALPERIODIC_fk_ptunit_id;
ALTER TABLE VITALPERIODIC
ADD CONSTRAINT VITALPERIODIC_fk_ptunit_id
  FOREIGN KEY (patientunitstayid)
  REFERENCES PATIENT(patientunitstayid);
