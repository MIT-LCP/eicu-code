+++
date = "2015-09-01T19:34:46-04:00"
title = "microLab"
linktitle = "microLab"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Unreleased tables"
+++

# microLab

**This table is not currently available in the public dataset.**

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
`cultureTakenYear` | smallint | NOT NULL | year when the culture was taken |  | T
`cultureTakenTime24` | time(0) | NOT NULL | time in 24 hour format of when the culture was taken e.g.: "12:45", "15:30", "3:45" |  | T
`cultureTakenTime` | varchar(20) | NOT NULL | time frame when the culture was taken: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`cultureTakenOffset` | int | NOT NULL | number of minutes from unit admit time that the culture was taken |  | C
`cultureSite` | varchar(255) | NOT NULL | picklist site name from where the culture was taken e.g.: Wound, Drainage Fluid, Sputum, Expectorated, Nasopharynx, etc. |  | S
`organism` | varchar(255) | NOT NULL | picklist organism found e.g.: Staphylococcus aureus, Pseudomonas aeruginosa, no growth, etc. |  | S
`antibiotic` | varchar(255) | NULL | picklist antibiotic used e.g.: ceftazidime, aztreonam, other, etc. |  | S
`sensitivityLevel` | varchar(255) | NULL | picklist sensitivity level of antibiotic: Intermediate, Resistant, or Sensitive |  | S

<!-- # Detailed description

* To follow.
 -->
