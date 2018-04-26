+++
date = "2015-09-01T19:34:46-04:00"
title = "apacheApsVar"
linktitle = "apacheApsVar"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# apacheApsVar

**Purpose:** Contains the variables used to calculate the Acute Physiology Score (APS) III for patients. APS-III is an established method of summarizing patient severity of illness on admission to the ICU, and is a part of the Acute Physiology Age Chronic Health Evaluation (APACHE) system of equations for predicting outcomes for ICU patients.

**Links to:**

* PATIENT on `patientUnitStayID`

**See also:**

* APACHEPATIENTRESULT
* APACHEPREDVAR

# Important considerations

* Acute Physiology Age Chronic Health Evaluation (APACHE) consists of a groups of equations used for predicting outcomes in critically ill patients.

* APACHE II, III and IV are based on the APS or acute physiology score (which uses 12 physiologic values), age, and chronic health status within one of 56 disease groups. APACHE II is no longer considered valid due to inadequate case mix index adjustments and over estimates mortality because it is based on models from the 1970s-1980s.

* APS points are assigned based upon the "Worst" values (measurement of the degree of physiologic derangement) that a patient exhibits during the APACHE Day. The "Worst" values tend to be those that are furthest away from the APACHE-defined mid-point.

* APACHE III, introduced in 1991, improved the equation by changing the number and weights of the APS and revising the measurement of chronic health status. The APACHE day refers to the time period in which clinical variables can be used in the algorithms.

* APACHE IVa further improved the equations and has been described as having the highest discrimination of any other adult risk adjustment model (SAPS 3, SOFA, MPM III).

* APACHE defines hospital mortality by an admission. discharge, transfer (ADT) hospital disposition as "expired" or "dead". ICU mortality is defined as a unit dispostion in the ADT system as "expired" or "dead". Some patients will have more than one ICU admission. For each ICU admission the patient will have a disposition of either dead (expired) or alive.

<!-- - Maybe say that APACHE IVa was updated using 2006–2008 patient data (Kramer CCM 2014 DOI: 10.1097/CCM.0b013e3182a66a49) -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table  | FK | C
`apacheApsVarID` | int | IDENTITY | surrogate key for APACHE APS (input) variables | PK | S
`intubated` | int | NULL | set to 0 when not populated; set to 1 when the patient is intubated at the time of the worst ABG result |   | S
`vent` | int | NULL | set to 0 when not populated; set to 1 when the patient is ventilated at the time of the worst respiratory rate |   | S
`dialysis` | int | NULL | set to 0 when not populated; set to 1 when it is indicated that the patient is on dialysis |   | S
`eyes` | int | NULL | set to NULL when not populated; set to 0 when meds field below is 1 (no GCS score); set to the value of the APACHE API’s eyes value in the worst GCS data set when the patient has a valid GCS score; range from 1 to 4 |   | S
`motor` | int | NULL | set to NULL when not populated; set to 0 when meds field below is 1 (no GCS score); set to the value of the APACHE API’s motor value in the worst GCS data set when the patient has a valid GCS score; range from 1 to 6 |   | S
`verbal` | int | NULL | set to NULL when not populated; set to 0 when meds field below is 1 (no GCS score); set to the value of the APACHE API’s verbal value in the worst GCS data set when the patient has a valid GCS score; range from 1 to 5 |   | S
`meds` | int | NULL | set to NULL when not populated; set to 1 when “unable to score due to meds” is selected and no GCS score is available for the APACHE day; set to 0 when “unable to score due to meds” is not selected and a valid GCS score is set |   | S
`urine` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s summed 24 hour urine output value when present |   | S
`wbc` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst WBC (white blood count) lab value when present |   | S
`temperature` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst Celsius temperature value when present |   | S
`respiratoryRate` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst respiratory rate value when present |   | S
`sodium` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst sodium lab value when present |   | S
`heartRate` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst heart rate value when present |   | S
`meanBp` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst mean blood pressure value when present |   | S
`ph` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s pH value for the worst ABG data set when present |   | S
`hematocrit` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst Hct lab value when present |   | S
`creatinine` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst creatinine lab value when present |   | S
`albumin` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst albumin lab value when present |   | S
`pao2` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s PaO2 value for the worst ABG data set when present |   | S
`pco2` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s paCO2 value for the worst ABG data set when present |   | S
`bun` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst BUN lab value when present |   | S
`glucose` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst glucose lab value when present |   | S
`bilirubin` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s worst bilirubin lab value when present |   | S
`fio2` | float(53) | NULL | set to NULL when not present; set to the APACHE API’s FiO2 value for the worst ABG data set when present |   | S

