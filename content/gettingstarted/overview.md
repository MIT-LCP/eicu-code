+++
date = "2015-09-01T19:34:46-04:00"
title = "Overview"
linktitle = "Overview"
weight = 1
toc = "true"

[menu]
  [menu.main]
    parent = "Getting started"

+++


# Overview of the eICU data

The eICU Collaborative Database is a collection of tables relating to patients who were treated as part of the [Philips eICU program](http://www.usa.philips.com/healthcare/product/HCNOCTN503/eicu-program-telehealth-for-the-intensive-care-unit) across intensive care units in the United States. The tables are linked by a set of identifiers, such as `patientunitstayid` which uniquely identifies a single ICU stay and `hospitalid` which uniquely identifies a hospital. 

# List of tables

The following tables form part of the eICU schema:

**Name**                        | **Brief description**
------------------------------- | -------------------------------------------------------------------------------------------------------------------------
**admissionDrug**               | from note, admitDrug
**admissionDx**                 | from admissionDiagnosis, admissionDiagnosisItem
**allergy**                     | from note, allergy
**apacheApsVar**                | from Apache.dbo.apache\_ApsVar
**apachePatientResults**        | from Apache.dbo.apache\_patient\_results
**apachePredVar**               | from Apache.dbo.apache\_PredVar
**apachePrePatientResult**      | from apacePreDB..apacheAPIResult
**carePlanCareProvider**        | from cplHistory, cplGroup, and cplItemCareProvider
**carePlanEOL**                 | from cplHistory, cplGroup, and cplItemEol
**carePlanGeneral**             | from cplHistory, cplGroup, and cplItemGeneral
**carePlanGoal**                | from cplHistory, cplGroup, and cplItemGoal
**carePlanInfectiousDisease**   | from cplHistory, cplGroup, and cplItemInfectiousDisease
**customLab**                   | from abgOtherValue, chemistryOtherValue, drugLevelOtherValue, hematologyOtherValue, miscOtherValue, sensitiveOtherValue
**diagnosis**                   | from patientDXRxItemSet, patientDxRx, patientDxRxLeaf, vrefDxRx, vrefDxRxCodingMap, and vrefCode
**infusionDrug**                | from fsVSIColumn, fsVSICell, fsVSICellAttribute
**intakeOutput**                | from fsIOColumn, fsIOCell,fsIOCellAttribute
**lab**                         | from abgLab, chemistryLab, drugLevelLab, hematologyLab, miscLab, sensitiveLab
**medication**                  | from medicalOrder, drugOrder, drugOrderHistory, drugList
**microLab**                    | from microbiology, microOrganism, and microSensitivity
**note**                        | from note, noteItem
**nurseAssessment**             | from fsNAColumn, fsNACell, fsNACellAttribute, fsNACustomLabel
**nurseCare**                   | from fsNCColumn, fsNCCell, fsNCCellAttribute, fsNCCustomLabel
**nurseCharting**               | from fsVSIColumn, fsVSICell, fsVSICellAttribute, fsVSICustomLabel
**pastHistory**                 | from note, noteItem
**patient**                     | from person, patient, patientHealthSystemStay, patientWardStay, ward
**physicalExam**                | from note, noteItem
**respiratoryCare**             | from respFlowsheetCareStatusHistory
**respiratoryCharting**         | from respFlowsheetColumn respFlowsheetCell, respFlowsheetCustomLabel
**treatment**                   | from patientDXRxItemSet, patientDxRx, patientDxRxLeaf, and vrefDxRx
**vitalAperiodic**              | from vitalSignAperiodic
**vitalPeriodic**               | from vitalSignPeriodic5minute


