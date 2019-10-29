+++
date = "2015-09-01T19:34:46-04:00"
title = "infusionDrug"
linktitle = "infusionDrug"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# infusionDrug

**Purpose:** Details of drug infusions. Entered from the nursing flowsheet (either manually or interfaced from the hospital electronic health record system).

**Links to:**

* PATIENT on `patientUnitStayID`

# Important considerations

- Infusion drugs entered directly into the source system (eCareManager) by clinicians must include the concentration of the drug being infused. This is done by entering the "drugAmount" and "volumeOfFluid" and this is independent of the amount being infused (drugRate or infusionRate). Interfaced values from source EMRs may not contain the concentration.
- Many EHRs will only interface out the infusion rate so you may only get the mL/hr and it may be difficult to get the actual drug rate unless it's a standard concentration drug like 10% propofol. The exact drug name and concentration may be present in the medication table to verify concentration.

Let's take an example row:

infusiondrugid | drugname | drugrate | infusionrate | drugamount | volumeoffluid
--- | --- | --- | --- | --- | ---
2001050 | Nitroglycerin (mcg/min) | 10 | 3 | 50 | 250

- Concentration will generally be charted in mg and ml. So for this patient with a `drugamount` = 50 and a `volumeoffluid` = 250, the administration is from a 50 mg/250 mL bottle of the drug.
- Infusion rate is generally charted as ml/hr. So this patient is receiving 3ml/hr of 50mg/mL of NTG.
- Drug rate units should be specified and should match the calculation obtained from the infusion rate * concentration (which this does once you convert mg to mcg).


# Table columns

Name | Datatype | Null Option | Comment | Is Key| Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | a globally unique identifier (GUID) used as a foreign key link to the patient table | FK | C
`infusionDrugID` | int | IDENTITY | surrogate key for infusion drugs | PK | C
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
