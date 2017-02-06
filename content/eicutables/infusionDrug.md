+++
date = "2015-09-01T19:34:46-04:00"
title = "infusionDrug"
linktitle = "infusionDrug"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU"
+++

# infusionDrug

**Purpose:** Details of drug infusions. Entered from the nursing flowsheet (either manually or interfaced from the hospital electronic health record system).

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

Infusion drugs entered directly into the source system (eCareManager) by clinicians must include the concentration of the drug being infused. This is done by entering the "drugAmount" and "volumeOfFluid" and this is independent of the amount being infused (drugRate or infusionRate). Interfaced values from source EMRs may not contain the concentration.    

* To follow -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key| Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`infusionDrugID` | int | IDENTITY | surrogate key for infusion drugs | PK | C
`infusionYear` | smallint | NOT NULL | year of the infusion drug column date |  | T
`infusionTime24` | time(0) | NOT NULL | time in 24 hour format of when the infusion drug was entered e.g.: "12:45", "15:30", "3:45" |  | T
`infusionTime` | varchar(20) | NOT NULL | time frame of the infusion drug column date: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`infusionOffset` | int | NOT NULL | number of minutes from unit admit time that infusion drug column was entered |  | C
`drugName` | varchar(255) | NOT NULL | picklist name of the infusion drug e.g.: Heparin (units/hr), Vasopressin (units/min), Propofol (mcg/kg/min), etc. |  | S
`drugRate` | varchar(255) | NULL | rate of the infusion drug e.g.: 1300, .7, 0.49, etc. |  | S
`infusionRate` | varchar(255) | NULL | infusion rate of the drug e.g.: 13, 1.25, 25000, etc. |  | S
`drugAmount` | varchar(255) | NULL | the amount of drug given e.g.: 250, 100, 50, etc. |  | S
`volumeOfFluid` | varchar(255) | NULL | volume of fluid for the infusion e.g.: 250, 100, 50, etc. |  | S
`patientWeight` | varchar(255) | NULL | the patient weight recorded during the drug infusion in kilograms e.g.: 87.9, 76.3, 65.8, etc. |  | S

<!-- # Detailed description

* To follow.
 -->
