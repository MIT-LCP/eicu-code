+++
date = "2015-09-01T19:34:46-04:00"
title = "pastHistory"
linktitle = "pastHistory"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# pastHistory

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`pastHistoryID` | int | IDENTITY | surrogate key for the past history item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`pastHistoryYear` | smallint | NOT NULL | year for the past history item |  | T
`pastHistoryTime24` | time(0) | NOT NULL | time in 24 hour format of the past history event e.g.: "12:45", "15:30", "3:45" |  | T
`pastHistoryTime` | varchar(20) | NOT NULL | time frame for the past history item: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`pastHistoryOffset` | int | NOT NULL | number of minutes from unit admit time for the past history item |  | C
`pastHistoryEnteredYear` | smallint | NOT NULL | year when the past history item was entered |  | T
`pastHistoryEnteredTime24` | time(0) | NOT NULL | time in 24 hour format of when the past history event was entered e.g.: "12:45", "15:30", "3:45" |  | T
`pastHistoryEnteredTime` | varchar(20) | NOT NULL | time frame when the past history item was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`pastHistoryEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the past history item was entered |  | C
`pastHistoryNoteType` | varchar(20) | NULL | note type for the past history item e.g.: Admission, Initial Consultation/Other, Re-Admission, etc. |  | S
`pastHistoryPath` | varchar(255) | NOT NULL | the root path of the past history item e.g.: notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (A)/Cancer Therapy/Chemotherapy/Cis-platinum, etc. |  | S
`pastHistoryValue` | varchar(100) | NULL | Structured picklist of available past history items e.g.: Performed, hypercoagulable condition, COPD - no limitations, etc. |  | S
`pastHistoryValueText` | varchar(255) | NULL | the picklist value of the past history item e.g.: COPD - Moderate, CHF, Medication dependent, etc. |  | S

<!-- # Detailed description

* To follow. -->
