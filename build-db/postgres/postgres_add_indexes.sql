-- ----------------------------------------------------------------
--
-- This is a script to add the eICU indexes for Postgres.
--
-- ----------------------------------------------------------------

-- NOTE: unless specified here or when calling this script via psql, all tables
-- will be created on the public schema. To redefine the search path, call:
--    SET search_path TO schema_name_you_want;
-- Restoring the search path to its default value can be accomplished as follows:
--    SET search_path TO "$user",public;

--------------------------------------------------------
--  ADMISSIONDX
--------------------------------------------------------

CREATE INDEX ADMISSIONDX_idx01
  ON ADMISSIONDX (PATIENTUNITSTAYID);
ALTER TABLE ADMISSIONDX
  ADD CONSTRAINT admissiondx_pk primary key (ADMISSIONDXID);

--------------------------------------------------------
--  APACHEAPSVAR
--------------------------------------------------------

CREATE INDEX APACHEAPSVAR_idx01
  ON APACHEAPSVAR (PATIENTUNITSTAYID);
ALTER TABLE APACHEAPSVAR
  ADD CONSTRAINT apacheapsvar_pk primary key (APACHEAPSVARID);

--------------------------------------------------------
--  APACHEPATIENTRESULT
--------------------------------------------------------

CREATE INDEX APACHEPATIENTRESULT_idx01
  ON APACHEPATIENTRESULT (PATIENTUNITSTAYID);
CREATE INDEX APACHEPATIENTRESULT_idx02
  ON APACHEPATIENTRESULT (APACHEVERSION);
CREATE INDEX APACHEPATIENTRESULT_idx03
  ON APACHEPATIENTRESULT (APACHESCORE);
ALTER TABLE APACHEPATIENTRESULT
  ADD CONSTRAINT apachepatientresult_pk primary key (APACHEPATIENTRESULTSID);

--------------------------------------------------------
--  APACHEPREDVAR
--------------------------------------------------------

CREATE INDEX APACHEPREDVAR_idx01
  ON APACHEPREDVAR (PATIENTUNITSTAYID);
CREATE INDEX APACHEPREDVAR_idx02
  ON APACHEPREDVAR (SICUDAY);
ALTER TABLE APACHEPREDVAR
  ADD CONSTRAINT apachepredvar_pk primary key (APACHEPREDVARID);

--------------------------------------------------------
--  CAREPLANCAREPROVIDER
--------------------------------------------------------

CREATE INDEX CAREPLANCAREPROVIDER_idx01
  ON CAREPLANCAREPROVIDER (PATIENTUNITSTAYID);
ALTER TABLE CAREPLANCAREPROVIDER
  ADD CONSTRAINT CAREPLANCAREPROVIDER_pk primary key (CPLCAREPROVDERID);

--------------------------------------------------------
--  CAREPLANEOL
--------------------------------------------------------

CREATE INDEX CAREPLANEOL_idx01
  ON CAREPLANEOL (PATIENTUNITSTAYID);
ALTER TABLE CAREPLANEOL
  ADD CONSTRAINT CAREPLANEOL_pk primary key (CPLEOLID);

--------------------------------------------------------
--  CAREPLANGENERAL
--------------------------------------------------------

CREATE INDEX CAREPLANGENERAL_idx01
  ON CAREPLANGENERAL (PATIENTUNITSTAYID);
ALTER TABLE CAREPLANGENERAL
  ADD CONSTRAINT CAREPLANGENERAL_pk primary key (CPLGENERALID);

--------------------------------------------------------
--  CAREPLANGOAL
--------------------------------------------------------

CREATE INDEX CAREPLANGOAL_idx01
  ON CAREPLANGOAL (PATIENTUNITSTAYID);
ALTER TABLE CAREPLANGOAL
  ADD CONSTRAINT CAREPLANGOAL_pk primary key (CPLGOALID);

--------------------------------------------------------
--  CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

CREATE INDEX CAREPLANINFECTIOUSDISEASE_idx01
  ON CAREPLANINFECTIOUSDISEASE (PATIENTUNITSTAYID);
ALTER TABLE CAREPLANINFECTIOUSDISEASE
  ADD CONSTRAINT CAREPLANINFECTIOUSDISEASE_pk primary key (CPLINFECTID);

--------------------------------------------------------
--  DIAGNOSIS
--------------------------------------------------------

CREATE INDEX DIAGNOSIS_idx01
  ON DIAGNOSIS (PATIENTUNITSTAYID);
ALTER TABLE DIAGNOSIS
  ADD CONSTRAINT DIAGNOSIS_pk primary key (DIAGNOSISID);

--------------------------------------------------------
--  HOSPITAL
--------------------------------------------------------

ALTER TABLE HOSPITAL
  ADD CONSTRAINT HOSPITAL_pk primary key (HOSPITALID);

--------------------------------------------------------
--  LAB
--------------------------------------------------------

CREATE INDEX LAB_idx01
  ON LAB (PATIENTUNITSTAYID);
ALTER TABLE LAB
  ADD CONSTRAINT LAB_pk primary key (LABID);

--------------------------------------------------------
--  PASTHISTORY
--------------------------------------------------------

CREATE INDEX PASTHISTORY_idx01
  ON PASTHISTORY (PATIENTUNITSTAYID);
ALTER TABLE PASTHISTORY
  ADD CONSTRAINT PASTHISTORY_pk primary key (PASTHISTORYID);

--------------------------------------------------------
--  PATIENT
--------------------------------------------------------

CREATE INDEX PATIENT_idx01
  ON PATIENT (PATIENTUNITSTAYID);
CREATE INDEX PATIENT_idx02
  ON PATIENT (PATIENTHEALTHSYSTEMSTAYID);
CREATE INDEX PATIENT_idx03
  ON PATIENT (HOSPITALDISCHARGEYEAR);
CREATE INDEX PATIENT_idx05
  ON PATIENT (UNITTYPE);
ALTER TABLE PATIENT
  ADD CONSTRAINT PATIENT_pk primary key (PATIENTUNITSTAYID);

--------------------------------------------------------
--  TREATMENT
--------------------------------------------------------

CREATE INDEX TREATMENT_idx01
  ON TREATMENT (PATIENTUNITSTAYID);
ALTER TABLE TREATMENT
  ADD CONSTRAINT TREATMENT_pk primary key (TREATMENTID);

--------------------------------------------------------
--  VITALAPERIODIC
--------------------------------------------------------

CREATE INDEX VITALAPERIODIC_idx01
  ON VITALAPERIODIC (PATIENTUNITSTAYID);
ALTER TABLE VITALAPERIODIC
  ADD CONSTRAINT VITALAPERIODIC_pk primary key (VITALAPERIODICID);

--------------------------------------------------------
--  VITALPERIODIC
--------------------------------------------------------

CREATE INDEX VITALPERIODIC_idx01
  ON VITALPERIODIC (PATIENTUNITSTAYID);
ALTER TABLE VITALPERIODIC
  ADD CONSTRAINT VITALPERIODIC_pk primary key (VITALPERIODICID);
