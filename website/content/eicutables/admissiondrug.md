+++
date = "2015-09-01T19:34:46-04:00"
title = "admissiondrug"
linktitle = "admissiondrug"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# admissiondrug

**Purpose:** admissionDrug contains details of medications that a patient was taking prior to admission to the ICU. This table includes admission drug information for a patient such as the drug name, dosage, timeframe during which the drug was administered, the user type and specialty of the clinician entering the data, and the note type where the information was entered.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* Extremely infrequently used.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`admissionDrugID` | int | IDENTITY | surrogate key for the admission drug | PK | C
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`drugOffset` | int | NOT NULL | number of minutes from unit admit time that the admission drug was administered |  | C
`drugEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the admission drug was entered |  | C
`drugNoteType` | varchar(255) | NOT NULL | unique note picklist types e.g.: Comprehensive Progress Admission Intubation |  | S
`specialtyType` | varchar(255) | NOT NULL | physician specialty picklist types e.g.: anesthesiology gastroenterology oncology |  | S
`userType` | varchar(255) | NOT NULL | eCareManager user picklist types e.g.: eICU Physician Nurse Attending Physician |  | S
`rxIncluded` | varchar(5) | NOT NULL | Does the Note have associated Rx data: True or False |  | S
`writtenIneICU` | varchar(5) | NOT NULL | Was the Note written in the eICU: True or False |  | S
`drugName` | varchar(255) | NOT NULL | name of the selected admission drug e.g.: POTASSIUM CHLORIDE/D5NS METAXALONE PRAVACHOL |  | S
`drugDosage` | decimal(11,4) | NULL | dosage of the admission drug e.g.: 20.0000 400.000 |  | S
`drugUnit` | varchar(1000) | NULL | picklist units of the admission drug e.g.: mg mg/kg patch |  | S
`drugAdmitFrequency` | varchar(1000) | NULL | picklist frequency with which the admission drug is administred e.g.: PRN twice a day at bedtime |  | S
`drugHiclSeqno` | int | NULL | HICL sequence number for the drug e.g.: 2734 33199 20492 |  | S

<!-- # Detailed description

* To follow. -->
