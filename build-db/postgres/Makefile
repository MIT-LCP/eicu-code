## --------------------------------------------------------------------------
## Description: Automated creation of the eICU database and importing of data
## --------------------------------------------------------------------------


## Parameters ##

DBNAME=eicu
DBUSER=eicu
DBPASS=eicu
DBHOST=localhost
DBSCHEMA=eicu

PHYSIONETURL=https://physionet.org/works/eICUCollaborativeResearchDatabase/files/

# if left blank, data is assumed to be in the local directory
datadir=./

## Commands ##
PSQL=psql "dbname=$(DBNAME) options=--search_path=$(DBSCHEMA)" --username=$(DBUSER)

## Export ##
# Parameters given in this Makefile take precedence over those defined in each
# individual Makefile (due to specifying the -e option and the export command
# here)
export

help:
	@echo '                                                                           '
	@echo '---------------------------------------------------------------------------'
	@echo 'Makefile for building eICU in a local Postgres database                    '
	@echo '                                                                           '
	@echo 'Usage:                                                                     '
	@echo '                                                                           '
	@echo '   Build eICU using the CSV files in the /path/to/data directory -         '
	@echo '                                                                           '
	@echo '             make eicu datadir="/path/to/data/"                            '
	@echo '                                                                           '
	@echo '             e.g. make eicu datadir="/data/eicu/"                          '
	@echo '---------------------------------------------------------------------------'
	@echo '                                                                           '


eicu-gz: eicu-check-gz eicu-create-user eicu-build-gz

eicu: eicu-check eicu-create-user eicu-build

eicu-download:
	@echo '-----------------------------------------------'
	@echo '--    Downloading eICU-CRD from PhysioNet    --'
	@echo '-- (requires a valid PhysioNetWorks account) --'
	@echo '-----------------------------------------------'
	@echo ''
	wget --user ${physionetuser} --ask-password -P ${datadir} -A csv.gz -m -p -E -k -K -np -nd  "$(PHYSIONETURL)"

#This is fairly inelegant and could be tidied with a for loop and an if to check for gzip,
#but need to maintain compatability with Windows, which baffling lacks these things
eicu-check-gz:
	@echo ''
	@echo '-----------------------'
	@echo '-- Checking for data --'
	@echo '-----------------------'
	@echo ''
ifeq ("$(wildcard $(datadir)admissionDx.csv.gz)","")
	@echo "Unable to find $(datadir)admissionDx.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apacheApsVar.csv.gz)","")
	@echo "Unable to find $(datadir)apacheApsVar.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apachePatientResult.csv.gz)","")
	@echo "Unable to find $(datadir)apachePatientResults.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apachePredVar.csv.gz)","")
	@echo "Unable to find $(datadir)apachePredVar.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)patient.csv.gz)","")
	@echo "Unable to find $(datadir)patient.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalAperiodic.csv.gz)","")
	@echo "Unable to find $(datadir)vitalAperiodic.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalPeriodic.csv.gz)","")
	@echo "Unable to find $(datadir)vitalPeriodic.csv.gz - exiting before build."; exit 1
endif


eicu-check:
	@echo ''
	@echo '-----------------------'
	@echo '-- Checking for data --'
	@echo '-----------------------'
	@echo ''
ifeq ("$(wildcard $(datadir)admissionDx.csv)","")
	@echo "Unable to find $(datadir)admissionDx.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apacheApsVar.csv)","")
	@echo "Unable to find $(datadir)apacheApsVar.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apachePatientResult.csv)","")
	@echo "Unable to find $(datadir)apachePatientResults.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)apachePredVar.csv)","")
	@echo "Unable to find $(datadir)apachePredVar.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)patient.csv)","")
	@echo "Unable to find $(datadir)patient.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalAperiodic.csv)","")
	@echo "Unable to find $(datadir)vitalAperiodic.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalPeriodic.csv)","")
	@echo "Unable to find $(datadir)vitalPeriodic.csv - exiting before build."; exit 1
endif

eicu-create-user:
	@echo ''
	@echo '-------------------'
	@echo '-- Creating user --'
	@echo '-------------------'
	@echo ''
	DBUSER="$(DBUSER)" DBNAME="$(DBNAME)" DBPASS="$(DBPASS)" ./create_eicu.sh

eicu-build:
	@echo ''
	@echo '-------------------'
	@echo '-- Building eICU --'
	@echo '-------------------'
	@echo ''
	@echo '---------------------'
	@echo '-- Creating tables --'
	@echo '---------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_create_tables.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '------------------'
	@echo '-- Loading data --'
	@echo '------------------'
	@echo ''
	@sleep 2
	cd $(datadir) && PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f $(CURDIR)/postgres_load_data.sql --username="$(DBUSER)" --host="$(DBHOST)" -e
	@echo ''
	@echo '--------------------'
	@echo '-- Adding indexes --'
	@echo '--------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_add_indexes.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '--------------------'
	@echo '-- Adding comments --'
	@echo '--------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_add_comments.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '----------------'
	@echo '-- Check data --'
	@echo '----------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_checks.sql --username="$(DBUSER)" --host="$(DBHOST)"

eicu-build-gz:
	@echo ''
	@echo '-------------------'
	@echo '-- Building eICU --'
	@echo '-------------------'
	@echo ''
	@echo '---------------------'
	@echo '-- Creating tables --'
	@echo '---------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_create_tables.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '-------------------------------------'
	@echo '-- Loading data from gzipped files --'
	@echo '-------------------------------------'
	@echo ''
	@sleep 2
	cd $(datadir) && PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f $(CURDIR)/postgres_load_data_gz.sql --username="$(DBUSER)" --host="$(DBHOST)" -e
	@echo ''
	@echo '--------------------'
	@echo '-- Adding indexes --'
	@echo '--------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_add_indexes.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '--------------------'
	@echo '-- Adding comments --'
	@echo '--------------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_add_comments.sql --username="$(DBUSER)" --host="$(DBHOST)"
	@echo ''
	@echo '----------------'
	@echo '-- Check data --'
	@echo '----------------'
	@echo ''
	@sleep 2
	PGPASSWORD=$(DBPASS) psql "dbname=${DBNAME} options=--search_path=${DBSCHEMA}" -f postgres_checks.sql --username="$(DBUSER)" --host="$(DBHOST)"

.PHONY: help eicu