# Detailed description

## apacheApsVarID

## patientHealthSystemStayID
Each row of this table contains a unique patientHealthSystemStayID which represents a single patient’s admission to the hospital. The patientHealthSystemStayID ranges from blank - blank. The ADMISSIONS table can be linked to the PATIENTS table using patientHealthSystemStayID.

## patientUnitStayID
Each row of this table contains a unique patientUnitStayID  which represents a single patient’s admission to the ICU. The patientUnitStayID ranges from blank - blank. It is possible for this table to have duplicate patientHealthSystemStayID, indicating that a single patient had multiple admissions to the ICU. The ADMISSIONS table can be linked to the PATIENTS table using patientHealthSystemStayID.

## dialysis

## eyes

Worst total score ranging from 1-4 with 15 as set point documented in neurologic section under GCS (Glascow coma scale) in the admission note or nursing flowsheet

## motor

Worst total score ranging from 1-6 with 15 as set point documented in neurologic section under GCS (Glascow coma scale) in the admission note or nursing flowsheet

## verbal

Worst total score ranging from 1-5 with 15 as set point documented in neurologic section under GCS (Glascow coma scale) in the admission note or nursing flowsheet

Note for GCS eyes, motor, verbal scores: The GCS is determined based upon the patient's best response in each category during a single examination (highest level of integrated physiologic response). When the three component scores are added, the total Glasgow Coma Score ranges from 3 (worst) to 15 (best). The “worst” GCS in APACHE is the GCS assessment resulting in the lowest total score.

## meds

## urine

total urine output (mL/day) during the first APACHE day with set point of 3000 (mL/day). This value comes from the I&O section of the nursing flow sheet for the first 24 hours in the ICU following admission).

Each of the following variables are assessed a score based on its variation from a predetermined set or mid point. Variables that occur within the first APACHE day are included. If there are no laboratory variables in the first APACHE day then variables from

## wbc

worst WBC from midpoint 11.5 1000/uL

## temp

worst temperature from midpoint = 38° C

## respiratoryRate

worst respiratory rate (RR) from midpoint = 19 breaths/minute (required field)

## vent

the answer for “ventilated for this RR?” a yes is recorded for any modes of ventilation that mechanically assist or replace spontaneous breathing used to decrease the work of breathing.

## intubated

documented in physician note (admission/comprehensive/procedure), respiratory care flowsheet, or careplan

## sodium

worst sodium level from midpoint 145 mEq/L

## potassium

worst potassium level from midpoint 4.5 mEq/L

## heartRate

worst heart rate from midpoint = 75 beats per minute (required field)

## meanBp

worst mean blood pressure from midpoint = 90 mmHg (required field)

## bicarb

worst bicarbonate from midpoint 27.0 mEq/L

blood urea nitrogen (BUN): highest serum BUN (mg/dL)

## hematocrit

worst hematocrit from midpoint 45.5%

## creatinine

worst serum creatinine from midpoint 1.0 mg/dL

## albumin

worst serum albumin from midpoint 13.5 g/dL

## glucose

worst glucose from midpoint 130 mg/dL

## bilirubin

highest serum bilirubin (mg/dL)

## FiO2

Worst FiO2 from midpoint 21% documented in physician note, respiratory care flowsheet, or nursing flowsheet

## ABG-FiO2

Worst arterial blood gas (ABG) FiO2 from midpoint 21%

## ABG-PaO2

Worst arterial blood gas (ABG) PaO2 from midpoint 80 mm Hg

## ABG-PaCO2

Worst arterial blood gas (ABG) PaCO2 from midpoint 40 mm Hg

## ABG-pH

Worst arterial blood gas (ABG) pH from midpoint 7.4

# Further reading

* https://www.cerner.com/Solutions/Hospitals_and_Health_Systems/Critical_Care/APACHE_Outcomes/
* http://www.ncbi.nlm.nih.gov/pubmed/22499827
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198495/
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2887099/
