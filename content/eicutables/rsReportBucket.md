+++
date = "2015-09-01T19:34:46-04:00"
title = "rsReportBucket"
linktitle = "rsReportBucket"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# rsReportBucket

**Purpose:** 

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`rsReportBucketID` | int | IDENTITY | surrogate key for the Reporting Solutions report bucket value | PK | C
`reportConditionCategory` | varchar(50) | NOT NULL | Reporting Solutions report condition category e.g.: Beta Blockers, Common Report Conditions, Report Totals, etc. |  | S
`reportConditionDescription` | varchar(255) | NOT NULL | Reporting Solutions report condition description e.g.: Actual Deaths (ICU Mortality), Not Treated, UGI Bleeding, etc. |  | S
`reportConditionValue` | varchar(50) | NULL | The value associated with the report condition description e.g. 56.5, 1.000 |  | S

<!-- # Detailed description

* To follow. -->
