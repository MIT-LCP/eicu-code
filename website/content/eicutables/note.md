+++
date = "2015-09-01T19:34:46-04:00"
title = "note"
linktitle = "note"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# note

**Purpose:** There are several types of notes which can be entered in the system. The detailed description provides a list of the possible Note types and their intended use. Notes are generally entered by the physician or physician extender primarily responsible for the documentation of the patient’s unit care.


**Links to:**

* PATIENT on `patientUnitStayID`

 # Important considerations

* The majority of data entered in notes is done in a structured format and available in the database. Any notes or section of notes which are primarily narrative text format have been removed and are not available for research at this time in order to minimize risk of including PHI.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`noteID` | int | IDENTITY | surrogate key for the note item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`noteOffset` | int | NOT NULL | number of minutes from unit admit time for the note item, derived from the note’s date of service |  | C
`noteEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the note item was entered |  | C
`noteType` | varchar(50) | NULL | type of note e.g.: Admission, Comprehensive Progress, Brief Progress, etc. |  | S
`notePath` | varchar(255) | NOT NULL | the root path of the note item e.g.: notes/Progress Notes/Assessment and Plan/Organ System dx(s) and rx(s)/Gastrointestinal/Dx/Dx, notes/Progress Notes/Assessment and Plan/Organ System dx(s) and rx(s)/Gastrointestinal/Dx/Dx, etc. |  | S
`noteValue` | varchar(150) | NULL | the picklist value name of the note item e.g.: HR Highest, Dx, Verified procedure, etc. |  | S
`noteText` | varchar(255) | NULL | the picklist value text of the note item e.g.: ABDOMINAL PAIN / TENDERNESS, nausea-with vomiting, +1358, respiratory arrest, etc. |  | S

# Detailed description

* The following are possible Note types and their intended use.
•         Admission Note: The Admission Note reflects the patient’s condition upon initial arrival to the unit. It records findings of the patient assessment, conclusions or impressions drawn from the medical history and physical examination, diagnosis or diagnostic impressions, reasons for admission or treatment, goals of the treatment, and treatment plans. Problem groupks are primary, major, or other, while organ systems include neurologic, cardiovascular, pulmonary, etc.
•         Readmission Note: The Readmission Note reflects the patient’s condition upon subsequent arrivals to the unit (other than the initial arrival) within the same hospitalization. The readmission note is used to record findings of the patient assessment, conclusions or impressions drawn from the medical history and physical examination, diagnosis or diagnostic impressions, reasons for admission or treatment, goals of treatment and treatment plans.
•         Comprehensive Progress Note: The Comprehensive Progress Note documents the daily course and results of patient care and provides the physician with a comprehensive means of documenting changes in patient status, updates, and interventions. It reflects the patient’s response to treatment, goals of treatment, and treatment plans.
This information potentially includes patient description, HPI/Events of Note, preadmission medications, allergies, past history, physical exam, diagnosis/treatment pick list choices, comments for systems or problems, global issues, and plan items.
•         Daily Progress Note: The Daily Progress Note provides physicians and other clinicians with a user-friendly means of documenting daily patient status. Unlike the Admission, Consultant, and Comprehensive Progress Notes, this Note’s data entry is entirely on one scrollable page. The APACHE Admission Diagnosis, past history, and Active Dx/Rx selections cannot be entered via this note.
•         Brief Progress Note: The Brief Progress Note documents specific observations, events of note, and clinical management issues of the patient that are needed in addition to a Comprehensive Progress note. It also is intended as the primary note tool for THC use. The brief progress note is generally employed to document THC issues and interventions. Interventions are selected from a structured multi-selection list and are broken down into Major, Intermediate and Minor categories on the basis of clinical acuity. Each category also includes an Other selection.
•         Initial Consultation/Other Note
The Consultation/Other Note accommodates note writing by physicians and clinicians other than the primary or managing physician. Use this note to document specific observations, events, conclusions or impressions drawn from the Physical Examination and diagnosis or diagnostic impressions. You can include allergies/preadmission medications, review of systems, family and social history and other note areas as required to document a complete initial consultation.
•         Follow-up Consultation/Other Note
The Follow-up Consultation Note is used by a consultant physician to document ongoing consultation activity or by any other clinician (including non-physicians) who is not functioning as the primary physician. This note is a parallel note and does not update fields in other areas such as Patient Profile. This note is intended to supplement primary daily care documentation.
•         Stroke Consultation Note
This Note allows stroke consultants to document diagnosis and treatment recommendations for the stroke patient’s medical record.
•         Procedure Note
The Procedure Note allows users to document and track procedures that were performed on a patient. The following Procedure Notes are available:
•         Catheters: Arterial Catheter Insertion, Central Venous Catheter Insertion, Dialysis Catheter Insertion, Pulmonary Artery Catheter Insertion, Catheter Change Over a Wire, and Catheter Removal
•         Specialized: Intubation, Extubation, Bronchoscopy, Thoracentesis, Cardioversion, CPR, Lumbar Puncture, and Paracentesis
•         Generic
Procedure notes include the following fields and sections:
•         User Type field
•         Date of Service field
•         Time-Out Process section with a Date of Time-Out Process field, Time-Out Process Check List, and Comments field with optional template(s).
•         Technical Description
•         Evaluation
•         Miscellaneous Information
