+++
date = "2015-09-01T19:34:46-04:00"
title = "physicalExam"
linktitle = "physicalExam"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# physicalExam

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`physicalExamID` | int | IDENTITY | surrogate key for the physical exam item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`physicalExamYear` | smallint | NOT NULL | year when the physical exam item was entered |  | T
`physicalExamTime24` | time(0) | NOT NULL | time in 24 hour format of when the physical exam event occurred e.g.: "12:45", "15:30", "3:45" |  | T
`physicalExamTime` | varchar(20) | NOT NULL | time frame when the physical exam item was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`physicalExamOffset` | int | NOT NULL | number of minutes from unit admit time that the physical exam item was entered |  | C
`physicalExamPath` | varchar(255) | NOT NULL | the root path of the physical exam item e.g.: notes/Progress Notes/Physical Exam/Physical Exam/Constitutional/Vital Sign and Physiological Data/Resp Rate/Resp Current, notes/Progress Notes/Physical Exam/Physical Exam/Neurologic/GCS/Verbal Score/5, etc. |  | S
`physicalExamValue` | varchar(100) | NULL | Structured picklist of available of physical exam items: O2 Sat% Highest, withdraws to pain, HR Current, etc. |  | S
`physicalExamText` | varchar(500) | NOT NULL | The string builder value of the physical exam item e.g.: manual entry, 85, no wheezing, etc. |  | S

<!-- # Detailed description

* To follow. -->
