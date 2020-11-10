+++
date = "2015-09-01T14:02:13-04:00"
title = "Install eICU locally"
linktitle = "Install eICU locally"
weight = 1
toc = "true"

[menu]
  [menu.main]
    parent = "Tutorials"
+++

# How to install the database in Postgres

Prerequisites: *This tutorial assumes that you have already completed the [steps required to gain access](/gettingstarted/access) to the eICU Collaborative Research Database on PhysioNet.*

## 1. Install Postgres

Postgres (also known as PostgreSQL) is a database management system. To create an instance of the database on your local machine, you'll first need to make sure that Postgres is installed. For installation, please refer to: http://www.postgresql.org/download/

On Mac OSX with the [Homebrew package manager](http://brew.sh/), simply type ```brew install postgres```. On Ubuntu Linux, try ```sudo apt-get install postgresql-9.4```.

## 2. Place the CSV data files in a local directory

Assuming that you have completed the [steps required to gain access](/gettingstarted/access), you should be able to access the CSV data files on PhysioNet at: https://physionet.org/content/eicu-crd/. Download these files to a local folder and decompress them if necessary.

## 3. Connect to the database with psql

Now that Postgres is running, you should be able to connect to the system using the ```psql``` command line tool. With new installations, the default database name is 'postgres', so try connecting with:

``` bash
# connect to the default database
psql postgres
```

## 4. Create an empty database containing the database schema

From this point onwards we will be referring to scripts in the '[build-db](https://github.com/mit-lcp/eicu-code/tree/master/build-db)' directory of the [eICU code repository](https://github.com/mit-lcp/eicu-code/).

After connecting with psql, create a new user. Next, create a eICU database with a schema for eICU:

```sql
CREATE USER EICU;
CREATE DATABASE EICU OWNER EICU;
# connect to the database
\c EICU
CREATE SCHEMA IF NOT EXISTS EICU;
```

For convenience, the default schema used by PostgreSQL can be modified to 'EICU'. This removes the need for explicitly referencing the schema, e.g. `DROP TABLE EICU.ADMISSIONDRUG` can simply be written as `DROP TABLE ADMISSIONDRUG`. This is done as follows:

```sql
SET search_path TO EICU;
```

## 5. Create a set of empty tables, ready to populate with the data

Refer to the '[postgres_create_tables](https://github.com/MIT-LCP/eicu-code/blob/master/build-db/postgres/postgres_create_tables.sql)' script in the eICU code repository to build a set of empty tables. Each table is created by running a ```CREATE TABLE``` command in psql. For example, the caregivers table is created with:

``` psql
-- drop the table if it already exists
DROP TABLE IF EXISTS ADMISSIONDX;

-- create the table
CREATE TABLE ADMISSIONDX
(
  ADMISSIONDXID BIGINT NOT NULL,
  PATIENTUNITSTAYID BIGINT NOT NULL,
  ADMITDXENTEREDYEAR SMALLINT NOT NULL,
  ADMITDXENTEREDTIME24 VARCHAR(8) NOT NULL,
  ADMITDXENTEREDTIME VARCHAR(20) NOT NULL,
  ADMITDXENTEREDOFFSET BIGINT NOT NULL,
  ADMITDXPATH VARCHAR(500) NOT NULL,
  ADMITDXNAME VARCHAR(255),
  ADMITDXTEXT VARCHAR(255)
) ;
```

## 6. Import the CSV data files into the empty tables

Using the [Postgres ```COPY``` or ```\COPY``` commands](https://wiki.postgresql.org/wiki/COPY), you should now be able to import the CSV data into the empty set of tables. Refer to the '[postgres_load_data](https://github.com/MIT-LCP/eicu-code/blob/master/build-db/postgres/postgres_load_data.sql)' script in the eICU code repository to import data into the already created empty tables.

The script uses the `\COPY` command, which imports the data from the local directory. An example command run is as follows:
Option 1: import with ```\COPY```

``` sql
\COPY ADMISSIONDX from 'ADMISSIONDX.csv' with DELIMITER ',' CSV HEADER
```

An alternative is the use of the `COPY` command, where you can specify the path of the data:

``` sql
COPY ADMISSIONDX
    FROM '/path/to/file/ADMISSIONDX.csv'
    DELIMITER ','
    CSV HEADER;
```

*Importing the data can be slow, particularly for larger tables like VITALPERIODIC which may take several hours.*

## 7. Add indexes to improve performance

Indexes provide additional structure for the database that can help to improve the speed of queries. The eICU code repository [includes a script with a set of suggested indexes](https://github.com/MIT-LCP/eicu-code/blob/master/build-db/postgres/postgres_add_indexes.sql). For example, an index on subject_id and hadm_id can be created for the ADMISSIONS table with the following command:

``` sql
-- drop the existing index if it exists
DROP INDEX IF EXISTS APACHEPATIENTRESULTS_idx01;

-- create the index
CREATE INDEX APACHEPATIENTRESULTS_idx01
  ON APACHEPATIENTRESULTS (PATIENTUNITSTAYID)
```

## 8. The database is ready for analyses

You should now have a working copy of the eICU Collaborative Research Database ready to query with the psql command line tool. Try, for example, counting the number of patients in the database:

``` sql
select count(PATIENTUNITSTAYID)
from PATIENTS;
```

## 9 (optional). Install PgAdminIII

PgAdmin is a graphical user interface ('GUI') tool for administering Postgres databases. For installation guidelines see: http://www.pgadmin.org/download/

On Mac OSX with the [Homebrew package manager](http://brew.sh/), install PgAdminIII with ```brew install cask pgadmin3``` ('brew cask' is a tool for installing non-command-line packages). On Ubuntu Linux, try ```sudo apt-get install pgadmin3```.

Once PgAdminIII is installed, it can be connected to your local eICU instance. The tool offers a simple point and click interface for exploring the data and running queries.

<!-- ![PgAdminIII screenshot](/img/tutorial_pgadminIII.png) -->
