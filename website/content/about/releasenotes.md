+++
date = "2015-09-01T19:33:17-04:00"
title = "Release notes"
linktitle = "Release notes"
weight = 2
toc = "true"

[menu]
  [menu.main]
    parent = "About"

+++

# Release notes

This page lists changes implemented in sequential updates to the eICU Collaborative Research Database. Issues are tracked using a unique issue number, usually of the form #100, #101, etc (this issue number relates to a private 'building' repository).

# Current version

The current version of the database is v2.0. When referencing this version, we recommend using the full title: eICU Collaborative Research Database v2.0.

# eICU Collaborative Research Database v2.0

The eICU Collaborative Research Database v2.0 was released on 17 May 2018. This was a major release which involved a schema change, potentially breaking compatibility with existing code.

Changes include:

* #68: The medication table had the following modifications: `drugname` and `dosage` can now be NULL. Frequency of administration has been added in a new column called `frequency`.
* #69: In all tables columns which had a suffix of `time`, `time24`, and `year` were removed, *except* for a single instance in the patient table. These columns were redundant and can be easily rederived if needed using offsets and joining to the patient table.
* #70: Ten tables have been added to the public release. They are: customLab, intakeOutput, microLab, note, nurseAssessment, nurseCare, nurseCharting, physicalExam, respiratoryCare, respiratoryCharting. Documentation of these tables is available online.
* #71: Hospitals which do not have any corresponding patient admissions have been removed from the hospital table.

In addition, the website now contains Jupyter notebooks for each table which highlight potential usage of the data.

# eICU Collaborative Research Database v1.2

The eICU Collaborative Research Database v1.2 was released on 16 August 2017. The only change was:

* #62: the [medication](https://eicu-crd.mit.edu/eicutables/medication/) table was added

# eICU Collaborative Research Database v1.1

The eICU Collaborative Research Database v1.1 was released on 4 May 2017. Issues addressed include:

* #57: an updated version of the [hospital](https://eicu-crd.mit.edu/eicutables/hospital/) table was added
* #56: the [admissiondrug](https://eicu-crd.mit.edu/eicutables/admissiondrug/) table was released
* #55: the [allergy](https://eicu-crd.mit.edu/eicutables/allergy/) table was released
* #54: the [infusionDrug](https://eicu-crd.mit.edu/eicutables/infusionDrug/) table was released

# eICU Collaborative Research Database v1.0

The first public release of the eICU Collaborative Research Database is v1.0. It was made available on 4 March 2017 and included the following tables: `admissionDx`, `apacheApsVar`, `apachePatientResult`, `apachePredVar`, `carePlanCareProvider`, `carePlanEOL`, `carePlanGeneral`, `carePlanGoal`, `carePlanInfectiousDisease`, `diagnosis`, `hospital`, `lab`, `pastHistory`, `patient`, `treatment`, `vitalAperiodic`, `vitalPeriodic`

# eICU Collaborative Research Database v0.1

eICU Collaborative Research Database v0.1 was released on 20 December 2016. It was a preliminary version and not widely publicized to allow for internal testing.
