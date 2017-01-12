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
--  APACHEPATIENTRESULTS
--------------------------------------------------------

CREATE INDEX APACHEPATIENTRESULTS_idx01
  ON APACHEPATIENTRESULTS (PATIENTUNITSTAYID);
CREATE INDEX APACHEPATIENTRESULTS_idx02
  ON APACHEPATIENTRESULTS (APACHEVERSION);
CREATE INDEX APACHEPATIENTRESULTS_idx03
  ON APACHEPATIENTRESULTS (APACHESCORE);
ALTER TABLE APACHEPATIENTRESULTS
  ADD CONSTRAINT apachepatientresults_pk primary key (APACHEPATIENTRESULTSID);

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
--  PATIENT
--------------------------------------------------------

CREATE INDEX PATIENT_idx01
  ON PATIENT (PATIENTUNITSTAYID);
CREATE INDEX PATIENT_idx02
  ON PATIENT (PATIENTHEALTHSYSTEMSTAYID);
CREATE INDEX PATIENT_idx03
  ON PATIENT (HOSPITALADMITYEAR);
CREATE INDEX PATIENT_idx04
  ON PATIENT (UNITADMITYEAR);
CREATE INDEX PATIENT_idx05
  ON PATIENT (UNITTYPE);
ALTER TABLE PATIENT
  ADD CONSTRAINT PATIENT_pk primary key (PATIENTUNITSTAYID);

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
