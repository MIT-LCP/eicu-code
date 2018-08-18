+++
date = "2015-09-01T19:34:46-04:00"
title = "carePlanCareProvider"
linktitle = "carePlanCareProvider"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# carePlanCareProvider

**Purpose:** Details relating to the managing or consulting physician, including specialty and intervention category.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`cplCareProviderID` | int | IDENTITY | surrogate key for care plan care provider | PK | C
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | Fk | C
`careProviderSaveOffset` | int | NOT NULL | number of minutes from unit admit time that the care provider was entered |  | C
`providerType` | varchar(255) | NULL | the picklist type of the care provider: Admitting Consultant Referring Primary |  | S
`specialty` | varchar(255) | NULL | the picklist specialty of the care provider e.g.: cardiology unknown obstetrics/gynecology |  | S
`interventionCategory` | varchar(255) | NULL | The eICU intervention category of the care provider: I, II, III, IV, Unknown, or NULL. This data denotes the level of oversight and intervention authorized for eICU clinicians for this patient by the managing physician (MP). Category I – Ermercency interaction only, Cat II – Emergency and Best Practices intervention only, Cat III – Full interaction, Cat IV - Full interaction (redundant). |  | S
`managingPhysician` | varchar(50) | NULL | picklist value which denotes whether this care provider is the managing physician: Managing or Consulting |  | S
`activeUponDischarge` | varchar(10) | NOT NULL | denotes if this physician was active upon patient discharge: True or False |  | S

# Detailed description

Care Plan Provider data includes type (e.g. Admitting, Consultant); specialty (e.g. cardiology), a managing physician indicator, and intervention category which denotes the level of oversight and intervention authorized for eICU clinicians for the patient by a managing physician.

Managing Physician designates the physician who has the overall charge of the patient’s care. In many instances, the managing physician will be the admitting physician. If a consultant, such as an intensivist, is managing care, the consultant should be designated as the managing physician. Only one managing physician at a time may be assigned to the patient. If a managing physician is not selected, the admitting physician will be employed as managing.

Consultants with specialties and intervention categories are provided. Intervention category denotes the level of oversight and intervention authorized for eICU clinicians for a patient by the managing physician.
