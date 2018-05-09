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
  admissiondrugid INT NOT NULL,
  patientunitstayid INT NOT NULL,
  drugoffset INT  NOT NULL,
  drugenteredoffset INT  NOT NULL,
  drugnotetype VARCHAR(255),
  specialtytype VARCHAR(255),
  usertype VARCHAR(255) NOT NULL,
  rxincluded VARCHAR(5),
  writtenineicu VARCHAR(5),
  drugname VARCHAR(255) NOT NULL,
  drugdosage NUMERIC(11,4),
  drugunit VARCHAR(1000),
  drugadmitfrequency VARCHAR(1000) NOT NULL,
  drughiclseqno INT
) ;

--------------------------------------------------------
--  DDL for Table ADMISSIONDX
--------------------------------------------------------

DROP TABLE IF EXISTS admissiondx CASCADE;
CREATE TABLE admissiondx
(
  admissiondxid INT NOT NULL,
  patientunitstayid INT NOT NULL,
  admitdxenteredoffset INT NOT NULL,
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
  allergyid INT NOT NULL,
  patientunitstayid INT NOT NULL,
  allergyoffset INT NOT NULL,
  allergyenteredoffset INT NOT NULL,
  allergynotetype VARCHAR(255),
  specialtytype VARCHAR(255),
  usertype VARCHAR(255) NOT NULL,
  rxincluded VARCHAR(5),
  writtenineicu VARCHAR(5),
  drugname VARCHAR(255) NOT NULL,
  allergytype VARCHAR(255),
  allergyname VARCHAR(255),
  drughiclseqno INT
) ;


--------------------------------------------------------
--  DDL for Table APACHEAPSVAR
--------------------------------------------------------

