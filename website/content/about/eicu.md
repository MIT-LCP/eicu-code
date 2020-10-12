+++
date = "2015-09-01T19:33:17-04:00"
title = "eICU"
linktitle = "eICU Database"
weight = 1
toc = "true"

[menu]
  [menu.main]
    parent = "About"

+++

# eICU Collaborative Research Database

The [Philips eICU program](http://www.usa.philips.com/healthcare/product/HCNOCTN503/eicu-program-telehealth-for-the-intensive-care-unit) is a transformational critical care telehealth program that delivers need-to-know information to caregivers, empowering them to care for the patients. It is a supplement — not a replacement — to the bedside team, and the data utilized by the remote care givers are archived for research purposes.

Through this work, we have generated a large database which has potential for facilitating additional research initiatives on patient outcomes, trends, and other best practice protocols in use today at most healthcare facilities. The Philips eICU Research Institute (eRI), which maintains the data, has generously contributed the eICU Collaborative Research Database described here.

## Coverage

The eICU Collaborative Research Database is populated with data from a combination of many critical care units throughout the continental United States. The data in the collaborative database covers patients who were admitted to critical care units in 2014 and 2015.

## Identifiers

Identifiers are used across the database to identify unique concepts such as patients, hospitals, ICU stays, and so on. These identifiers include:

* `hospitalid` - which uniquely identifies each hospital in the database.
* `uniquepid` - uniquely identifies patients (i.e. it is always the same value for the same person)
* `patienthealthsystemsstayid` - uniquely identifies hospitals stays
* `patientunitstayid` - uniquely identifies unit stays (usually the unit is an ICU within a hospital)

Almost all tables use `patientunitstayid` as the primary identifier.

## Times

* The time stamp of all events are stored as offsets from the time of ICU admission, in minutes. As a result, hospital admission time will in general be negative.
* It may help to add a pre-ICU admission "fuzz" because sometimes laboratory measurements are measured pre-ICU, e.g., look at all the labs measured from (-6*24) minutes to (24*60) minutes from ICU admission.

## Data interfaces

Data from each patient is collected into a common warehouse only if certain "interfaces" are available. Each interface is used to transform and load a certain type of data: vital sign interfaces incorporate vital signs, laboratory interfaces provide measurements on blood samples, and so on. It is important to be aware that different care units may have different interfaces in place, and that the lack of an interface will result in no data being available for a given patient, even if those measurements were made in reality.

### Inputs and Outputs

* The `medication` table is essentially an interface to pharmacy data - i.e. prescribed medications.
* The `intakeoutput` and `infusiondrug` tables should be used for fluids and drugs, respectively. It is a challenge to decide whether a hospital is actually collecting and archiving data in the `infusiondrug` table.

### Laboratory tests

* The `lab` table is populated by ~160 "standard" laboratory measurements. When a hospital first participates in the eICU program, they must map these values to their local system. As a result, most common labs are well harmonized in this table. However, it is possible for the lab interface to be down and for standard labs to be recorded in the `customlab` table (e.g. during software upgrades). These downtimes are in principle rare, but an empirical study on how frequently this occurs is yet to be undertaken.

<!-- ## Vital signs interface

All patients have a vital sign interface.

## Laboratory interface

Almost all patients have a laboratory interface.

## Inputs/Outputs interface

TBD. -->
