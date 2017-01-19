+++
date = "2015-09-01T19:34:46-04:00"
title = "note"
linktitle = "note"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# note

**Purpose:** Short notes relating to patient care.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`noteID` | int | IDENTITY | surrogate key for the note item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`noteYear` | smallint | NOT NULL | note item year derived from note’s date of service |  | T
`noteTime24` | time(0) | NOT NULL | time in 24 hour format derived from the note’s date of service e.g.: "12:45", "15:30", "3:45" |  | T
`noteTime` | varchar(20) | NOT NULL | note item time frame derived from the note’s date of service: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`noteOffset` | int | NOT NULL | number of minutes from unit admit time for the note item, derived from the note’s date of service |  | C
`noteEnteredYear` | smallint | NOT NULL | year when the note item was entered |  | T
`noteEnteredTime24` | time(0) | NOT NULL | time in 24 hour format of when the note was entered e.g.: "12:45", "15:30", "3:45" |  | T
`noteEnteredTime` | varchar(20) | NOT NULL | time frame when the note item was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`noteEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the note item was entered |  | C
`noteType` | varchar(50) | NULL | type of note e.g.: Admission, Comprehensive Progress, Brief Progress, etc. |  | S
`notePath` | varchar(255) | NOT NULL | the root path of the note item e.g.: notes/Progress Notes/Assessment and Plan/Organ System dx(s) and rx(s)/Gastrointestinal/Dx/Dx, notes/Progress Notes/Assessment and Plan/Organ System dx(s) and rx(s)/Gastrointestinal/Dx/Dx, etc. |  | S
`noteValue` | varchar(150) | NULL | the picklist value name of the note item e.g.: HR Highest, Dx, Verified procedure, etc. |  | S
`noteText` | varchar(255) | NULL | the picklist value text of the note item e.g.: ABDOMINAL PAIN / TENDERNESS, nausea-with vomiting, +1358, respiratory arrest, etc. |  | S
<!-- 
# Detailed description

* To follow.
 -->