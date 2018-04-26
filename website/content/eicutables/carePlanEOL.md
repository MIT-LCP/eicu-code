+++
date = "2015-09-01T19:34:46-04:00"
title = "carePlanEOL"
linktitle = "carePlanEOL"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# carePlanEOL

**Purpose:** Documentation relating to end of life care and discussions.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The Care Plan in eCareManager is used primarily as an intraprofessional communication tool. Variables related to care provider type and specialty, code status, prognosis, family/healthcare proxy, end-of-life discussions, and various therapies (sedation and analgesia therpaies, airway and ventilation status, and stress ulcer and deep vein thrombosis) can be documented on the Care Plan.

* The End-of-Life Discussion section of the Care Plan allows for the care provider who had the discussion, the date/time of the discussion as well as free text comments describing the discussion to be documented.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`cplEolID` | int | IDENTITY | surrogate key for care plan EOL discussion | PK | C
`cplEolSaveYear` | smallint | NOT NULL | year when the EOL discussion was entered |  | T
`cplEolSaveTime24` | time(0) | NOT NULL | time in 24 hour format of when the EOL discussion was saved e.g.: “12:45”, “15:30”, “3:45” |  | T
`cplEolSaveTime` | varchar(20) | NOT NULL | time frame when the EOL discussion was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`cplEolSaveOffset` | int | NOT NULL | number of minutes from unit admit time that the EOL discussion was entered |  | C
`cplEolDiscussionYear` | smallint | NULL | year when the EOL discussion occurred |  | T
`cplEolDiscussionTime24` | time(0) | NULL | time in 24 hour format of when the EOL discussion occurred e.g.: “12:45”, “15:30”, “3:45” |  | T
`cplEolDiscussionTime` | varchar(20) | NULL | time frame when the EOL discussion occurred: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`cplEolDiscussionOffset` | int | NULL | number of minutes from unit admit time that the EOL discussion occurred |  | C
`activeUponDischarge` | varchar(10) | NULL | denotes if the EOL discussion was active upon discharge: True or False |  | S

<!-- # Detailed description

* To follow. -->
