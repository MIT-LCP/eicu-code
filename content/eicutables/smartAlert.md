+++
date = "2015-09-01T19:34:46-04:00"
title = "smartAlert"
linktitle = "smartAlert"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# smartAlert

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`smartAlertID` | int | IDENTITY | surrogate key for the smart alert value | PK | C
`patientUnitStayID` | int | NULL | foreign key link to the patient table | FK | C
`alertName` | varchar(255) | NOT NULL | Internal system name of the alert e.g.: Heart Rate Limit, Sepsis, Combined HR/Map, etc. |  | S
`eventName` | varchar(255) | NOT NULL | Internal system name of the event associated with the alert e.g.: HR Limit Low Alert, SEPSIS_SEVERE_SEPSIS, MAP Limit (A-Line) Moderate High Alert |  | S
`severity` | varchar(30) | NOT NULL | The internal system severity of the alert e.g.: Severe, Moderate |  | S
`triggerYear` | smallint | NOT NULL | Year when the alert went off |  | T
`triggerTime24` | time(0) | NOT NULL | time in 24 hour format of when the smart alert trigger occurred e.g.: "12:45", "15:30", "3:45" |  | T
`triggerTime` | varchar(20) | NOT NULL | time frame when the alert was triggered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`triggerOffset` | int | NOT NULL | number of minutes from unit admit time that the alert was triggered |  | C
`reactivateYear` | int | NULL | Year when the alert was reactivated |  | T
`reactivateTime24` | time(0) | NULL | time in 24 hour format of when the smart alert was reactivated e.g.: "12:45", "15:30", "3:45" |  | T
`reactivateTime` | varchar(20) | NULL | time frame when the alert was reactivated: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`reactivateOffset` | int | NULL | number of minutes from unit admit time that the alert was reactivated |  | C

<!-- # Detailed description

* To follow. -->
