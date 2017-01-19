+++
date = "2015-09-01T19:34:46-04:00"
title = "nurseCharting"
linktitle = "nurseCharting"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# nurseCharting

**Purpose:** Large table that contains information entered in a semi-structured form by the nurse.  The three columns `nursingchartcelltypecat`, `nursingchartcelltypevallabel` and `nursingchartcelltypevalname` provide an organised structure for the data, but `nursingchartvalue` are free text entry and so unstructured.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`nursingChartID` | int | IDENTITY | surrogate key for the nurse charting | PK | C
`nursingChartYear` | smallint | NOT NULL | year of the nursing chart column date |  | T
`nursingChartTime24` | time(0) | NOT NULL | time in 24 hour format of the chart column e.g.: "12:45", "15:30", "3:45" |  | T
`nursingChartTime` | varchar(20) | NOT NULL | time frame of the nursing chart column date: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`nursingChartOffset` | int | NOT NULL | number of minutes from unit admit time that nursing chart column |  | C
`nursingChartEntryYear` | smallint | NOT NULL | year when the nursing chart column date was entered |  | T
`nursingChartEntryTime24` | time(0) | NOT NULL | time in 24 hour format of when the chart column was entered e.g.: "12:45", "15:30", "3:45" |  | T
`nursingChartEntryTime` | varchar(20) | NOT NULL | time frame of when the nursing chart item was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`nursingChartEntryOffset` | int | NOT NULL | number of minutes from unit admit time that nursing chart column was entered |  | C
`nursingChartCellTypeCat` | varchar(255) | NOT NULL | picklist nursing chart category type e.g.: Vital Signs, Scores, Other Vital Signs and Infusions, etc. |  | S
`nursingChartCellTypeValLabel` | varchar(255) | NOT NULL | picklist nursing chart cell type value label e.g.: O2 Saturation, Glasgow coma score, Respiratory Rate, etc. |  | S
`nursingChartCellTypeValName` | varchar(255) | NOT NULL | picklist nursing chart cell type value name e.g.: Value, GCS Eyes, Non-Invasive BP Systolic, etc. |  | S
`nursingChartValue` | varchar(255) | NULL | The text that was entered manually or via a interface for the given Cell Type Val Lable e.g.: 100, 4 units, 35%, etc. |  | S


<!-- # Detailed description

* To follow. -->
