+++
date = "2015-09-01T19:34:46-04:00"
title = "diagnosis"
linktitle = "diagnosis"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# diagnosis

**Purpose:** Patient diagnosis recorded in the active diagnosis table. Sequence does indicate relative severity. diagnosisPriority is not required.

**Links to:**

* PATIENT on `patientUnitStayID`

# Brief summary

The diagnosis.md table contains a list of diagnoses that were documented for each patient in the Active Diagnosis/Treatment sections of the eCareManager medical record.The corresponding International Classification of Diseases (ICD) codes are also available in this table. This can be useful for determining if certain diseases were documented during the ICU stay and at what point in the patient's ICU stay these diagnoses were documented.

# Important considerations

The diagnosis.med table contains diagnoses that were documented in the ICU stay by clinical staff and may or may not be consistent with diagnoses that were coded and used for professional billing or hospital reimbursment purposes. This table does not include diagnoses that may have been documented prior to or after the ICU stay. This table does not indicate which diagnoses were resolved or ruled-out nor does it provide a diagnosis time frame when/if a diagnosis was removed.

* To follow.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`activeUponDischarge` | varchar(10) | NULL | denotes whether the diagnosis was active upon discharge from the unit: True or False |  | S
`diagnosisID` | int | IDENTITY | surrogate key for the diagnosis | PK | C
`diagnosisOffset` | int | NOT NULL | number of minutes from unit admit time that the diagnosis was entered |  | C
`diagnosisString` | varchar(200) | NOT NULL | the full pathstring of the diagnosis selected in eCareManager, the sections of the diagnosis will be separated by a | symbol e.g.: pulmonary|disorders of the airways|COPD, pulmonary|respiratory failure|hypoxemia, cardiovascular|vascular disorders|DVT, etc. |  | S
`ICD9Code` | varchar(100) | NOTNULL | ICD-9 code for the diagnosis e.g.: 518.81, 537.9, 491.20, etc. |  | S
`diagnosisPriority` | varchar(10) | NOT NULL | picklist value which denotes whether the diagnosis was marked as: Primary, Major, or Other |  | S

<!-- # Detailed description

* To follow. -->
