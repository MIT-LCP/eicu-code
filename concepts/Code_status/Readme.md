The files here create a patient table that tracks the changes to the patient code status. The careplangeneral table was used instead of careplaneol because careplaneol had much less recorded patients, and the type of code status change was recorded in careplangeneral. There are two versions of the files: .Rmd and .sql. The Rmd version is the supported version, while the SQL version is not supported and was added just as a template.

Rmd:
  - carePlan_getItemValues creates a csv that contains all the cplitemvalues for inspection, in order to choose the values that correspond to patient code status.
  - carePlan_getPatientCode creates a table that lists the recorded patient code status at a certain time (offset).
 
SQL:
  - carePlan_getItemValues creates a materialized view that lists all the cplitemvalues (possible statuses) in descending order of the counts
  - carePlan_getPatientCode creates a materialized view that lists the recorded patient code status at a certain time (offset).
