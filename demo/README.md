# eICU Collaborative Research Database Demo

eICU-CRD is a large multi-center database of over 200,000 critical care admissions for 140,000 unique patients admitted to hospitals in the United States. All data were collected during routine patient care.

Due to the sensitive nature of the data, the full dataset requires the signing of a data use agreement and completion of the "Data or Specimens Only" CITI course. The course usually takes 2-3 hours, and verification takes up to one week. You can read more about how to access eICU-CRD online: http://eicu-crd.mit.edu/gettingstarted/access/

To encourage use of the data, a small subset (~1% of patients) is made fully publicly available. A random 50 patients were selected from 20 hospitals in the eICU-CRD. There are two recommended methods for working with the data:

1. An SQLite file is attached as supplemental material. This is a lightweight database file which can be opened by a number of applications. Below we include instructions on how to install a program, "DB Browser for SQLite", which allows easy navigation of the data.
2. A set of comma separated value files on PhysioNetWorks. Access to this data is done via this link: https://physionet.org/works/eICUCollaborativeResearchDatabaseDemo/files/

# Installing DB Browser for SQLite

DB Browser for SQLite is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite.
We have found this tool to be useful for navigating SQLite files. Installation is fairly straightforward.

Instructions to install the tool are available online: http://sqlitebrowser.org/

# Load SQLite file

Once DB browser is installed and launched, the database file can be accessed by clicking "Open Database" and navigating to the eicu-crd-demo.sqlite3 file (you will have to extract the sqlite3 file from the zip file you downloaded using any appropriate decompression software).
