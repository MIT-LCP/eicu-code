+++
date = "2015-09-01T19:34:46-04:00"
title = "intakeOutput"
linktitle = "intakeOutput"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# intakeOutput

**Purpose:** Intake and output recorded for patients. Entered from the nursing flowsheet (either manually or interfaced into the hospital system).

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* Absence of measurement does not indicate absence of intake or output.
* When several entries are recorded at the same time for a patient, the values in intaketotal, outputtotal, dialysistotal and nettotal are duplicated!
* outputtotal does not only corrspond to urine output, but also output from drains, blood loss, etc.
* cellvaluenumeric is always POSITIVE, while dialysistotal is NEGATIVE for fluid removal and POSITIVE when fluid is administered to the patient via the dialysis machine.
* With each new entry in intakeoutput, the current daily net total is reported. If several entries happen at the same time, the daily net total will be repeated multiple times. So if you are trying to compute the daily fluid balance, you need to first isolate unique instances of daily net total (`select distinct patientunitstayid, intakeoutputoffset, nettotal`) and then sum these unique values. Failure to do so will result in a grossly overestimated daily fluid balance.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`intakeOutputID` | int | IDENTITY | surrogate key for the intake output data | PK | C
`intakeOutputYear` | smallint | NOT NULL | the observation year for the I and O value |  | T
`intakeOutputTime24` | time(0) | NOT NULL | time in 24 hour format of the intake output column e.g.: "12:45", "15:30", "3:45" |  | T
`intakeOutputTime` | varchar(20) | NOT NULL | observation time frame for the I and O value: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`intakeOutputOffset` | int | NOT NULL | number of minutes from unit admit time that the I and O value was observed |  | C
`intakeTotal` | decimal(12,4) | NULL | total intake value e.g.: 150.0000, 326.0000, 142.0000, etc. |  | S
`outputTotal` | decimal(12,4) | NULL | total output value e.g.: 230.0000, 350.0000, 150.0000, etc. |  | S
`dialysisTotal` | decimal(12,4) | NULL | total dialysis value e.g.: -96.0000, -2300.0000, 0.0000, etc. |  | S
`netTotal` | decimal(12,4) | NULL | calculated net value of: intakeTotal – outputTotal + dialysisTotal |  | S
`intakeOutputEntryYear` | smallint | NOT NULL | year when the I and O value was entered |  | T
`intakeOutputEntryTime24` | time(0) | NOT NULL | time in 24 hour format of when the intake output column was entered e.g.: "12:45", "15:30", "3:45" |  | T
`intakeOutputEntryTime` | varchar(20) | NOT NULL | time frame when the I and O value was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`intakeOutputEntryOffset` | int | NOT NULL | number of minutes from unit admit time that the I and O value was entered |  | C
`cellPath` | varchar(500) | NOT NULL | the root path of info from the label in I and O e.g.: flowsheet|Flowsheet Cell Labels|I&O|Intake (ml)|Blood Products (ml)|pRBCs, flowsheet|Flowsheet Cell Labels|I&O|Intake (ml)|Nutrition (ml)|Parenteral TNA, flowsheet|Flowsheet Cell Labels|I&O|Output (ml)|CSF, etc. |  | S
`cellLabel` | varchar(255) | NOT NULL | The predefined row label text from I and O e.g.: Enteral flush/meds panda, D5 0.45 NS w/20 mEq KCL 1000 ml, Continuous infusion meds, etc. |  | S
`cellValueNumeric` | decimal(12,4) | NOT NULL | the value of the I and O row e.g.: 100.0000, 60.9000, 10.0000, etc. |  | S
`cellValueText` | varchar(255) | NOT NULL | text conversion of the numeric value of the I and O row e.g.: 100, 360, 50 |  | S

<!-- # Detailed description

* To follow.
 -->