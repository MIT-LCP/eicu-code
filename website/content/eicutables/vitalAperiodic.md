+++
date = "2015-09-01T19:34:46-04:00"
title = "vitalAperiodic"
linktitle = "vitalAperiodic"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# vitalAperiodic

**Purpose:**
The vitalAperiodic table provides invasive vital sign data which is interfaced into eCareManager at irregular intervals.

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

The following vital signs are referred to as aperiodic vital signs, as they are not captured by the system on a regular basis (non-invasive BP can be triggered at an unpredictable variety of time intervals):

- Cardiac output
- Cardiac Index
- Pulmonary artery occlusion pressure (“wedge pressure” - PAOP)
- SVR / SVRI
- PVR / PVRI
- Non-invasive blood pressure


# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`vitalAperiodicID` | int | IDENTITY | surrogate key for the aperiodic value | PK | C
`observationOffset` | int | NOT NULL | number of minutes from unit admit time that the aperiodic value was entered |  | C
`nonInvasiveSystolic` | real | NULL | patient's non invasive systolic value e.g.: 78, 102, 87, etc. |  | S
`nonInvasiveDiastolic` | real | NULL | patient's non invasive diastolic value e.g.: 40, 59, 49, etc. |  | S
`nonInvasiveMean` | real | NULL | patient's non invasive mean value e.g.: 56, 76, 65, etc. |  | S
`paop` | real | NULL | patient's paop value e.g.: 20, 18, 15, etc. |  | S
`cardiacOutput` | real | NULL | patient cardiac output value e.g.: 4.71, 5.81, 5.63, etc. |  | S
`cardiacInput` | real | NULL | patient cardiac input value e.g.: |  | S
`svr` | real | NULL | patient svr value e.g.: |  | S
`svri` | real | NULL | patient svri value e.g.: |  | S
`pvr` | real | NULL | patient pvr value e.g.: |  | S
`pvri` | real | NULL | patient pvri value e.g.: |  | S

<!-- # Detailed description

* To follow. -->
