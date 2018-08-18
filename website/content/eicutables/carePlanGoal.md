+++
date = "2015-09-01T19:34:46-04:00"
title = "carePlanGoal"
linktitle = "carePlanGoal"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# carePlanGoal

**Purpose:** Completed primarily by hospital staff when eCareManager is used a primary documentation tool at the bedside. The Patient Care Goals section is used to record treatment goals for patients and updated as needed.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The Care Plan in eCareManager is used primarily as an intraprofessional communication tool. Variables related to care provider type and specialty, code status, prognosis, family/healthcare proxy, end-of-life discussions, and various therapies (sedation and analgesia therpaies, airway and ventilation status, and stress ulcer and deep vein thrombosis) can be documented on the Care Plan.

* If carePlanGoal data are present for a hospital, then this it is likely used to communicate goal setting tool between bedside providers and may be widely used at that particular hospital. This section is not completed often.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`cplGoalID` | int | IDENTITY | surrogate key for care plan goal | PK | C
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`cplGoalOffset` | int | NOT NULL | number of minutes from unit admit time that the care plan goal was entered |  | C
`cplGoalCategory` | varchar(255) | NULL | the picklist category the goal is associated with e.g.: Nutrition/Skin, Pulmonary, Cardiovascular, etc. |  | S
`cplGoalValue` | varchar(1000) | NULL | the string builder value of the goal e.g.: Vital signs within normal parameters, Orient patient to unit, Pulse oximetry within ordered parameters, etc. |  | S
`cplGoalStatus` | varchar(255) | NULL | the picklist status of the goal: Active, Resolved or Deferred |  | S
`activeUponDischarge` | varchar(10) | NULL | denotes whether the goal was active upon discharge: True or False |  | S

<!-- # Detailed description

* To follow.
 -->
