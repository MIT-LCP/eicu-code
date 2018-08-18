+++
date = "2015-09-01T19:34:46-04:00"
title = "nurseCare"
linktitle = "nurseCare"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# nurseCare

**Purpose:**
The Nursing Care Flowsheet provides the capability for nurses to document patient care information for the following categories:

- Nutrition
- Activity
- Hygiene/ADLs
- Respiratory
- Incision/Wound Care
- Line Care
- Drain/Tube Care
- Safety
- Alarms On
- Isolation Precautions
- Equipment
- Restraints
- Other Nursing Care Data

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`cellLabel` | varchar(255) | NOT NULL | label of the selected nursing care entry |  | S
`nurseCareID` | int | IDENTITY | surrogate key for the nursing care | PK | C
`nurseCareOffset` | int | NOT NULL | number of minutes from unit admit time that nursing care column |   | C
`nurseCareEntryOffset` | int | NOT NULL | number of minutes from unit admit time that nursing care column was entered |   | C
`cellAttributePath` | varchar(255) | NOT NULL | the full path string of the nursing care entry selected in eCareManager, the sections of the assessment will be separated by a &#124; symbol e.g.: flowsheet &#124; Flowsheet Cell Labels &#124; Nursing Assessment &#124; Scores &#124; Braden Scale &#124; Activity |   | S
`cellAttribute` | varchar(255) | NOT NULL | attribute for the nursing care entry selected in eCareManager |   | S
`cellAttributeValue` | varchar(7500) | NULL | value for the nursing care attribute selected for the nursing care entry in eCareManager |   | S

<!-- # Detailed description

* To follow. -->
