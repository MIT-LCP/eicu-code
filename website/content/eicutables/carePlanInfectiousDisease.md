+++
date = "2015-09-01T19:34:46-04:00"
title = "carePlanInfectiousDisease"
linktitle = "carePlanInfectiousDisease"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# carePlanInfectiousDisease

**Purpose:** High level record of infectious diseases added as part of the care plan form.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The Care Plan in eCareManager is used primarily as an intraprofessional communication tool. Variables related to care provider type and specialty, code status, prognosis, family/healthcare proxy, end-of-life discussions, and various therapies (sedation and analgesia therpaies, airway and ventilation status, and stress ulcer and deep vein thrombosis) can be documented on the Care Plan.

* If infectious disease data are present for a hospital, then this it is likely used to communicate site or source of infectious process and infection control precautions between bedside providers and may be widely used at that particular hospital. This section is rarely completed.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table| FK | C
`activeUponDischarge` | varchar(10) | NOT NULL | denotes whether the infectious disease was active upon discharge: True or False |  | S
`cplInfectID` | int | IDENTITY | surrogate key for care plan infectious diseases | PK | C
`cplInfectDiseaseOffset` | int | NOT NULL | number of minutes from unit admit time that the infectious disease was entered |  | C
`infectDiseaseSite` | varchar(255) | NULL | The picklist site of the infectious disease e.g.: Intra-abdominal, Blood, Catheter related bloodstream, etc. |  | S
`infectDiseaseAssessment` | varchar(255) | NULL | the picklist assessment of the infectious disease: Definite infection, Probable infection or Possible infection |  | S
`responseToTherapy` | varchar(255) | NULL | the picklist response to the therapy: Improving, No change, Worsening, Resolved, or BLANK |  | S
`treatment` | varchar(255) | NULL | the picklist treatment for the infectious disease: Prophylactic, Empiric, Directed, or BLANK |  | S

<!-- # Detailed description

* To follow.
 -->
