+++
date = "2015-09-01T19:34:46-04:00"
title = "respiratoryCare"
linktitle = "respiratoryCare"
weight = 10
toc = "true"

[menu]
  [menu.main]
    parent = "Tables in eICU-CRD"
+++

# respiratoryCare

**Purpose:** The table contains information related to respiratory care.
Patient data includes sequence of records for historical ordering, airway type/size/position, cuff pressure and various vent details including vent start and end dates/times, pressure limits, etc.

**Links to:**

* PATIENT on `patientUnitStayID`

<!-- # Important considerations

* To follow. -->

# Table columns

Name | Datatype | Null Option | Comment | Is Key | Stored Transformed Created
---- | ---- | ---- | ---- | ---- | ----
`patientUnitStayID` | int | NOT NULL | foreign key link to the patient table | FK | C
`respCareID` | int | IDENTITY | surrogate key for the respiratory data | PK | C
`respCareStatusOffset` | int | NOT NULL | number of minutes from unit admit time that the respiratory value was entered |  | C
`currentHistorySeqNum` | int | NULL | the sequence number of the records for historical ordering |  | S
`airwayType` | varchar(30) | NULL | the airway picklist type input into the respiratory care status e.g.: Laryngectomy, Tracheostomy, Oral ETT, etc. |  | S
`airwaySize` | varchar(10) | NULL | the picklist airway size input into the respiratory care status e.g.: 35F, 9.5, NULL |  | S
`airwayPosition` | varchar(32) | NULL | picklist airway position for the patient e.g.: 23 @ lip, 26 @ teeth, 20, etc. |  | S
`cuffPressure` | decimal(5,1) | NULL | the picklist cuff pressure of the patient e.g.: 23.0, 22.0, NULL, etc. |  | S
`ventStartOffset` | int | NULL | number of minutes from unit admit time that the vent was started |  | C
`ventEndOffset` | int | NULL | number of minutes from unit admit time that the vent was ended |  | C
`priorVentStartYear` | smallint | NULL | year when the prior vent started |  | T
`priorVentStartTime24` | time(0) | NULL | time in 24 hour format of when the prior vent start event occurred e.g.: "12:45", "15:30", "3:45" |  | T
`priorVentStartTime` | varchar(20) | NULL | time frame when the prior vent started: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`priorVentStartOffset` | int | NULL | number of minutes from unit admit time that the prior vent was started |  | C
`priorVentEndYear` | smallint | NULL | year when the prior vent ended |  | T
`priorVentEndTime24` | time(0) | NULL | time in 24 hour format of when the prior vent event ended e.g.: "12:45", "15:30", "3:45" |  | T
`priorVentEndTime` | varchar(20) | NULL | time frame when the prior vent ended: 'midnight', 'morning', 'midday', 'noon', 'evening', or 'night' |  | T
`priorVentEndOffset` | int | NULL | number of minutes from unit admit time that the prior vent was ended |  | C
`apneaParams` | varchar(80) | NULL | the picklist apnea parameters of the vent e.g.: set, on, done, etc. |  | S
`lowExhMVLimit` | decimal(11,4) | NULL | the low Ex MV Limit of the vent e.g: 5.0000, 200.0000, 3.0000, etc. |  | S
`hiExhMVLimit` | decimal(11,4) | NULL | the high Ex MV Limit of the vent e.g.: 18.000, 20.0000, 40.0000, etc. |  | S
`lowExhTVLimit` | decimal(11,4) | NULL | the low Exh TV limit of the vent e.g.: 300.0000, 200.0000, 350.0000, etc. |  | S
`hiPeakPresLimit` | decimal(11,4) | NULL | the high peak pressure limit of the vent e.g.: 45.0000, 65.0000, 50.0000, etc. |  | S
`lowPeakPresLimit` | decimal(11,4) | NULL | the low peak pressure limit of the vent e.g.: 10.0000, 150.0000, 15.0000, etc. |  | S
`hiRespRateLimit` | decimal(11,4) | NULL | the high respiration rate limit of the vent e.g.: 40.0000, 32.0000, 24.0000, etc. |  | S
`lowRespRateLimit` | decimal(11,4) | NULL | the low respiration rate limit of the vent e.g.: 12.0000, 5.0000, 8.0000, etc. |  | S
`sighPresLimit` | decimal(11,4) | NULL | the sigh pressure limit of the vent |  | S
`lowIronOxLimit` | decimal(11,4) | NULL | the low iron ox limit of the vent e.g.: 90.0000, 40.0000, 0.0000, etc. |  | S
`highIronOxLimit` | decimal(11,4) | NULL | the high iron ox limit of the vent e.g.: 100.0000, 120.0000, 90.0000, etc. |  | S
`meanAirwayPresLimit` | decimal(11,4) | NULL | the mean airway pressure limit of the vent e.g.: 60.0000, 45.0000, 50.0000, etc. |  | S
`PEEPLimit` | decimal(11,4) | NULL | the PEEP limit of the vent e.g.: 10.0000, 14.0000, 8.0000, etc. |  | S
`CPAPLimit` | decimal(11,4) | NULL | the CPAP limit of the vent e.g.: 2.0000, 10.0000, 5.0000, etc. |  | S
`setApneaInterval` | varchar(80) | NULL | the picklist apnea interval of the vent e.g.: .20, 1:5, 20 sec, etc. |  | S
`setApneaTV` | varchar(80) | NULL | the picklist apnea TV of the vent e.g.: 300, 460, 800, etc. |  | S
`setApneaIPPEEPHigh` | varchar(80) | NULL | the picklist apnea IPPEEP high of the vent e.g.: 5, 7.0, 3.0, etc. |  | S
`setApneaRR` | varchar(80) | NULL | the apnea RR of the vent e.g.: 20, 10, 28, etc. |  | S
`setApneaPeakFlow` | varchar(80) | NULL | th picklist e apnea peak flow of the vent e.g.: .80, 70, 100, etc. |  | S
`setApneaInspTime` | varchar(80) | NULL | the picklist apnea insp time of the vent e.g.: 096, 80, .7, etc. |  | S
`setApneaIE` | varchar(80) | NULL | the picklist apnea IE of the vent e.g.: 1:2, 1:5, 1:3, etc. |  | S
`setApneaFIO2` | varchar(80) | NULL | the picklist apnea FIO2 of the vent e.g.: 1.0, 100, 100%, etc. |  | S

<!-- # Detailed description

* To follow. -->
