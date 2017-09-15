+++
date = "2015-09-01T19:34:46-04:00"
title = "autoAcuityQuickEntry"
linktitle = "autoAcuityQuickEntry"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# autoAcuityQuickEntry

**This table is not currently available in the public dataset.**

**Purpose:** The eCareManager software contains an algorithm which continuously calculates an automated acuity score. In order to be assigned an acuity score, patients need certain measurements in the database (e.g. GCS). However sometimes these values are not integrated. The quick entry feature allows a care provider to quickly enter the needed data so that it can be used to generate an acuity score. The record of these entries are stored in this table and can be used to supplement data unavailable through traditional documentation sources. 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`autoAcuityQuickEntryID` | int | IDENTITY | surrogate key for the auto acuity quick entry item | PK | C
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`lastSavedYear` | smallint | NOT NULL | year when the auto acuity quick entry item was incurred |  | T
`lastSavedTime24` | time(0) | NOT NULL | time in 24 hour format of when the auto acuity quick entry item was incurred occurred e.g.: “12:45”, “15:30”, “3:45” |  | T
`lastSavedTime` | varchar(20) | NOT NULL | time frame when the auto acuity quick entry item was incurred: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`lastSavedOffset` | int | NOT NULL | number of minutes from health system admit time that the auto acuity quick entry item was incurred |  | C
`vasoactiveMedsScore` | smallint | NULL | acuity quick entry vasoactive meds score e.g. “1”, “2”, “3”, “4” or NULL |  | S
`peepScore` | smallint | NULL | auto acuity quick entry PEEP score e.g. “1”, “2” or NULL |  | S
`temperatureScore` | smallint | NULL | acuity quick entry temperature score e.g. “1”, “2”, “3”, “4” or NULL |  | S
`gcsScore` | smallint | NULL | auto acuity quick entry GCS score e.g. “15”, “9”, “5”, etc. |  | S

<!-- # Detailed description

* To follow.
 -->