-- -------------------------------------------------------------------------------
--
-- Create the eICU tables
--
-- -------------------------------------------------------------------------------

-- NOTE: unless specified here or when calling this script via psql, all tables
-- will be created on the public schema. To redefine the search path, call:
--    SET search_path TO schema_name_you_want;
-- Restoring the search path to its default value can be accomplished as follows:
--    SET search_path TO "$user",public;

--------------------------------------------------------
--  DDL for Table ADMISSIONDRUG
--------------------------------------------------------

DROP TABLE IF EXISTS admissiondrug CASCADE;
CREATE TABLE admissiondrug
(
  admissiondrugid BIGINT NOT NULL,
  patientunitstayid BIGINT NOT NULL,
  drugyear SMALLINT NOT NULL,
  drugtime24 VARCHAR(8) NOT NULL,
  drugtime VARCHAR(20) NOT NULL,
  drugoffset BIGINT NOT NULL,
  drugenteredyear SMALLINT NOT NULL,
  drugenteredtime24 VARCHAR(8),
  drugenteredtime VARCHAR(20),
  drugenteredoffset BIGINT NOT NULL,
  drugnotetype VARCHAR(255),
  specialtytype VARCHAR(255),
  usertype VARCHAR(255) NOT NULL,
  rxincluded VARCHAR(5),
  writtenineicu VARCHAR(5),
  drugname VARCHAR(255) NOT NULL,
  drugdosage NUMERIC(11,4),
  drugunit VARCHAR(1000),
  drugadmitfrequency VARCHAR(1000) NOT NULL,
  drughiclseqno BIGINT
) ;

--------------------------------------------------------
--  DDL for Table ADMISSIONDX
--------------------------------------------------------

DROP TABLE IF EXISTS admissiondx CASCADE;
CREATE TABLE admissiondx
(
  patientunitstayid BIGINT NOT NULL,
  admissiondxid BIGINT NOT NULL,
  admitdxenteredyear SMALLINT NOT NULL,
  admitdxenteredtime24 VARCHAR(8) NOT NULL,
  admitdxenteredtime VARCHAR(20) NOT NULL,
  admitdxenteredoffset BIGINT NOT NULL,
  admitdxpath VARCHAR(500) NOT NULL,
  admitdxname VARCHAR(255),
  admitdxtext VARCHAR(255)
) ;

--------------------------------------------------------
--  DDL for Table ALLERGY
--------------------------------------------------------

DROP TABLE IF EXISTS allergy CASCADE;
CREATE TABLE allergy
(
  allergyid BIGINT NOT NULL,
  patientunitstayid BIGINT NOT NULL,
  allergyyear SMALLINT NOT NULL,
  allergytime24 VARCHAR(8) NOT NULL,
  allergytime VARCHAR(20) NOT NULL,
  allergyoffset BIGINT NOT NULL,
  allergyenteredyear SMALLINT NOT NULL,
  allergyenteredtime24 VARCHAR(8),
  allergyenteredtime VARCHAR(20),
  allergyenteredoffset BIGINT NOT NULL,
  allergynotetype VARCHAR(255),
  specialtytype VARCHAR(255),
  usertype VARCHAR(255) NOT NULL,
  rxincluded VARCHAR(5),
  writtenineicu VARCHAR(5),
  drugname VARCHAR(255) NOT NULL,
  allergytype VARCHAR(255),
  allergyname VARCHAR(255),
  drughiclseqno BIGINT
) ;


--------------------------------------------------------
--  DDL for Table APACHEAPSVAR
--------------------------------------------------------

DROP TABLE IF EXISTS apacheapsvar CASCADE;
CREATE TABLE apacheapsvar
(
	patientunitstayid BIGINT,
	apacheapsvarid BIGINT,
	intubated BIGINT,
	vent BIGINT,
	dialysis BIGINT,
	eyes BIGINT,
	motor BIGINT,
	verbal BIGINT,
	meds BIGINT,
	urine DOUBLE PRECISION,
	wbc DOUBLE PRECISION,
	temperature DOUBLE PRECISION,
	respiratoryrate DOUBLE PRECISION,
	sodium DOUBLE PRECISION,
	heartrate DOUBLE PRECISION,
	meanbp DOUBLE PRECISION,
	ph DOUBLE PRECISION,
	hematocrit DOUBLE PRECISION,
	creatinine DOUBLE PRECISION,
	albumin DOUBLE PRECISION,
	pao2 DOUBLE PRECISION,
	pco2 DOUBLE PRECISION,
	bun DOUBLE PRECISION,
	glucose DOUBLE PRECISION,
	bilirubin DOUBLE PRECISION,
	fio2 DOUBLE PRECISION
) ;
--------------------------------------------------------
--  DDL for Table APACHEPATIENTRESULTS
--------------------------------------------------------

