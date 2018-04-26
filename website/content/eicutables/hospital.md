+++
date = "2015-09-01T19:34:46-04:00"
title = "hospital"
linktitle = "hospital"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# hospital

**Purpose:** The hospital table contains details of hospitals covered by the the eICU telehealth program.

**Links to:**

* PATIENT on `hospitalID`

# Important considerations

* The data was collected by self-reported survey.

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`hospitalid` | int | NOT NULL | surrogate key for the hospital | PK | S
`numbedscategory` | int |   | number of beds |   | S
`teachingstatus` | int |   | teaching status of hospital |   | S
`region` | int |   | region of hospital |   | S
