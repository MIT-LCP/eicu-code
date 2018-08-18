+++
date = "2015-09-01T19:34:46-04:00"
title = "carePlanGeneral"
linktitle = "carePlanGeneral"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# carePlanGeneral

**Purpose:** Documentation relating to care planning, continuously updated over a patient stay.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The Care Plan in eCareManager is used primarily as an intraprofessional communication tool. Variables related to care provider type and specialty, code status, prognosis, family/healthcare proxy, end-of-life discussions, and various therapies (sedation and analgesia therpaies, airway and ventilation status, and stress ulcer and deep vein thrombosis) can be documented on the Care Plan.

* The Care Plan primarily consists of structured picklist items.

* When determining whether a patient recieved a particular therapy other fields within the database are generally used first, and if missing then variables documented on the Care Plan will be used. For example if the fields in the respiratory flowsheet are blank but mechanical ventilation is chosen as an Active Therapy on the Care Plan then the variable of mechanical ventialtion is determined to be true.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table| FK | C
`activeUponDischarge` | varchar(10) | NOT NULL | denotes if the item was active upon discharge: True or False |  | S
`cplGeneralID` | int | IDENTITY | surrogate key for care plan general items | PK | C
`cplItemOffset` | int | NOT NULL | number of minutes from unit admit time that the care plan general item was entered |  | C
`cplGroup` | varchar(255) | NOT NULL | the picklist group type in care plan where the value was selected / entered e.g.: Activity, Critical Care Discharge/Transfer Planning, Daily Goals/Safety Risks/Discharge Requirements, Safety/Restraints, Acuity, etc. |  | S
`cplItemValue` | varchar(1024) | NULL | the picklist value selected / entered into the care plan group e.g.: Very low mortality risk, Non-invasive ventilation, Parenteral - bolus prn |  | S

# Detailed description

The Care Plan provides a unique multi-professional structure that includes features of a daily rounding sheet (daily goals/safety risks) and capabilities to address best practices in a formal, structured manner. Data from the Care Plan help clinicians monitor compliance with established best practices.

The Care Plan is used to enter current treatment information, supportive therapies such as nutritional services, and other clinical and social information including prognosis, code status and family issues. When a patient is transferred, readmitted or changed from stepdown/other, Care Plan data are automatically carried forward from the previous unit stay if within 24 hours.

Patient Information in the care plan includes the following:
1.	Admit Date
2.	Acuity: The patient’s acuity status can vary from High (red), Intermediate (yellow), Low (green), or Unknown (gray). After changing the acuity status, click Refresh to synchronize the acuity status throughout the patient chart.
3.	Admission Diagnosis: Derived from the APACHE Admission Diagnosis (Admission Notes and Care Plan). See APACHEAdmissionDiagnosis for more information.
4.	Admission Height
5.	Admission Weight
6.	Code Status:  Includes Full Therapy, Do not Resuscitate, and No Augmentation of Care.
7.	Care Limitation
8.	Patient-Family: Includes Baseline Status, Family/Health Care Proxy/Contact Info, End of Life Discussion, Psychosocial Status, and Critical Care Discharge/Transfer Planning and whether the Care Plan Reviewed with Patient/Family