DROP TABLE IF EXISTS apachepatientresult CASCADE;
CREATE TABLE apachepatientresult
(
	patientunitstayid BIGINT NOT NULL,
	apachepatientresultsid BIGINT NOT NULL,
	physicianspeciality VARCHAR(50),
	physicianinterventioncategory VARCHAR(50),
	acutephysiologyscore BIGINT,
	apachescore BIGINT,
	apacheversion VARCHAR(5) NOT NULL,
	predictedicumortality VARCHAR(50),
	actualicumortality VARCHAR(50),
	predictediculos DOUBLE PRECISION,
	actualiculos DOUBLE PRECISION,
	predictedhospitalmortality VARCHAR(50),
	actualhospitalmortality VARCHAR(50),
	predictedhospitallos DOUBLE PRECISION,
	actualhospitallos DOUBLE PRECISION,
	preopmi BIGINT,
	preopcardiaccath BIGINT,
	ptcawithin24h BIGINT,
	unabridgedunitlos DOUBLE PRECISION,
	unabridgedhosplos DOUBLE PRECISION,
	actualventdays DOUBLE PRECISION,
	predventdays DOUBLE PRECISION,
	unabridgedactualventdays DOUBLE PRECISION
) ;
--------------------------------------------------------
--  DDL for Table APACHEPREDVAR
--------------------------------------------------------

DROP TABLE IF EXISTS apachepredvar CASCADE;
CREATE TABLE apachepredvar
(
	patientunitstayid BIGINT,
	apachepredvarid BIGINT,
	sicuday BIGINT,
	saps3day1 BIGINT,
	saps3today BIGINT,
	saps3yesterday BIGINT,
	gender BIGINT,
	teachtype BIGINT,
	region BIGINT,
	bedcount BIGINT,
	admitsource BIGINT,
	graftcount BIGINT,
	meds BIGINT,
	verbal BIGINT,
	motor BIGINT,
	eyes BIGINT,
	age BIGINT,
	admitdiagnosis VARCHAR(11),
	thrombolytics BIGINT,
	diedinhospital BIGINT,
	aids BIGINT,
	hepaticfailure BIGINT,
	lymphoma BIGINT,
	metastaticcancer BIGINT,
	leukemia BIGINT,
	immunosuppression BIGINT,
	cirrhosis BIGINT,
	electivesurgery BIGINT,
	activetx BIGINT,
	readmit BIGINT,
	ima BIGINT,
	midur BIGINT,
	ventday1 BIGINT,
	oobventday1 BIGINT,
	oobintubday1 BIGINT,
	diabetes BIGINT,
	managementsystem BIGINT,
	var03hspxlos DOUBLE PRECISION,
	pao2 DOUBLE PRECISION,
	fio2 DOUBLE PRECISION,
	ejectfx DOUBLE PRECISION,
	creatinine DOUBLE PRECISION,
	dischargelocation BIGINT,
	visitnumber BIGINT,
	amilocation BIGINT,
	day1meds BIGINT,
	day1verbal BIGINT,
	day1motor BIGINT,
	day1eyes BIGINT,
	day1pao2 DOUBLE PRECISION,
	day1fio2 DOUBLE PRECISION
) ;

--------------------------------------------------------
--  DDL for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

