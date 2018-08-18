+++
date = "2015-09-01T19:34:46-04:00"
title = "microLab"
linktitle = "microLab"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# microLab

**Purpose:** Microbiology data.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The dataset is not well populated due to limited availability of microbiology interfaces.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`microLabID` | int | IDENTITY | surrogate key for the micro lab | PK | C
`cultureTakenOffset` | int | NOT NULL | number of minutes from unit admit time that the culture was taken |  | C
`cultureSite` | varchar(255) | NOT NULL | picklist site name from where the culture was taken e.g.: Wound, Drainage Fluid, Sputum, Expectorated, Nasopharynx, etc. |  | S
`organism` | varchar(255) | NOT NULL | picklist organism found e.g.: Staphylococcus aureus, Pseudomonas aeruginosa, no growth, etc. |  | S
`antibiotic` | varchar(255) | NULL | picklist antibiotic used e.g.: ceftazidime, aztreonam, other, etc. |  | S
`sensitivityLevel` | varchar(255) | NULL | picklist sensitivity level of antibiotic: Intermediate, Resistant, or Sensitive |  | S

<!-- # Detailed description

* To follow.
 -->
