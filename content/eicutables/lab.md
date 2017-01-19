+++
date = "2015-09-01T19:34:46-04:00"
title = "lab"
linktitle = "lab"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# lab

**Purpose:** Laboratory tests that have have been mapped to a standard set of measurements. Unmapped measurements are recorded in the customLab table.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`labID` | int | IDENTITY | surrogate ID for the labs data | PK | C
`labResultYear` | smallint | NOT NULL | year when the lab value was entered |  | T
`labResultTime24` | time(0) | NOT NULL | time in 24 hour format of when the lab was drawn e.g.: "12:45", "15:30", "3:45" |  | T
`labResultTime` | varchar(20) | NOT NULL | time frame when the lab value was drawn: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`labResultOffset` | int | NOT NULL | number of minutes from unit admit time that the lab value was drawn |  | C
`labTypeID` | tinyint | NOT NULL | the type of lab that is represented in the values, 1 for chemistry, 2 for drug level, 3 for hemo, 4 for misc, 5 for non-mapped, 6 for sensitive, 7 for ABG lab |  | S
`labName` | varchar(255) | NULL | the picklist name of the lab e.g.: CPK, troponin - I, RBC, HCO3, Total CO2, etc. This is hospital specific. |  | S
`labResult` | decimal(11,4) | NULL | the numeric value of the lab e.g.: 7.3230,, 58.0000, 24.8000 |  | S
`labResultText` | varchar(255) | NULL | the text of the lab value e.g.: 7.257, 58.0 24.8 |  | S
`labMeasureNameSystem` | varchar(255) | NULL | the measurement name of the lab e.g.: mm Hg, mmol/L, mEq/L, etc. |  | S
`labMeasureNameInterface` | varchar(255) | NULL | the measurement name of the lab from interfaces e.g.: mm Hg, mmol/L, mEq/L, etc. |  | S
`labResultRevisedYear` | smallint | NOT NULL | year when the revised lab value was entered |  | T
`labResultRevisedTime24` | time(0) | NOT NULL | time in 24 hour format of when the lab was revised e.g.: "12:45", "15:30", "3:45" |  | T
`labResultRevisedTime` | varchar(20) | NOT NULL | time frame when the revised lab value was entered |  | T
`labResultRevisedOffset` | int | NOT NULL | number of minutes from unit admit time that the revised lab value was entered |  | C

<!-- # Detailed description

* To follow.
 -->