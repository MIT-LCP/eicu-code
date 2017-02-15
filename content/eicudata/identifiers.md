+++
date = "2015-09-01T14:02:13-04:00"
title = "Identifiers"
linktitle = "Identifiers"
weight = 1
toc = "true"

[menu]
[menu.main]
parent = "Data details"

+++

# Identifiers

Identifiers are used across the database to identify unique concepts such as patients, hospitals, ICU stays, and so on. These identifiers include:

* A unique `hospitalid`, which is assigned to each hospital in the database.

* A unique `patienthealthsystemsstayid`, which is assigned to each hospital stay (the equivalent of MIMIC's `hadm_id`)

* A unique `patientunitstayid`, which is assigned to each ICU stay (the equivalent of MIMIC's `icustay_id`)

* A `uniquepid` which links patients across multiple hospital stays.
