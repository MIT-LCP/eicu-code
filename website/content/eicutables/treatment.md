+++
date = "2015-09-01T19:34:46-04:00"
title = "treatment"
linktitle = "treatment"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# treatment

**Purpose:**
The treatment table allows users to document, in a structured format, specific active treatments for the patient.


**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

The treatment table can only be populated directly into eCareManager as structured text. Absence of a treatment documented in this table should not be used as evidence a specific treatment was not administered.
Data includes patient treatment information including date/time, whether the treatment was active upon patient discharge, and the path of the treatment e.g.: neurologic | ICH/ cerebral infarct|thrombolytics | tenecteplase, cardiovascular | arrhythmias | antiarrhythmics | atropine, etc.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`treatmentID` | int | IDENTITY | surrogate key for the treatment | PK | C
`treatmentOffset` | int | NOT NULL | number of minutes from unit admit time that the treatment was entered |  | C
`treatmentString` | varchar(200) | NOT NULL | the path of the treatment e.g.: neurologic|ICH/ cerebral infarct|thrombolytics|tenecteplase, cardiovascular|arrhythmias|antiarrhythmics|atropine, etc. |  | S
`activeUponDischarge` | varchar(10) | NOT NULL | denotes whether the treatment was active upon discharge from the unit: True or False |  | S

<!-- # Detailed description

* To follow. -->
