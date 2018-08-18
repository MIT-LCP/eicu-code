+++
date = "2015-09-01T19:34:46-04:00"
title = "physicalExam"
linktitle = "physicalExam"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# physicalExam

**Purpose:**
The physical exam section allows users to document results of a physical exam.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

Data for physical exam are entered directly into eCareManager. The choices for the physical exam include Not Performed, Performed-Free Text, and Performed-Structured, however the free text sections are not included in the research database. The Structured option allows a large variety of pick list selections and specific text entry boxes to create a structured physical exam.

Physical Exam: The table below lists the data displayed in the Constitutional Data field and the selection criteria for this data (e.g., most recent 15 minute mean value). The values for heart rate, blood pressure, temperature, respiratory rate and O2 sat include the 24 hour range as well as the current values.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`physicalExamID` | int | IDENTITY | surrogate key for the physical exam item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`physicalExamOffset` | int | NOT NULL | number of minutes from unit admit time that the physical exam item was entered |  | C
`physicalExamPath` | varchar(255) | NOT NULL | the root path of the physical exam item e.g.: notes/Progress Notes/Physical Exam/Physical Exam/Constitutional/Vital Sign and Physiological Data/Resp Rate/Resp Current, notes/Progress Notes/Physical Exam/Physical Exam/Neurologic/GCS/Verbal Score/5, etc. |  | S
`physicalExamValue` | varchar(100) | NULL | Structured picklist of available of physical exam items: O2 Sat% Highest, withdraws to pain, HR Current, etc. |  | S
`physicalExamText` | varchar(500) | NOT NULL | The string builder value of the physical exam item e.g.: manual entry, 85, no wheezing, etc. |  | S

<!-- # Detailed description

* To follow. -->