DROP TABLE IF EXISTS careplancareprovider CASCADE;
CREATE TABLE careplancareprovider
(
	cplcareprovderid BIGINT NOT NULL,
	patientunitstayid BIGINT NOT NULL,
	careprovidersaveyear SMALLINT NOT NULL,
	careprovidersavetime24 VARCHAR(8) NOT NULL,
	careprovidersavetime VARCHAR(20) NOT NULL,
	careprovidersaveoffset BIGINT NOT NULL,
	providertype VARCHAR(255),
	specialty VARCHAR(255),
	interventioncategory VARCHAR(255),
	managingphysician VARCHAR(50),
	activeupondischarge VARCHAR(10) NOT NULL
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANEOL
--------------------------------------------------------

DROP TABLE IF EXISTS careplaneol CASCADE;
CREATE TABLE careplaneol
(
	patientunitstayid BIGINT NOT NULL,
	cpleolid BIGINT NOT NULL,
	cpleolsaveyear SMALLINT NOT NULL,
	cpleolsavetime24 VARCHAR(8) NOT NULL,
	cpleolsavetime VARCHAR(20) NOT NULL,
	cpleolsaveoffset BIGINT NOT NULL,
	cpleoldiscussionyear SMALLINT,
	cpleoldiscussiontime24 VARCHAR(8),
	cpleoldiscussiontime VARCHAR(20),
	cpleoldiscussionoffset BIGINT,
	activeupondischarge VARCHAR(10)
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANGENERAL
--------------------------------------------------------

DROP TABLE IF EXISTS careplangeneral CASCADE;
CREATE TABLE careplangeneral
(
	patientunitstayid BIGINT NOT NULL,
	activeupondischarge VARCHAR(10) NOT NULL,
	cplgeneralid BIGINT NOT NULL,
	cplitemyear SMALLINT NOT NULL,
	cplitemtime24 VARCHAR(8) NOT NULL,
	cplitemtime VARCHAR(20) NOT NULL,
	cplitemoffset BIGINT NOT NULL,
	cplgroup VARCHAR(255) NOT NULL,
	cplitemvalue VARCHAR(1024)
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANGOAL
--------------------------------------------------------

DROP TABLE IF EXISTS careplangoal CASCADE;
CREATE TABLE careplangoal
(
	cplgoalid BIGINT NOT NULL,
	patientunitstayid BIGINT NOT NULL,
	cplgoalyear SMALLINT NOT NULL,
	CPLGOALTIME24 VARCHAR(8) NOT NULL,
	CPLGOALTIME VARCHAR(20) NOT NULL,
	CPLGOALOFFSET BIGINT NOT NULL,
	CPLGOALCATEGORY VARCHAR(255),
	CPLGOALVALUE VARCHAR(1000),
	CPLGOALSTATUS VARCHAR(255),
	ACTIVEUPONDISCHARGE VARCHAR(10) NOT NULL
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANINFECTIOUSDISEASE
--------------------------------------------------------

DROP TABLE IF EXISTS careplaninfectiousdisease CASCADE;
CREATE TABLE careplaninfectiousdisease
(
	patientunitstayid BIGINT NOT NULL,
	activeupondischarge VARCHAR(10) NOT NULL,
	cplinfectid BIGINT NOT NULL,
	cplinfectdiseaseyear SMALLINT NOT NULL,
	cplinfectdiseasetime24 VARCHAR(8) NOT NULL,
	cplinfectdiseasetime VARCHAR(20) NOT NULL,
	cplinfectdiseaseoffset BIGINT NOT NULL,
	infectdiseasesite VARCHAR(64),
	infectdiseaseassessment VARCHAR(64),
	responsetotherapy VARCHAR(32),
	treatment VARCHAR(32)
) ;
--------------------------------------------------------
--  DDL for Table DIAGNOSIS
--------------------------------------------------------

DROP TABLE IF EXISTS diagnosis CASCADE;
CREATE TABLE diagnosis
(
	patientunitstayid BIGINT NOT NULL,
	activeupondischarge VARCHAR(64),
	diagnosisid BIGINT NOT NULL,
	diagnosisyear SMALLINT NOT NULL,
	diagnosistime24 VARCHAR(8) NOT NULL,
	diagnosistime VARCHAR(20) NOT NULL,
	diagnosisoffset BIGINT NOT NULL,
	diagnosisstring VARCHAR(200) NOT NULL,
	icd9code VARCHAR(100),
	diagnosispriority VARCHAR(10) NOT NULL
) ;
--------------------------------------------------------
--  DDL for Table HOSPITAL
--------------------------------------------------------

DROP TABLE IF EXISTS hospital CASCADE;
CREATE TABLE hospital
(
	hospitalid INT NOT NULL,
	numbedscategory VARCHAR(32),
	teachingstatus BOOLEAN,
	region VARCHAR(64)
) ;

--------------------------------------------------------
--  DDL for Table INFUSIONDRUG
--------------------------------------------------------

DROP TABLE IF EXISTS infusiondrug CASCADE;
CREATE TABLE infusiondrug
(
  patientunitstayid BIGINT NOT NULL,
  infusiondrugid BIGINT NOT NULL,
  infusionyear SMALLINT NOT NULL,
  infusiontime24 VARCHAR(8) NOT NULL,
  infusiontime VARCHAR(20) NOT NULL,
  infusionoffset BIGINT NOT NULL,
  drugname VARCHAR(255) NOT NULL,
  drugrate VARCHAR(255),
  infusionrate VARCHAR(255),
  drugamount VARCHAR(255),
  volumeoffluid VARCHAR(255),
  patientweight VARCHAR(255)
) ;

--------------------------------------------------------
--  DDL for Table LAB
--------------------------------------------------------

DROP TABLE IF EXISTS lab CASCADE;
CREATE TABLE lab
(
	patientunitstayid BIGINT NOT NULL,
	labid BIGINT NOT NULL,
	labresultyear SMALLINT NOT NULL,
	labresulttime24 VARCHAR(8) NOT NULL,
	labresulttime VARCHAR(20) NOT NULL,
	labresultoffset BIGINT NOT NULL,
	labtypeid DECIMAL(3,0) NOT NULL,
	labname VARCHAR(256),
	labresult DECIMAL(11,4),
	labresulttext VARCHAR(255),
	labmeasurenamesystem VARCHAR(255),
	labmeasurenameinterface VARCHAR(255),
	labresultrevisedyear SMALLINT,
	labresultrevisedtime24 VARCHAR(8),
	labresultrevisedtime VARCHAR(20),
	labresultrevisedoffset BIGINT
) ;

--------------------------------------------------------
--  DDL for Table MEDICATION
--------------------------------------------------------

DROP TABLE IF EXISTS medication CASCADE;
CREATE TABLE medication
(
    medicationid BIGINT NOT NULL,
    patientunitstayid BIGINT NOT NULL,
    drugorderyear INT NOT NULL,
    drugordertime24 VARCHAR(12) NOT NULL,
    drugordertime VARCHAR(12) NOT NULL,
    drugorderoffset INT NOT NULL,
    drugstartyear INT,
    drugstarttime24 VARCHAR(12) NOT NULL,
    drugstarttime VARCHAR(12) NOT NULL,
    drugstartoffset INT NOT NULL,
    drugivadmixture VARCHAR(6) NOT NULL,
    drugordercancelled VARCHAR(6) NOT NULL,
    drugname VARCHAR(220) NOT NULL,
    drughiclseqno INT,
    dosage VARCHAR(60) NOT NULL,
    routeadmin VARCHAR(120) NOT NULL,
    loadingdose VARCHAR(120) NOT NULL,
    prn VARCHAR(6) NOT NULL,
    drugstopyear INT,
    drugstoptime24 VARCHAR(12) NOT NULL,
    drugstoptime VARCHAR(12) NOT NULL,
    drugstopoffset INT NOT NULL,
    gtc INT NOT NULL
) ;

--------------------------------------------------------
--  DDL for Table PASTHISTORY
--------------------------------------------------------

DROP TABLE IF EXISTS pasthistory CASCADE;
CREATE TABLE pasthistory
(
	pasthistoryid BIGINT NOT NULL,
	patientunitstayid BIGINT NOT NULL,
	pasthistoryyear SMALLINT NOT NULL,
	pasthistorytime24 VARCHAR(8) NOT NULL,
	pasthistorytime VARCHAR(20) NOT NULL,
	pasthistoryoffset BIGINT NOT NULL,
	pasthistoryenteredyear SMALLINT NOT NULL,
	pasthistoryenteredtime24 VARCHAR(8) NOT NULL,
	pasthistoryenteredtime VARCHAR(20) NOT NULL,
	pasthistoryenteredoffset BIGINT NOT NULL,
	pasthistorynotetype VARCHAR(40),
	pasthistorypath VARCHAR(255) NOT NULL,
	pasthistoryvalue VARCHAR(100),
	pasthistoryvaluetext VARCHAR(255)
) ;
--------------------------------------------------------
--  DDL for Table PATIENT
--------------------------------------------------------

DROP TABLE IF EXISTS patient CASCADE;
CREATE TABLE patient
(
	patientunitstayid BIGINT,
	patienthealthsystemstayid BIGINT,
	gender VARCHAR(25),
	age VARCHAR(10),
	ethnicity VARCHAR(50),
	hospitalid BIGINT,
	wardid BIGINT,
	apacheadmissiondx VARCHAR(1000),
	admissionheight DECIMAL(10,2),
	hospitaladmityear SMALLINT,
	hospitaladmittime24 VARCHAR(8),
	hospitaladmittime VARCHAR(20),
	hospitaladmitoffset BIGINT,
	hospitaladmitsource VARCHAR(30),
	hospitaldischargeyear SMALLINT,
	hospitaldischargetime24 VARCHAR(8),
	hospitaldischargetime VARCHAR(20),
	hospitaldischargeoffset BIGINT,
	hospitaldischargelocation VARCHAR(100),
	hospitaldischargestatus VARCHAR(10),
	unittype VARCHAR(50),
	unitadmityear SMALLINT,
	unitadmittime24 VARCHAR(8),
	unitadmittime VARCHAR(20),
	unitadmitsource VARCHAR(100),
	unitvisitnumber BIGINT,
	unitstaytype VARCHAR(15),
	admissionweight DECIMAL(10,2),
	dischargeweight DECIMAL(10,2),
	unitdischargeyear SMALLINT,
	unitdischargetime24 VARCHAR(8),
	unitdischargetime VARCHAR(20),
	unitdischargeoffset BIGINT,
	unitdischargelocation VARCHAR(100),
	unitdischargestatus VARCHAR(10),
	uniquepid VARCHAR(10)
) ;
--------------------------------------------------------
--  DDL for Table TREATMENT
--------------------------------------------------------

DROP TABLE IF EXISTS treatment CASCADE;
CREATE TABLE treatment
(
	patientunitstayid BIGINT,
	treatmentid BIGINT,
	treatmentyear SMALLINT,
	treatmenttime24 VARCHAR(8),
	treatmenttime VARCHAR(20),
	treatmentoffset BIGINT,
	treatmentstring VARCHAR(200),
	activeupondischarge VARCHAR(10)
) ;
--------------------------------------------------------
--  DDL for Table VITALAPERIODIC
--------------------------------------------------------

DROP TABLE IF EXISTS vitalaperiodic CASCADE;
CREATE TABLE vitalaperiodic
(
	patientunitstayid BIGINT NOT NULL,
	vitalaperiodicid BIGINT NOT NULL,
	observationyear SMALLINT NOT NULL,
	observationtime24 VARCHAR(8) NOT NULL,
	observationtime VARCHAR(20) NOT NULL,
	observationoffset BIGINT NOT NULL,
	noninvasivesystolic DOUBLE PRECISION,
	noninvasivediastolic DOUBLE PRECISION,
	noninvasivemean DOUBLE PRECISION,
	paop DOUBLE PRECISION,
	cardiacoutput DOUBLE PRECISION,
	cardiacinput DOUBLE PRECISION,
	svr DOUBLE PRECISION,
	svri DOUBLE PRECISION,
	pvr DOUBLE PRECISION,
	pvri DOUBLE PRECISION
) ;
--------------------------------------------------------
--  DDL for Table VITALPERIODIC
--------------------------------------------------------

DROP TABLE IF EXISTS vitalperiodic CASCADE;
CREATE TABLE vitalperiodic
(
	patientunitstayid BIGINT,
	vitalperiodicid BIGINT,
	observationyear SMALLINT,
	observationtime24 VARCHAR(8),
	observationtime VARCHAR(20),
	observationoffset BIGINT,
	temperature DECIMAL(11,4),
	sao2 BIGINT,
	heartrate BIGINT,
	respiration BIGINT,
	cvp BIGINT,
	etco2 BIGINT,
	systemicsystolic BIGINT,
	systemicdiastolic BIGINT,
	systemicmean BIGINT,
	pasystolic BIGINT,
	padiastolic BIGINT,
	pamean BIGINT,
	st1 DOUBLE PRECISION,
	st2 DOUBLE PRECISION,
	st3 DOUBLE PRECISION,
	icp BIGINT
) ;
