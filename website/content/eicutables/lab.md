+++
date = "2015-09-01T19:34:46-04:00"
title = "lab"
linktitle = "lab"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# lab

**Purpose:** Laboratory tests that have have been mapped to a standard set of measurements. Unmapped measurements are recorded in the customLab table.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

It is possible some rarely obtained lab measurements are not interfaced into the system and therefore will not be available in the database. Absence of a rare lab measurement, such as serum lidocaine concentrations, would not indicate the lab was not drawn. However, absence of a platelet count would indicate the value was not obtained.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`labID` | int | IDENTITY | surrogate ID for the labs data | PK | C
`labResultOffset` | int | NOT NULL | number of minutes from unit admit time that the lab value was drawn |  | C
`labTypeID` | tinyint | NOT NULL | the type of lab that is represented in the values, 1 for chemistry, 2 for drug level, 3 for hemo, 4 for misc, 5 for non-mapped, 6 for sensitive, 7 for ABG lab |  | S
`labName` | varchar(255) | NULL | the picklist name of the lab e.g.: CPK, troponin - I, RBC, HCO3, Total CO2, etc. This is hospital specific. |  | S
`labResult` | decimal(11,4) | NULL | the numeric value of the lab e.g.: 7.3230,, 58.0000, 24.8000 |  | S
`labResultText` | varchar(255) | NULL | the text of the lab value e.g.: 7.257, 58.0 24.8 |  | S
`labMeasureNameSystem` | varchar(255) | NULL | the measurement name of the lab e.g.: mm Hg, mmol/L, mEq/L, etc. |  | S
`labMeasureNameInterface` | varchar(255) | NULL | the measurement name of the lab from interfaces e.g.: mm Hg, mmol/L, mEq/L, etc. |  | S
`labResultRevisedOffset` | int | NOT NULL | number of minutes from unit admit time that the revised lab value was entered |  | C

<!-- # Detailed description

* To follow.
 -->
