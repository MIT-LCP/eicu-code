+++
date = "2015-09-01T19:34:46-04:00"
title = "vitalPeriodic"
linktitle = "vitalPeriodic"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# vitalPeriodic

**Purpose:**

"Periodic" data refers to data which is consistently interfaced from bedside vital signs monitors into eCareManager. Data are generally interfaced as 1 minute averages, and archived into the vitalPeriodic table as 5 minute median values.

The following vital signs are referred to as periodic vital signs as they are captured continuously by the system. (Temperature will be captured this way only if interfaced by a rectal or intravascular probe, for example):

- Temperature
- Heart rate
- SVO2
- Respiratory rate
- ICP (intracranial pressure)
- End Tidal CO2
- CPP (cerebral perfusion pressure)
- Mean Invasive blood pressure
- Pulmonary artery pressure
- O2 saturation by pulse oximeter
- CVP (central venous pressure)
- Invasive blood pressure (systolic and diastolic)

**Links to:**

- PATIENT on `patientUnitStayID`

# Important considerations

vitalPeriodic data represents the 5 minute median values from the bedside vital signs monitors, and is therefore unvalidated data. Unvalidated implies that the data has not been checked and verified by a bedside care provider, i.e. the measurements may be noisy and not reflect true patient state.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`vitalPeriodicID` | int | IDENTITY | surrogate key for periodic value | PK | C
`observationOffset` | int | NOT NULL | number of minutes from unit admit time that the periodic value was entered |  | C
`temperature` | decimal(11,4) | NULL | patient's temperature value in celsius e.g.: 36.1000, 37.8000, 35.5000, etc. |  | S
`saO2` | int | NULL | patient's saO2 value e.g.: 99, 94, 98, etc. |  | S
`heartRate` | int | NULL | patient's heart rate value e.g.: 102, 104, 70, etc. |  | S
`respiration` | int | NULL | patient's respiration value e.g.: 25, 20, 17, etc. |  | S
`cvp` | int | NULL | patient's cvp value e.g.: 359, 272, 293, etc. |  | S
`etCo2` | int | NULL | patient's etCo2 value e.g.: 31, 29, 35, etc. |  | S
`systemicSystolic` | int | NULL | patient's systolic value e.g.: 120, 103, 106, etc. |  | S
`systemicDiastolic` | int | NULL | patient's diastolic value e.g.: 73, 65, 63, etc. |  | S
`systemicMean` | int | NULL | patient's mean pressure e.g.: 89, 75, 78, etc. |  | S
`paSystolic` | int | NULL | patient's paSystolic e.g.: 40, 43, 33, etc. |  | S
`paDiastolic` | int | NULL | patient's paDiastolic value e.g.: 26, 20, 21, etc. |  | S
`paMean` | int | NULL | patient's paMean value e.g.: 31, 33, 25, etc. |  | S
`st1` | real | NULL | patient's st1 value e.g.: -0.85, 0.2, -0.3, etc. |  | S
`st2` | real | NULL | patient's st2 value e.g.: -0.1, 0.8, -0.9, etc. |  | S
`st3` | real | NULL | patient's st3 value e.g.: 0.2, -0.4, -1.1, etc. |  | S
`ICP` | int | NULL | patient's ICP value e.g.: 106, 13, 46, etc. |  | S

<!-- # Detailed description

* To follow. -->
