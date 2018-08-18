+++
date = "2015-09-01T19:34:46-04:00"
title = "admissiondx"
linktitle = "admissiondx"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# admissiondx

**Purpose:** The `admissiondx` table contains the primary diagnosis for admission to the ICU per the APACHE scoring criteria. Entered in the patient note forms. After a fixed period from admission has passed, the table cannot be updated by the caregiver.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* Patients admission source (medical, surgical) drives the APACHE diagnosis.
* Present for the majority of patients.
* If a patient does not have an admissiondx entry, they should not have an APACHE score.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`admissionDxID` | int | IDENTITY | surrogate key for the admission diagnosis | PK | C
`admitDxEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the admission diagnosis was entered |   | C
`admitDxPath` | varchar(500) | NOT NULL | the admission diagnosis' item's full path e.g.: admission diagnosis |  |  All
`admitDxName` | varchar(255) | NULL | admission diagnosis' item's name e.g.: Angina, stable (asymp or stable pattern of symptoms w/meds) |   | S
`admitDxText` | varchar(255) | NULL | admission diagnosis amplifying value e.g.: 42, 50 |   | S

# Detailed description

The `admissionDx` table includes patient diagnosis date/time, the admit diagnosis path e.g.: admission diagnosis | All Diagnosis| Non-operative | Diagnosis | Cardiovascular | Angina, stable (asymp or stable pattern of symptoms w/meds), the diagnosis' item's name e.g.: Angina, stable (asymp or stable pattern of symptoms w/meds), and the diagnosis item value.

The APACHE Admission Diagnosis can be entered from within a Care Plan or in Notes (Admission, Readmission, Brief, or Comprehensive Progress Note) for the first 36 hours after ICU admission. The Admission Diagnosis entry is required for APACHE calculations.

The process involves determining whether the admission diagnosis is primarily medical or surgical. Admission from the operating room (OR) causes the systems and diagnoses for surgical diagnoses to be available for selection. Patients not admitted from an OR results in a display of the appropriate medical systems and diagnoses for selection. Surgical diagnosis must be characterized as elective or emergent.

The actual list of diagnoses consists of several hundred items determined by the original creators of the APACHE scoring and prediction tool. The “best” fit for an admission diagnosis based on specific rules is selected by clinicians trained on the APACHE methodology. Patients admitted for trauma should receive a trauma diagnosis. Sepsis diagnoses are part of non-operative cardiovascular diagnoses.

All patients admitted from the Operating room or Recovery room should have a surgical diagnosis, even though some surgical patients have a medical reason for admission to the ICU. When multiple medical problems exist, the acute illness or event that was most immediately life-threatening to the patient or that required the services of the ICU is the one that should be provided.
