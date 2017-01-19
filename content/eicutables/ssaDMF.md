+++
date = "2015-09-01T19:34:46-04:00"
title = "ssaDMF"
linktitle = "ssaDMF"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# ssaDMF

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NULL | foreign key link to the patient table | FK | C
`ssaDMFID` | int | NOT NULL | surrogate key for the SSA Death Master File information | PK | C
`expirationYear` | smallint | NULL | Year when the patient expired |  | T
`expirationOffset` | int | NULL | number of minutes from unit admit time that the patient expired |  | C
`matchRule` | tinyint | NOT NULL | matching criteria rule used key e.g. "1", "0", "99", etc. |  | C
`fixedDOD` | bit | NOT NULL | date of death "fixed" to first day of the month for DOD with "00" as day of death e.g. "12/00/1938" fixed to "12/01/1938" |  | C

<!-- # Detailed description

* To follow. -->
