+++
date = "2015-09-01T19:34:46-04:00"
title = "allergy"
linktitle = "allergy"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# allergy

**Purpose:** The allergy tables contains details of patient allergies. The data is entered in the patient note forms.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The absence of observation does not indicate an absence of allergy.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`allergyID` | int | IDENTITY | surrogate key for the allergy | PK | C
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`allergyOffset` | int | NOT NULL | number of minutes from unit admit time that the allergy was detected |   | C
`allergyEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the allergy was entered |   | C
`allergyNoteType` | varchar(255) | NOT NULL | unique note picklist types e.g.: Comprehensive Progress Admission Intubation |   | S
`specialtyType` | varchar(255) | NOT NULL | physician specialty picklist types e.g.: anesthesiology gastroenterology oncology |   | S
`userType` | varchar(255) | NULL | eCareManager user picklist types e.g.: eICU Physician Nurse Attending Physician |   | S
`rxIncluded` | varchar(5) | NOT NULL | Does the Note have associated Rx data: True or False |   | S
`writtenIneICU` | varchar(5) | NOT NULL | Was the Note written in the eICU: True or False |   | S
`drugName` | varchar(255) | NULL | name of the selected admission drug e.g.: POTASSIUM CHLORIDE/D5NS METAXALONE PRAVACHOL |   | S
`allergyType` | varchar(255) | NOT NULL | type of allergy: Drug or Non Drug |   | S
`allergyName` | varchar(255) | NOT NULL | allergy picklist name e.g.: penicillins pollen shellfish |   | S
`drugHiclSeqno` | int | NULL | HICL sequence number for the drug if drug allergy e.g.: 2734, 33199, 20492 |   | S

# Detailed description

The allergy table includes patient data entry date/time, note type, specialty type, user type, drug information, etc.
Allergy data for the patient can be entered on notes that contain a section for allergies.  All allergies (drug and non-drug) can be entered along with necessary pre-admission medications. If a patient reports an allergy to a drug class, a selection from that class (e.g., Penicillin G) may be chosen. The exact nature of the allergy (e.g., allergic to “all penicillins”) may have halso been described with text in the Patient Description field but this field has been excluded to reduce risk of sharing PHI.

Allergy entry is optional. The Daily Progress Note is the most efficient way to enter allergies. Drug allergies entered in other Notes will display here; any allergies listed here will display in subsequent Notes and on a Patient Profile.
