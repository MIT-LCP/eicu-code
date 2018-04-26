+++
date = "2015-09-01T19:34:46-04:00"
title = "apachePatientResult"
linktitle = "apachePatientResult"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# apachePatientResult

**Purpose:** Provides predictions made by the APACHE score (versions IV and IVa), including probability of mortality, length of stay, and ventilation days.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* APACHE defines actual hospital mortality by an admission, discharge, transfer (ADT) hospital disposition as "expired" or "dead". ICU mortality is defined as a unit dispostion in the ADT system as "expired" or "dead". Some patients will have more than one ICU admission. For each ICU admission the patient will have a disposition of either dead (expired) or alive.
* Predicted mortality is the percent risk of death for an individual patient. This is displayed as decimal. The sum of every patient’s risk of death within the population of interest equals the number of deaths predicted in that population.
* APACHE ICU length of stay refers to the number of days and partial days that a patient was in an ICU. Hospital LOS represents the total number of days and partial days that a patient was in the hospital during a unique hospitalization.
* Patients with an ICU stay less than 4 hours, most transplant patients, burn patients, and patients less than sixteen years of age will be classified as non-predictive.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`apachePatientsResultsID` | int | IDENTITY | surrogate key for the APACHE patient results | PK | S
`physicianSpeciality` | varchar(50) | NULL | Physician Specialty picklist value |  | S
`physicianInterventionCategory` | varchar(50) | NULL | Physician Intervention Category picklist value |  | S
`acutePhysiologyScore` | int | NULL | Acute Physiology Score from Apache API |  | S
`apacheScore` | int | NULL | Apache Score. Calculated from acutePhysiologyScore |  | S
`apacheVersion` | tinyint | NOT NULL | The version of the APACHE algorithm used to produce the apacheScore (e.g 3, 4) |  | S
`predictedICUMortality` | varchar(50) | NULL | Predicted ICU Mortality from Apache API |  | S
`actualICUMortality` | varchar(50) | NULL | Actual ICU Mortality |  | S
`predictedICULOS` | float(53) | NULL | Predicted ICU Length of Stay from Apache API |  | S
`actualICULOS` | float(53) | NULL | Actual ICU Length of Stay |  | S
`predictedHospitalMortality` | varchar(50) | NULL | Predicted Hospital Mortality from Apache API |  | S
`actualHospitalMortality` | varchar(50) | NULL | Actual Hospital Mortality |  | S
`predictedHospitalLOS` | float(53) | NULL | Predicted Hospital Length of Stay from Apache API |  | S
`actualHospitalLOS` | float(53) | NULL | Actual Hospital Length of Stay. Value is 50 when when > 50 days. |  | S
`preopMI` | int | NULL | Indicates if patient has pre –Operative Myocardial Infarction |  | S
`preopCardiacCath` | int | NULL | Indicates if patient has pre –Operative cardiac catheterization |  | S
`PTCAwithin24h` | int | NULL | 0/1. 1- Patient had PTCA with 24 hrs |  | S
`unabridgedUnitLOS` | float(53) | NULL | Actual ICU Length of stay |  | S
`unabridgedHospLOS` | float(53) | NULL | Actual Hospital Length of stay |  | S
`actualVentdays` | float(53) | NULL | Actual Ventilation days. Value is 30 when Actual Ventilation > 30 |  | S
`predVentdays` | float(53) | NULL | Predicted ventilation days from Apache API |  | S
`unabridgedActualVentdays` | float(53) | NULL | Actual Ventilation days |  | S

<!-- # Detailed description

* To follow. -->

# Further reading

* https://www.cerner.com/Solutions/Hospitals_and_Health_Systems/Critical_Care/APACHE_Outcomes/
* http://www.ncbi.nlm.nih.gov/pubmed/22499827
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198495/
* http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2887099/
