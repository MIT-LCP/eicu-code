+++
date = "2015-09-01T19:34:46-04:00"
title = "autoAcuityOverride"
linktitle = "autoAcuityOverride"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# autoAcuityOverride

**This table is not currently available in the public dataset.**

**Purpose:** A general ranking of the acuity of a given patient. The eICU physician/nurse can override a given acuity measure and replace it with what they feel is more appropriate, for example they can overwrite a "high" acuity and replace it with a "medium" acuity.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- |  ----
`autoAcuityOverrideID` | int | IDENTITY | surrogate key for the auto acuity override item | PK | C
`patientHealthSystemStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`autoAcuityYear` | smallint | NOT NULL | year when the auto acuity over ride item was incurred |  | T
`autoAcuityTime24` | time(0) | NOT NULL | time in 24 hour format of when the auto acuity over ride item was incurred occurred e.g.: “12:45”, “15:30”, “3:45” |  | T
`autoAcuityTime` | varchar(20) | NOT NULL | time frame when the auto acuity over ride item was incurred: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`autoAcuityOffset` | int | NOT NULL | number of minutes from health system admit time that the autoAcuity item was incurred |  | C
`manualAcuity` | varchar(50) | NULL | manual acuity over ride item e.g. “High”, “Intermediate”, “Low”, “Unknown” or NULL |  | S

<!-- # Detailed description

* To follow. -->
