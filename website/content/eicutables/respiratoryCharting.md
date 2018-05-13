+++
date = "2015-09-01T19:34:46-04:00"
title = "respiratoryCharting"
linktitle = "respiratoryCharting"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Unreleased tables"
+++

# respiratoryCharting

**Purpose:**
Data provided in the respiratory chart includes date/time, chart type (e.g. respiratory flow setting, vent data), and respiratory values.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`respChartID` | int | IDENTITY | surrogate key for the respiratory value | PK | C
`respChartYear` | smallint | NOT NULL | year for the respiratory value |  | T
`respChartTime24` | XX | XX | XX | XX | XX | XX
`respChartTime` | varchar(20) | NOT NULL | time frame for the respiratory value: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`respChartOffset` | int | NOT NULL | number of minutes from unit admit time for the respiratory value |  | C
`respChartEntryYear` | smallint | NOT NULL | year when the respiratory value was entered |  | T
`respChartEntryTime24` | time(0) | NOT NULL | time in 24 hour format of the respirator chart column e.g.: "12:45", "15:30", "3:45" |  | T
`respChartEntryTime` | varchar(20) | NOT NULL | time frame when the respiratory value was entered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`respChartEntryOffset` | int | NOT NULL | number of minutes from unit admit time that the respiratory value was entered |  | C
`respChartTypeCat` | varchar(255) | NOT NULL | picklist category type for the respiratory value e.g.: respFlowSettings, respFlowPtVentData, respFlowCareData, etc |  | S
`respChartValueLabel` | varchar(255) | NOT NULL | the picklist row label text from respiratory value e.g.: Bag/Mask (attached to O2), HR, I:E Ratio, etc. |  | S
`respChartValue` | varchar(1000) | NULL | The text that was entered manually or via a interface for the given Cell Type Val Label e.g.: in room, 102, 1:2.0, etc. |  | S

<!-- # Detailed description

* To follow. -->
