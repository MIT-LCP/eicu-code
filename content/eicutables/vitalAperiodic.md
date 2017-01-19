+++
date = "2015-09-01T19:34:46-04:00"
title = "vitalAperiodic"
linktitle = "vitalAperiodic"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# vitalAperiodic

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`vitalAperiodicID` | int | IDENTITY | surrogate key for the aperiodic value | PK | C
`observationYear` | smallint | NOT NULL | year when the aperiodic value was entered |  | T
`observationTime24` | time(0) | NOT NULL | time in 24 hour format of the vital sign obsesrvation date e.g.: "12:45", "15:30", "3:45" |  | T
`observationTime` | varchar(20) | NOT NULL | time frame when the aperiodic value was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
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
