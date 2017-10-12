-- ----------------------------------------------------------------
--
-- This is a script to add the eICU-CRD constraints for Postgres.
--
-- ----------------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO eicu_crd;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;

--------------------------------------------------------
--  DDL for Table ADMISSIONDX
--------------------------------------------------------

ALTER TABLE ADMISSIONDX DROP CONSTRAINT IF EXISTS ADMISSIONDX_fk_ptunit_id;
ALTER TABLE ADMISSIONDX
ADD CONSTRAINT ADMISSIONDX_fk_ptunit_id
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
--  DDL for Table LAB
--------------------------------------------------------

ALTER TABLE LAB DROP CONSTRAINT IF EXISTS LAB_fk_ptunit_id;
ALTER TABLE LAB
ADD CONSTRAINT LAB_fk_ptunit_id
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
