+++
date = "2015-09-01T19:34:46-04:00"
title = "intakeOutput"
linktitle = "intakeOutput"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# intakeOutput

**Purpose:** Intake and output recorded for patients. Entered from the nursing flowsheet (either manually or interfaced into the hospital system).

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* Absence of measurement does not indicate absence of intake or output.
* The `intakeTotal`, `outputTotal`, `diaslysisTotal`, and `netTotal` are *cumulative* measurements up to the current offset. The value measured for the given row is stored in `cellValueNumeric` and `cellValueText`
* When several entries are recorded at the same time for a patient, the values in intaketotal, outputtotal, dialysistotal and nettotal are duplicated!
* outputtotal does not only corrspond to urine output, but also output from drains, blood loss, etc.
* cellvaluenumeric is almost always POSITIVE, but not always: in v2.0, 1,476 of the 12,030,289 rows are negative and 460,221 are 0. dialysistotal is NEGATIVE for fluid removal and POSITIVE when fluid is administered to the patient via the dialysis machine.
* In v2.0, 9,619 rows repeat another row in every column except `intakeOutputID`. The table does not distinguish an entry saved twice from two equal entries.
* `intakeOutputEntryOffset` (when the value was entered) equals `intakeOutputOffset` (when it was observed) in 54.1% of rows. For 10% of rows the value was entered 147 minutes or more after the time it was observed, and 3.3% of rows were entered before it. For a model that may only use data available at a given time, use the entry offset.
* With each new entry in intakeoutput, the current daily net total is reported. If several entries happen at the same time, the daily net total will be repeated multiple times. So if you are trying to compute the daily fluid balance, you need to first isolate unique instances of daily net total (`select distinct patientunitstayid, intakeoutputoffset, nettotal`) and then sum these unique values. Failure to do so will result in a grossly overestimated daily fluid balance.

# Table columns

Name | Datatype | Null Option | Comment | Key
---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK
`intakeOutputID` | int | IDENTITY | surrogate key for the intake output data | PK
`intakeOutputOffset` | int | NOT NULL | number of minutes from unit admit time that the I and O value was observed |
`intakeTotal` | decimal(12,4) | NULL | total intake value up to the current offset, e.g.: 150.0000, 326.0000, 142.0000, etc. |
`outputTotal` | decimal(12,4) | NULL | total output value up to the current offset, e.g.: 230.0000, 350.0000, 150.0000, etc. |
`dialysisTotal` | decimal(12,4) | NULL | total dialysis value up to the current offset, e.g.: -96.0000, -2300.0000, 0.0000, etc. |
`netTotal` | decimal(12,4) | NULL | calculated net value of: intakeTotal – outputTotal + dialysisTotal |
`intakeOutputEntryOffset` | int | NOT NULL | number of minutes from unit admit time that the I and O value was entered |
`cellPath` | varchar(500) | NOT NULL | the root path of info from the label in I and O e.g.: flowsheet|Flowsheet Cell Labels|I&O|Intake (ml)|Blood Products (ml)|pRBCs, flowsheet|Flowsheet Cell Labels|I&O|Intake (ml)|Nutrition (ml)|Parenteral TNA, flowsheet|Flowsheet Cell Labels|I&O|Output (ml)|CSF, etc. |  
`cellLabel` | varchar(255) | NOT NULL | The predefined row label text from I and O e.g.: Enteral flush/meds panda, D5 0.45 NS w/20 mEq KCL 1000 ml, Continuous infusion meds, etc. |  
`cellValueNumeric` | decimal(12,4) | NOT NULL | the value of the current I and O row e.g.: 100.0000, 60.9000, 10.0000, etc. |
`cellValueText` | varchar(255) | NOT NULL | text conversion of the numeric value of the I and O row e.g.: 100, 360, 50 |

<!-- # Detailed description

* To follow.
 -->
