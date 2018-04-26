+++
date = "2015-09-01T19:34:46-04:00"
title = "apachePredVar"
linktitle = "apachePredVar"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# apachePredVar

**Purpose:** Provides variables underlying the APACHE predictions. Acute Physiology Age Chronic Health Evaluation (APACHE) consists of a groups of equations used for predicting outcomes in critically ill patients. APACHE II is based on the APS or acute physiology score  (which uses 12 physiologic values), age, and chronic health status within one of 56 disease groups. APACHE II is no longer considered valid due to inadequate case mix index adjustments and over estimates mortality because it is based on models from the 1970s-1980s. APACHE III, introduced in 1991, improved the equation by changing the number and weights of the APS and revising the measurement of chronic health status. APACHE IVa further improved the equations and has been described as having the highest discrimination of any other adult risk adjustment model (SAPS 3, SOFA, MPM III).

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* oOBVentDay1 and oOBIntubDay1
    * if a patient is intubated on day 1 they are mechanically ventilated
    * if a patient is ventilated on day 1, but not intubated, they are non-invasively ventilated

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`apachePredVarID` | int | NOT NULL | surrogate key for the APACHE Prediction variables | PK | S
`sicuDay` | int | NULL | set to default value 1 |  | S
`saps3Day1` | int | NULL | set to default value 0 |  | S
`saps3Today` | int | NULL | set to default value 0 |  | S
`saps3Yesterday` | int | NULL | set to default value 0 |  | S
`gender` | int | NULL | Female =1, Male = 0 , Not available =-1 |  | S
`teachType` | int | NULL | Set to default value of 0 |  | S
`region` | int | NULL | Set to default value of 3 |  | S
`bedcount` | int | NULL | XXX | XxX | XXX | XXX
`admitSource` | int | NULL | Number indicating admit Source for a unit (1 to 8) |  | S
`graftCount` | int | NULL | Number selected for the patient when a CABG admission diagnosis is selected for the patient in eCare. Default is 3 |  | S
`meds` | int | NULL | 0 when ‘unable to score due to meds’ is not selected in eCare or there are valid GCS values. 1 when ‘unable to score due to meds’ is selected in eCare. -1 when no meds info is available |  | S
`verbal` | int | NULL | GCS verbal score from worst GCS set |  | S
`motor` | int | NULL | GCS motor score from worst GCS set |  | S
`eyes` | int | NULL | GCS eyes score from worst GCS set |  | S
`age` | int | NULL | Age in years |  | S
`admitDiagnosis` | varchar(11) | NULL | Apache admission diagnosis code |  | S
`thrombolytics` | int | NULL | 0/1. 0 – Patient doesn’t has thrombolytics, 1 - Patient has thrombolytics |  | S
`diedInHospital` | int | NULL | 0/1. 1 – Patient died in hospital |  | S
`aids` | int | NULL | 0/1. 0 – Patient doesn’t has aids, 1 - Patient has aids |  | S
`hepaticFailure` | int | NULL | 0/1. 0 – Patient doesn’t has hepaticFailure, 1 - Patient has hepaticFailure |  | S
`lymphoma` | int | NULL | 0/1. 0 – Patient doesn’t has lymphoma, 1 - Patient has lymphoma |  | S
`metastaticCancer` | int | NULL | 0/1. 0 – Patient doesn’t has metastaticCancer, 1 - Patient has metastaticCancer |  | S
`leukemia` | int | NULL | 0/1. 0 – Patient doesn’t has leukemia, 1 - Patient has leukemia |  | S
`immunosuppression` | int | NULL | 0/1. 0 – Patient doesn’t has immunosuppression, 1 - Patient has immunosuppression |  | S
`cirrhosis` | int | NULL | 0/1. 0 – Patient doesn’t has cirrhosis, 1 - Patient has cirrhosis |  | S
`electiveSurgery` | int | NULL | 0/1. 0 – Patient doesn’t has elective Surgery, 1 - Patient has elective Surgery |  | S
`activeTx` | int | NULL | 0/1. Indicates if the Patient has active Treatment |  | S
`readmit` | int | NULL | 0/1. Indicates if the Patient was readmitted |  | S
`ima` | int | NULL | Indicates if ‘Internal Mammary Artery Graft’ field was selected in eCare or not for the patient |  | S
`midur` | int | NULL | Indicates if patient had MI within 6 months |  | S
`ventDay1` | int | NULL | Indicates if patient was ventilated for the worst respiratory rate |  | S
`oOBVentDay1` | int | NULL | Indicates if patient was ventilated at anytime for the apache day |  | S
`oOBIntubDay1` | int | NULL | Indicates if patient was intubated at anytime for the apache day |  | S
`diabetes` | int | NULL | 0/1. 0 – Patient doesn’t has diabetes, 1 - Patient has diabetes |  | S
`managementSystem` | int | NULL | Not used |  | S
`var03HspXlos` | float(53) | NULL | Not used |  | S
`pao2` | float(53) | NULL | paO2 value from the worst ABG data set for the Apache Day |  | S
`fio2` | float(53) | NULL | fiO2 value from the worst ABG data set for the Apache Day |  | S
`ejectFx` | float(53) | NULL |  |  | S
`creatinine` | float(53) | NULL | Worst creatinine value for the Apache day |  | S
`dischargelocation` | int | NULL | Value indicating discharge location for the patient |  | S
`visitNumber` | int | NULL | value indicating number of unit admission |  | S
`amilocation` | int | NULL | 1 to 7. Value indicating AMI Location |  | S
`day1meds` | int | NULL | 0 when ‘unable to score due to meds’ is not selected in eCare or there are valid GCS values. 1 when ‘unable to score due to meds’ is selected in eCare. -1 when no meds info is available |  | S
`day1verbal` | int | NULL | GCS verbal score from worst GCS set |  | S
`day1motor` | int | NULL | GCS motor score from worst GCS set |  | S
`day1eyes` | int | NULL | GCS eyes score from worst GCS set |  | S
`day1pao2` | float(53) | NULL | paO2 value from the worst ABG data set for the Apache Day |  | S
`day1fio2` | float(53) | NULL | fiO2 value from the worst ABG data set for the Apache Day |  | S

<!-- # Detailed description

* To follow. -->

# Further reading

* https://www.cerner.com/Solutions/Hospitals_and_Health_Systems/Critical_Care/APACHE_Outcomes/
* http://www.ncbi.nlm.nih.gov/pubmed/22499827
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198495/
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2887099/
