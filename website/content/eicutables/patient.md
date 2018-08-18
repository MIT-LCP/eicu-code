+++
date = "2015-09-01T19:34:46-04:00"
title = "patient"
linktitle = "patient"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# patient

**Purpose:** Contains patient demographics and admission and discharge details for hospital and ICU stays.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

All stays are centered on ICU admission. That is, there is *no* `unitAdmitOffset` column: it is 0 for all `patientUnitStayID`. Note that within a hospital admission, distinct unit stays can be linked by `patientHealthSystemStayID`. Keep in mind that offsets are still based upon `patientUnitStayID`, for example:

`patientUnitStayID` | `patientHealthSystemStayID` | `unitDischargeOffset` | `hospitalAdmitOffset` | `hospitalDischargeOffset` | Comment
--- | --- | --- | --- | --- | ---
2 | 800 | 4320 | -5040 | 10960 | The *second* ICU stay.
10 | 800 | 2160 | -720 | 15280 | The *first* ICU stay.

The hospital course for this patient was:

* patient admitted to hospital
* first ICU admission (`patientUnitStayID` = 10) at 720 minutes after hospital admission (`hospitalAdmitOffset` = -720)
* first ICU discharge (`unitDischargeOffset` = 2160) at 720+2160 minutes after hospital admission (`unitDischargeOffset` - `hospitalAdmitOffset` = 2160 - (-720) = 2880)
* second ICU admission (`patientUnitStayID` = 2) at 5040 minutes after hospital admission (`hospitalAdmitOffset` = -5040)
* second ICU discharge (`unitDischargeOffset` = 4320) at 9360 minutes after hospital admission (`unitDischargeOffset` - `hospitalAdmitOffset` = 4320 - (-5040) = 9360)
* hospital discharge, total length of stay = (10960 - (-5040)) = (15280 - (-720)) = 16000

Note that the first ICU stay has a *larger* `hospitalAdmitOffset`, because this stay occurred closer to hospital admission (i.e. it was first). Also note that there is no correlation between `patientUnitStayID` and the order of patient stays.

There is no systematic method for chronologically ordering `patientHealthSystemStayID` for the same patient within the same year.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | surrogate key for ICU Stay | PK | C
`patientHealthSystemStayID` | int | NOT NULL | surrogate key for the patient health system stay (hospital stay) | FK | C
`gender` | varchar(25) | NULL | gender of the patient: Male, Female, Unknown, Other, NULL |  | S
`age` | varchar(10) | NULL | age of the patient in full years. If the patient is over 89 years old specify "> 89" e.g.: 79, 36, 52, "> 89", etc. |  | T
`ethnicity` | varchar(50) | NULL | picklist ethnicity of the patient: Asian, Caucasian, African American, Native American, Hispanic, Other/Unknown, NULL |  | S
`hospitalID` | int | NOT NULL | surrogate key for the hospital associated with the patient unit stay |  | C
`wardID` | int | NOT NULL | surrogate key for the ward associated with the patient unit stay |  | C
`apacheAdmissionDx` | varchar(1000) | NULL | Full path string of admission diagnosis for patients unit stay e.g.: Pulmonary valve surgery, Chest pain, unknown origin, Restrictive lung disease (i.e., Sarcoidosis, pulmonary fibrosis), etc. |  | S
`admissionHeight` | decimal(10,2) | NULL | admission height of the patient in cm e.g.: 160.0000, 182.9000, 175.3000, etc. |  | S
`hospitalAdmitTime24` | time(0) | NOT NULL | time in 24 hour format of the hospital admit e.g.: "12:45", "15:30", "3:45" |  | T
`hospitalAdmitOffset` | int | NOT NULL | number of minutes from unit admit time that the patient was admitted to the hospital |  | C
`hospitalAdmitSource` | varchar(30) | NULL | location from where the patient was admitted to the hospital e.g.: Direct Admit, Floor, Chest Pain Center. etc. |  | S
`hospitalDischargeYear` | smallint | NOT NULL | year of the hospital discharge date |  | T
`hospitalDischargeTime24` | time(0) | NOT NULL | time in 24 hour format of when the hospital discharge event occurred e.g.: "12:45", "15:30", "3:45" |  | T
`hospitalDischargeOffset` | int | NOT NULL | number of minutes from unit admit time that the patient was discharged from the hospital |  | C
`hospitalDischargeLocation` | varchar(100) | NULL | Structured list of location where the patient was discharged to from the hospital e.g.: Home, Nursing Home, Death, etc. |  | S
`hospitalDischargeStatus` | varchar(10) | NULL | specifies patient’s condition upon leaving the hospital: Alive, Expired, or NULL |  | S
`unitType` | varchar(50) | NULL | the picklist unit type of the unit e.g.: MICU,Cardiovascular ICU,SDU/Step down,VICU,Neuro ICU,CCU,Virtual ICU,SICU,ICU,CCU-CTICU,Mobile ICU,CTICU,CSICU,Test ICU,Vent ICU,Burn-Trauma ICU |  | S
`unitAdmitTime24` | time(0) | NOT NULL | time in 24 hour format of when the unit admit event occurred e.g.: "12:45", "15:30", "3:45" |  | T
`unitAdmitSource` | varchar(100) | NULL | picklist location from where the patient was admitted e.g.: Emergency Room, Recovery Room, Direct Admit, etc. |  | S
`unitVisitNumber` | int | NOT NULL | identifies the visit number of the patient, i.e. if the patient's hospital stay has multiple unit stays |  | C
`unitStayType` | varchar(15) | NULL | patient's unit stay type: stepdown/other, readmit for undo, admit, pre-admit, transfer, readmit |  | S
`admissionWeight` | decimal(10,2) | NULL | admission weight of the patient in kilograms e.g.: 69.7000, 70.9000, 173.0000, etc. |  | S
`dischargeWeight` | decimal(10,2) | NULL | patient weight at time of unit discharge in kilograms e.g.: 69.7000, 70.9000, 173.0000, etc. |  | S
`unitDischargeTime24` | time(0) | NOT NULL | time in 24 hour format of when the unit discharge event occurred e.g.: "12:45", "15:30", "3:45" |  | T
`unitDischargeOffset` | int | NOT NULL | number of minutes from unit admit time that the patient was discharged from the unit |  | C
`unitDischargeLocation` | varchar(100) | NULL | Structured list of locations where the patient was discharged to from the unit e.g.: Other ICU (CABG), Other Hospital, Telemetry, Other Internal, Other ICU, Floor, Step-Down Unit (SDU), etc. |  | S
`unitDischargeStatus` | varchar(10) | NULL | specifies patient’s condition upon leaving the unit: Alive, Expired, or NULL |  | S
`uniquepid` | varchar(10) | NOT NULL | ID for a unique patient. |  | C


<!-- # Detailed description

* To follow. -->
