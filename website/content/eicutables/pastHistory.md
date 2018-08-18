+++
date = "2015-09-01T19:34:46-04:00"
title = "pastHistory"
linktitle = "pastHistory"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# pastHistory

**Purpose:**
Provides information related a patient's relevant past medical history.

**Links to:**

* PATIENT on `patientUnitStayID`

Important considerations

Providing detailed Past History is not common, but items such as AIDS, Cirrhosis of the Liver, Hepatic Failure, Chronic Renal Failure, Transplant, and Pre-existing Cancers / immunosuppression are more reliable because of their importance in severity outcome scoring.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`pastHistoryID` | int | IDENTITY | surrogate key for the past history item | PK | C
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`pastHistoryOffset` | int | NOT NULL | number of minutes from unit admit time for the past history item |  | C
`pastHistoryEnteredOffset` | int | NOT NULL | number of minutes from unit admit time that the past history item was entered |  | C
`pastHistoryNoteType` | varchar(20) | NULL | note type for the past history item e.g.: Admission, Initial Consultation/Other, Re-Admission, etc. |  | S
`pastHistoryPath` | varchar(255) | NOT NULL | the root path of the past history item e.g.: notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (A)/Cancer Therapy/Chemotherapy/Cis-platinum, etc. |  | S
`pastHistoryValue` | varchar(100) | NULL | Structured picklist of available past history items e.g.: Performed, hypercoagulable condition, COPD - no limitations, etc. |  | S
`pastHistoryValueText` | varchar(255) | NULL | the picklist value of the past history item e.g.: COPD - Moderate, CHF, Medication dependent, etc. |  | S

 Detailed description

Data include Past History date/time (as offset), note type, root path (e.g. notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (A)/Cancer Therapy/Chemotherapy/Cis-platinum, etc.), picklist values (e.g. Performed, Not Performed, Not Obtainable, No Health Problems, etc.) and text (e.g. COPD  - Moderate, CHF, Medication dependent).
Data entry fields are organized by the following organ systems:
•         Neurologic
•         Cardiovascular
•         Pulmonary
•         Gastrointestinal
•         Infectious Disease
•         Hematology/Oncology
•         Endocrine
•         Rheumatic