DROP TABLE IF EXISTS apacheapsvar CASCADE;
CREATE TABLE apacheapsvar
(
  apacheapsvarid INT,
	patientunitstayid INT,
	intubated SMALLINT,
	vent SMALLINT,
	dialysis SMALLINT,
	eyes SMALLINT,
	motor SMALLINT,
	verbal SMALLINT,
	meds SMALLINT,
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
--  DDL for Table APACHEPATIENTRESULT
--------------------------------------------------------

DROP TABLE IF EXISTS apachepatientresult CASCADE;
CREATE TABLE apachepatientresult
(
  apachepatientresultsid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	physicianspeciality VARCHAR(50),
	physicianinterventioncategory VARCHAR(50),
	acutephysiologyscore INT,
	apachescore INT,
	apacheversion VARCHAR(5) NOT NULL,
	predictedicumortality VARCHAR(50),
	actualicumortality VARCHAR(50),
	predictediculos DOUBLE PRECISION,
	actualiculos DOUBLE PRECISION,
	predictedhospitalmortality VARCHAR(50),
	actualhospitalmortality VARCHAR(50),
	predictedhospitallos DOUBLE PRECISION,
	actualhospitallos DOUBLE PRECISION,
	preopmi INT,
	preopcardiaccath INT,
	ptcawithin24h INT,
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
  apachepredvarid INT,
	patientunitstayid INT,
	sicuday SMALLINT,
	saps3day1 SMALLINT,
	saps3today SMALLINT,
	saps3yesterday SMALLINT,
	gender SMALLINT,
	teachtype SMALLINT,
	region SMALLINT,
	bedcount SMALLINT,
	admitsource SMALLINT,
	graftcount SMALLINT,
	meds SMALLINT,
	verbal SMALLINT,
	motor SMALLINT,
	eyes SMALLINT,
	age SMALLINT,
	admitdiagnosis VARCHAR(11),
	thrombolytics SMALLINT,
	diedinhospital SMALLINT,
	aids SMALLINT,
	hepaticfailure SMALLINT,
	lymphoma SMALLINT,
	metastaticcancer SMALLINT,
	leukemia SMALLINT,
	immunosuppression SMALLINT,
	cirrhosis SMALLINT,
	electivesurgery SMALLINT,
	activetx SMALLINT,
	readmit SMALLINT,
	ima SMALLINT,
	midur SMALLINT,
	ventday1 SMALLINT,
	oobventday1 SMALLINT,
	oobintubday1 SMALLINT,
	diabetes SMALLINT,
	managementsystem SMALLINT,
	var03hspxlos DOUBLE PRECISION,
	pao2 DOUBLE PRECISION,
	fio2 DOUBLE PRECISION,
	ejectfx DOUBLE PRECISION,
	creatinine DOUBLE PRECISION,
	dischargelocation SMALLINT,
	visitnumber SMALLINT,
	amilocation SMALLINT,
	day1meds SMALLINT,
	day1verbal SMALLINT,
	day1motor SMALLINT,
	day1eyes SMALLINT,
	day1pao2 DOUBLE PRECISION,
	day1fio2 DOUBLE PRECISION
) ;

--------------------------------------------------------
--  DDL for Table CAREPLANCAREPROVIDER
--------------------------------------------------------

DROP TABLE IF EXISTS careplancareprovider CASCADE;
CREATE TABLE careplancareprovider
(
	cplcareprovderid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	careprovidersaveoffset INT NOT NULL,
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
  cpleolid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	cpleolsaveoffset INT NOT NULL,
	cpleoldiscussionoffset INT,
	activeupondischarge VARCHAR(10)
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANGENERAL
--------------------------------------------------------

DROP TABLE IF EXISTS careplangeneral CASCADE;
CREATE TABLE careplangeneral
(
  cplgeneralid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	activeupondischarge VARCHAR(10) NOT NULL,
	cplitemoffset INT NOT NULL,
	cplgroup VARCHAR(255) NOT NULL,
	cplitemvalue VARCHAR(1024)
) ;
--------------------------------------------------------
--  DDL for Table CAREPLANGOAL
--------------------------------------------------------

DROP TABLE IF EXISTS careplangoal CASCADE;
CREATE TABLE careplangoal
(
	cplgoalid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	CPLGOALoffset INT NOT NULL,
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
  cplinfectid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	activeupondischarge VARCHAR(10) NOT NULL,
	cplinfectdiseaseoffset INT NOT NULL,
	infectdiseasesite VARCHAR(64),
	infectdiseaseassessment VARCHAR(64),
	responsetotherapy VARCHAR(32),
	treatment VARCHAR(32)
) ;
--------------------------------------------------------
--  DDL for Table CUSTOMLAB
--------------------------------------------------------

DROP TABLE IF EXISTS customlab CASCADE;
CREATE TABLE customlab
(
	customlabid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	labotheroffset INT NOT NULL,
	labothertypeid INT NOT NULL,
	labothername VARCHAR(64),
	labotherresult VARCHAR(64),
	labothervaluetext VARCHAR(128)
) ;
--------------------------------------------------------
--  DDL for Table DIAGNOSIS
--------------------------------------------------------

DROP TABLE IF EXISTS diagnosis CASCADE;
CREATE TABLE diagnosis
(
  diagnosisid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	activeupondischarge VARCHAR(64),
	diagnosisoffset INT NOT NULL,
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
  infusiondrugid INT NOT NULL,
  patientunitstayid INT NOT NULL,
  infusionoffset INT NOT NULL,
  drugname VARCHAR(255) NOT NULL,
  drugrate VARCHAR(255),
  infusionrate VARCHAR(255),
  drugamount VARCHAR(255),
  volumeoffluid VARCHAR(255),
  patientweight VARCHAR(255)
) ;

--------------------------------------------------------
--  DDL for Table INTAKEOUTPUT
--------------------------------------------------------

DROP TABLE IF EXISTS intakeoutput CASCADE;
CREATE TABLE intakeoutput
(
	intakeoutputid INT NOT NULL,
  patientunitstayid INT NOT NULL,
	intakeoutputoffset INT NOT NULL,
	intaketotal NUMERIC(12,4),
	outputtotal NUMERIC(12,4),
	dialysistotal NUMERIC(12,4),
	nettotal NUMERIC(12,4),
	intakeoutputentryoffset INT NOT NULL,
	cellpath VARCHAR(500),
	celllabel VARCHAR(255),
	cellvaluenumeric NUMERIC(12,4) NOT NULL,
	cellvaluetext VARCHAR(255) NOT NULL
) ;

--------------------------------------------------------
--  DDL for Table LAB
--------------------------------------------------------

DROP TABLE IF EXISTS lab CASCADE;
CREATE TABLE lab
(
  labid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	labresultoffset INT NOT NULL,
	labtypeid NUMERIC(3,0) NOT NULL,
	labname VARCHAR(256),
	labresult NUMERIC(11,4),
	labresulttext VARCHAR(255),
	labmeasurenamesystem VARCHAR(255),
	labmeasurenameinterface VARCHAR(255),
	labresultrevisedoffset INT
) ;

--------------------------------------------------------
--  DDL for Table MEDICATION
--------------------------------------------------------

DROP TABLE IF EXISTS medication CASCADE;
CREATE TABLE medication
(
    medicationid INT NOT NULL,
    patientunitstayid INT NOT NULL,
    drugorderoffset INT NOT NULL,
    drugstartoffset INT NOT NULL,
    drugivadmixture VARCHAR(6) NOT NULL,
    drugordercancelled VARCHAR(6) NOT NULL,
    drugname VARCHAR(220),
    drughiclseqno INT,
    dosage VARCHAR(60),
    routeadmin VARCHAR(120),
    frequency VARCHAR(255),
    loadingdose VARCHAR(120) NOT NULL,
    prn VARCHAR(6) NOT NULL,
    drugstopoffset INT NOT NULL,
    gtc INT NOT NULL
) ;

--------------------------------------------------------
--  DDL for Table MICROLAB
--------------------------------------------------------

DROP TABLE IF EXISTS microlab CASCADE;
CREATE TABLE microlab
(
    microlabid INT NOT NULL,
    patientunitstayid INT NOT NULL,
  	culturetakenoffset INT NOT NULL,
  	culturesite VARCHAR(255) NOT NULL,
  	organism VARCHAR(255) NOT NULL,
  	antibiotic VARCHAR(255),
  	sensitivitylevel VARCHAR(255)
) ;

--------------------------------------------------------
--  DDL for Table NOTE
--------------------------------------------------------

DROP TABLE IF EXISTS note CASCADE;
CREATE TABLE note
(
	NOTEID INT NOT NULL,
	patientunitstayid INT NOT NULL,
	NOTEOFFSET INT NOT NULL,
	NOTEENTEREDOFFSET INT NOT NULL,
	NOTETYPE VARCHAR(50) NOT NULL,
	NOTEPATH VARCHAR(255) NOT NULL,
	NOTEVALUE VARCHAR(150),
	NOTETEXT VARCHAR(500)
) ;

--------------------------------------------------------
--  DDL for Table NURSEASSESSMENT
--------------------------------------------------------

DROP TABLE IF EXISTS NURSEASSESSMENT CASCADE;
CREATE TABLE NURSEASSESSMENT
(
	nurseassessid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	NURSEASSESSOFFSET INT NOT NULL,
	NURSEASSESSENTRYOFFSET INT NOT NULL,
	CELLATTRIBUTEPATH VARCHAR(255) NOT NULL,
	CELLLABEL VARCHAR(255) NOT NULL,
	CELLATTRIBUTE VARCHAR(255) NOT NULL,
	CELLATTRIBUTEVALUE VARCHAR(4000)
) ;

--------------------------------------------------------
--  DDL for Table NURSECARE
--------------------------------------------------------

DROP TABLE IF EXISTS NURSECARE CASCADE;
CREATE TABLE NURSECARE
(
  nursecareid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	CELLLABEL VARCHAR(255) NOT NULL,
	NURSECAREOFFSET INT NOT NULL,
	NURSECAREENTRYOFFSET INT NOT NULL,
	CELLATTRIBUTEPATH VARCHAR(255) NOT NULL,
	CELLATTRIBUTE VARCHAR(255) NOT NULL,
	CELLATTRIBUTEVALUE VARCHAR(4000)
) ;

--------------------------------------------------------
--  DDL for Table NURSECHARTING
--------------------------------------------------------

DROP TABLE IF EXISTS NURSECHARTING CASCADE;
CREATE TABLE NURSECHARTING
(
  nursingchartid BIGINT NOT NULL,
	patientunitstayid INT NOT NULL,
	NURSINGCHARTOFFSET INT NOT NULL,
	NURSINGCHARTENTRYOFFSET INT NOT NULL,
	NURSINGCHARTCELLTYPECAT VARCHAR(255) NOT NULL,
	NURSINGCHARTCELLTYPEVALLABEL VARCHAR(255),
	NURSINGCHARTCELLTYPEVALNAME VARCHAR(255),
	NURSINGCHARTVALUE VARCHAR(255)
) ;

--------------------------------------------------------
--  DDL for Table PASTHISTORY
--------------------------------------------------------

DROP TABLE IF EXISTS pasthistory CASCADE;
CREATE TABLE pasthistory
(
	pasthistoryid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	pasthistoryoffset INT NOT NULL,
	pasthistoryenteredoffset INT NOT NULL,
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
	patientunitstayid INT,
	patienthealthsystemstayid INT,
	gender VARCHAR(25),
	age VARCHAR(10),
	ethnicity VARCHAR(50),
	hospitalid INT,
	wardid INT,
	apacheadmissiondx VARCHAR(1000),
	admissionheight NUMERIC(10,2),
	hospitaladmittime24 VARCHAR(8),
	hospitaladmitoffset INT,
	hospitaladmitsource VARCHAR(30),
	hospitaldischargeyear SMALLINT,
	hospitaldischargetime24 VARCHAR(8),
	hospitaldischargeoffset INT,
	hospitaldischargelocation VARCHAR(100),
	hospitaldischargestatus VARCHAR(10),
	unittype VARCHAR(50),
	unitadmittime24 VARCHAR(8),
	unitadmitsource VARCHAR(100),
	unitvisitnumber INT,
	unitstaytype VARCHAR(15),
	admissionweight NUMERIC(10,2),
	dischargeweight NUMERIC(10,2),
	unitdischargetime24 VARCHAR(8),
	unitdischargeoffset INT,
	unitdischargelocation VARCHAR(100),
	unitdischargestatus VARCHAR(10),
	uniquepid VARCHAR(10)
) ;

--------------------------------------------------------
--  DDL for Table PHYSICALEXAM
--------------------------------------------------------

DROP TABLE IF EXISTS physicalexam CASCADE;
CREATE TABLE physicalexam
(
	physicalexamid INT,
	patientunitstayid INT NOT NULL,
	physicalexamoffset INT NOT NULL,
	physicalexampath VARCHAR(255) NOT NULL,
	physicalexamvalue VARCHAR(100),
	physicalexamtext VARCHAR(500)
) ;

--------------------------------------------------------
--  DDL for Table RESPIRATORYCARE
--------------------------------------------------------

DROP TABLE IF EXISTS RESPIRATORYCARE CASCADE;
CREATE TABLE RESPIRATORYCARE
(
  RESPCAREID INT,
	PATIENTUNITSTAYID INT,
	RESPCARESTATUSOFFSET INT,
	CURRENTHISTORYSEQNUM INT,
	AIRWAYTYPE VARCHAR(30),
	AIRWAYSIZE VARCHAR(10),
	AIRWAYPOSITION VARCHAR(32),
	CUFFPRESSURE NUMERIC(5,1),
	VENTSTARTOFFSET INT,
	VENTENDOFFSET INT,
	PRIORVENTSTARTOFFSET INT,
	PRIORVENTENDOFFSET INT,
	APNEAPARAMS VARCHAR(80),
	LOWEXHMVLIMIT NUMERIC(11,4),
	HIEXHMVLIMIT NUMERIC(11,4),
	LOWEXHTVLIMIT NUMERIC(11,4),
	HIPEAKPRESLIMIT NUMERIC(11,4),
	LOWPEAKPRESLIMIT NUMERIC(11,4),
	HIRESPRATELIMIT NUMERIC(11,4),
	LOWRESPRATELIMIT NUMERIC(11,4),
	SIGHPRESLIMIT NUMERIC(11,4),
	LOWIRONOXLIMIT NUMERIC(11,4),
	HIGHIRONOXLIMIT NUMERIC(11,4),
	MEANAIRWAYPRESLIMIT NUMERIC(11,4),
	PEEPLIMIT NUMERIC(11,4),
	CPAPLIMIT NUMERIC(11,4),
	SETAPNEAINTERVAL VARCHAR(80),
	SETAPNEATV VARCHAR(80),
	SETAPNEAIPPEEPHIGH VARCHAR(80),
	SETAPNEARR VARCHAR(80),
	SETAPNEAPEAKFLOW VARCHAR(80),
	SETAPNEAINSPTIME VARCHAR(80),
	SETAPNEAIE VARCHAR(80),
	SETAPNEAFIO2 VARCHAR(80)
) ;

--------------------------------------------------------
--  DDL for Table RESPIRATORYCHARTING
--------------------------------------------------------

DROP TABLE IF EXISTS RESPIRATORYCHARTING CASCADE;
CREATE TABLE RESPIRATORYCHARTING
(
  RESPCHARTID INT,
	PATIENTUNITSTAYID INT,
	RESPCHARTOFFSET INT,
	RESPCHARTENTRYOFFSET INT,
	RESPCHARTTYPECAT VARCHAR(255),
	RESPCHARTVALUELABEL VARCHAR(255),
	RESPCHARTVALUE VARCHAR(1000)
) ;

--------------------------------------------------------
--  DDL for Table TREATMENT
--------------------------------------------------------

DROP TABLE IF EXISTS treatment CASCADE;
CREATE TABLE treatment
(
  treatmentid INT,
	patientunitstayid INT,
	treatmentoffset INT,
	treatmentstring VARCHAR(200),
	activeupondischarge VARCHAR(10)
) ;
--------------------------------------------------------
--  DDL for Table VITALAPERIODIC
--------------------------------------------------------

DROP TABLE IF EXISTS vitalaperiodic CASCADE;
CREATE TABLE vitalaperiodic
(
  vitalaperiodicid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	observationoffset INT NOT NULL,
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
  vitalperiodicid BIGINT,
	patientunitstayid INT,
	observationoffset INT,
	temperature NUMERIC(11,4),
	sao2 INT,
	heartrate INT,
	respiration INT,
	cvp INT,
	etco2 INT,
	systemicsystolic INT,
	systemicdiastolic INT,
	systemicmean INT,
	pasystolic INT,
	padiastolic INT,
	pamean INT,
	st1 DOUBLE PRECISION,
	st2 DOUBLE PRECISION,
	st3 DOUBLE PRECISION,
	icp INT
) ;
