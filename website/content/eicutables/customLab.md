+++
date = "2015-09-01T19:34:46-04:00"
title = "customLab"
linktitle = "customLab"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# customLab

**Purpose:** Standardized labs are included in the 'lab' table. Laboratory measurements that are not configured within the standard interface (for example, unmapped tests) are included in the customLab table.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow.
 -->
# Table columns

Name | Datatype | Null option | Comment | Key
---- | ---- | ---- | ---- | ----
`customlabid`       | bigint     | not null |  |  PK
`patientunitstayid` | bigint     | not null |  |  FK
`labotheroffset`    | bigint     | not null |  |
`labothertypeid`    | bigint     | not null |  |
`labothername`      | chvar(64)  |          |  |
`labotherresult`    | chvar(64)  |          |  |
`labothervaluetext` | chvar(128) |          |  |


<!--
      Column       |          Type          | Modifiers | Comment
-------------------+------------------------+---------------------
 customlabid       | bigint                 | not null |
 patientunitstayid | bigint                 | not null |
 labotheryear      | smallint               | not null |
 labothertime24    | chvar(8)   | not null |
 labothertime      | chvar(20)  | not null |
 labotheroffset    | bigint                 | not null |
 labothertypeid    | bigint                 | not null |
 labothername      | chvar(64)  |          |
 labotherresult    | chvar(64)  |          |
 labothervaluetext | chvar(128) |          |

-->

<!-- # Detailed description

* To follow. -->
