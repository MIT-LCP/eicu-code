+++
date = "2015-09-01T19:34:46-04:00"
title = "medication"
linktitle = "medication"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# medication

**Purpose:** The medications table reflects the active medication orders for patients. These are orders but dot necessarily reflect administration to the patient. Titration of continuous infusion medications can be obtained in the infusionDrug table. 

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

* The majority of hospitals have an HL7 medication interface system in place which automatically synchronizes the orders with eCareManager as they are verified by the pharmacist in the source pharmacy system. For hospitals without a medication interface, the eICU staff may enter a selection of medications to facilitate population management and completeness for reporting purposes. 

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`medicationID` | int | IDENTITY | surrogate key for drugs | PK | C
`drugOrderYear` | smallint | NOT NULL | year when the drug was ordered |  | T
`drugOrderTime24` | time(0) | NOT NULL | time in 24 hour format of when the drug was ordered e.g.: "12:45", "15:30", "3:45" |  | T
`drugOrderTime` | varchar(20) | NOT NULL | time frame when the drug was ordered: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`drugOrderOffset` | int | NOT NULL | number of minutes from unit admit time that the drug was ordered |  | C
`drugStartYear` | smallint | NOT NULL | year when the drug was started |  | T
`drugStartTime24` | time(0) | NOT NULL | time in 24 hour format of when the drug started e.g.: "12:45", "15:30", "3:45" |  | T
`drugStartTime` | varchar(20) | NOT NULL | time frame when the drug was started: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`drugStartOffset` | int | NOT NULL | number of minutes from unit admit time that the drug was started |  | C
`drugIVAdmixture` | varchar(3) | NOT NULL | contains "Yes" if an IV admixture, "No" otherwise |  | S
`drugOrderCancelled` | varchar(3) | NOT NULL | contains "Yes" if drug order was cancelled, "No" otherwise |  | S
`drugName` | varchar(255) | NOT NULL | name of selected drug e.g.: SODIUM CHLORIDE 0.9%, ONDANSETRON HCL, MORPHINE SULFATE, etc. |  | S
`drugHiclSeqno` | INT | NULL | HICL for the drug e.g.: 8255, 6055, 1694, etc. |  | S
`dosage` | varchar(400) | NOT NULL | the dosage of the drug e.g.: 500 ml, 1 mcg/kg/min, 2.4 units/hour, etc. |  | S
`routeAdmin` | varchar(100) | NOT NULL | the picklist route of administration for the drug e.g.: IV (intravenous), IV - continuous infusion (intravenous), PO (oral), etc. |  | S
`frequency` | varchar(255) | NOT NULL | the picklist frequency with which the drug is taken e.g.: Every 6 hour(s), twice a day, four times per day, etc. |  | S
`loadingDose` | varchar(100) | NOT NULL | the loading dose of the drug e.g.: 0 mg, 2 mg, 2 units, etc. |  | S
`PRN` | varchar(25) | NOT NULL | denotes whether the medication was PRN or not: Yes, No, or BLANK |  | S
`drugStopYear` | smallint | NULL | year when the drug was stopped |  | T
`drugStopTime24` | time(0) | NULL | time in 24 hour format of when the drug was stopped e.g.: "12:45", "15:30", "3:45" |  | T
`drugStopTime` | varchar(20) | NULL | time frame when the drug was stopped: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`drugStopOffset` | int | NULL | number of minutes from unit admit time that the drug was stopped |  | C
`GTC` | int | NULL | The NDDF GTC code associated with the drug |  | S


<!-- # Detailed description

* To follow. -->
