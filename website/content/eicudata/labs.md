+++
date = "2015-09-01T14:02:13-04:00"
title = "Labs"
linktitle = "Labs"
weight = 5
toc = "true"

[menu]
[menu.main]
parent = "Data details"

+++

# Laboratory tests

* The `lab` table is populated by ~160 "standard" laboratory measurements. When a hospital first participates in the eICU program, they must map these values to their local system. As a result, most common labs are well harmonized in this table. However, it is possible for the lab interface to be down and for standard labs to be recorded in the `customlab` table (e.g. during software upgrades). These downtimes are in principle rare, but an empirical study on how frequently this occurs is yet to be undertaken.

<!-- 
* We believe that the `customlab` is not an automated system - but might instead be anything that the nurse manually types in. We have focused on using the `lab` table and exclude hospitals without observations in `lab`.

* There is an extra timing column (`labresultrevisedtime24`) in the `labs` table. Our understanding is that the `labrevisedtime` is updated any time someone touches the lab at all - including adding a comment on the lab. `labresultrevised` times reflect *any* update to the lab: including addition of comments, or updating the sensitivity/result of a microbiology test. If you are seeking to use the time at which the sample was drawn, we suggest using the `labresulttime24` as the time for data extraction.
-->
