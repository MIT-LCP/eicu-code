## --------------------------------------------------------------------------
## Description: Automated creation of the eICU database and importing of data
## --------------------------------------------------------------------------

# Config
PHYSIONETURL=https://physionet.org/files/eicu-crd/2.0/
PHYSIONETDEMOURL=https://physionet.org/files/eicu-crd-demo/2.0/

# Set the following parameters to defaults
# These will be overwritten by settings passed to the makefile
# Database filename will be "$(DBNAME).db"
DBNAME := eicu

# Need to specify ".exe" in Makefiles under Windows.
ifeq ($(OS),Windows_NT)
	DBEXEC := duckdb.exe $(DBNAME).db
else
	DBEXEC := duckdb $(DBNAME).db
endif

help:
	@echo '                                                                           '
	@echo '---------------------------------------------------------------------------'
	@echo 'Makefile for building eICU in a DuckDB database file                       '
	@echo '                                                                           '
	@echo 'Usage:                                                                     '
	@echo '                                                                           '
	@echo '   Build eICU using the CSV files in the /path/to/data directory -         '
	@echo '                                                                           '
	@echo '             make eicu datadir="/path/to/data/"                            '
	@echo '                                                                           '
	@echo '             e.g. make eicu datadir="/data/eicu/"                          '
	@echo '                                                                           '
	@echo '                                                                           '
	@echo '   Build eICU using the Gzipped CSV files in the /path/to/data directory - '
	@echo '                                                                           '
	@echo '             make eicu-gz datadir="/path/to/data/"                         '
	@echo '                                                                           '
	@echo '             e.g. make eicu-gz datadir="/data/eicu/"                       '
	@echo '---------------------------------------------------------------------------'
	@echo '                                                                           '


eicu-gz: eicu-check-gz eicu-build-gz

eicu: eicu-check eicu-build

eicu-download:
	@echo '-----------------------------------------------'
	@echo '--    Downloading eICU-CRD from PhysioNet    --'
	@echo '-- (requires a valid PhysioNetWorks account) --'
	@echo '-----------------------------------------------'
	@echo ''
ifeq ("$(physionetuser)","")
	@echo 'Cannot download data: physionetuser variable is unset.'
	@echo 'Call the makefile again with physionetuser=<USERNAME>'
	@echo ' e.g. make eicu-download datadir=/path/to/data physionetuser=hello@physionet.org'
else
	wget --user $(physionetuser) --ask-password -P $(datadir) -A csv.gz -m -p -E -k -K -np -nd  "$(PHYSIONETURL)"
endif


#This is fairly inelegant and could be tidied with a for loop and an if to check for gzip,
#but need to maintain compatability with Windows, which baffling lacks these things
eicu-check-gz:
	@echo ''
	@echo '-----------------------'
	@echo '-- Checking for data --'
	@echo '-----------------------'
	@echo ''
ifeq ("$(wildcard $(datadir)admissionDrug.csv.gz)","")
	@echo "Unable to find $(datadir)admissionDrug.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)admissionDx.csv.gz)","")
	@echo "Unable to find $(datadir)admissionDx.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)allergy.csv.gz)","")
	@echo "Unable to find $(datadir)allergy.csv.gz - exiting before build."; exit 1
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
ifeq ("$(wildcard $(datadir)carePlanCareProvider.csv.gz)","")
	@echo "Unable to find $(datadir)carePlanCareProvider.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanEOL.csv.gz)","")
	@echo "Unable to find $(datadir)carePlanEOL.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanGeneral.csv.gz)","")
	@echo "Unable to find $(datadir)carePlanGeneral.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanGoal.csv.gz)","")
	@echo "Unable to find $(datadir)carePlanGoal.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanInfectiousDisease.csv.gz)","")
	@echo "Unable to find $(datadir)carePlanInfectiousDisease.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)customLab.csv.gz)","")
	@echo "Unable to find $(datadir)customLab.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)diagnosis.csv.gz)","")
	@echo "Unable to find $(datadir)diagnosis.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)hospital.csv.gz)","")
	@echo "Unable to find $(datadir)hospital.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)infusionDrug.csv.gz)","")
	@echo "Unable to find $(datadir)infusiondrug.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)intakeOutput.csv.gz)","")
	@echo "Unable to find $(datadir)intakeOutput.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)lab.csv.gz)","")
	@echo "Unable to find $(datadir)lab.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)medication.csv.gz)","")
	@echo "Unable to find $(datadir)medication.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)microLab.csv.gz)","")
	@echo "Unable to find $(datadir)microLab.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)note.csv.gz)","")
	@echo "Unable to find $(datadir)note.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseAssessment.csv.gz)","")
	@echo "Unable to find $(datadir)nurseAssessment.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseCare.csv.gz)","")
	@echo "Unable to find $(datadir)nurseCare.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseCharting.csv.gz)","")
	@echo "Unable to find $(datadir)nurseCharting.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)pastHistory.csv.gz)","")
	@echo "Unable to find $(datadir)pastHistory.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)patient.csv.gz)","")
	@echo "Unable to find $(datadir)patient.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)physicalExam.csv.gz)","")
	@echo "Unable to find $(datadir)physicalExam.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)respiratoryCare.csv.gz)","")
	@echo "Unable to find $(datadir)respiratoryCare.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)respiratoryCharting.csv.gz)","")
	@echo "Unable to find $(datadir)respiratoryCharting.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)treatment.csv.gz)","")
	@echo "Unable to find $(datadir)treatment.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalAperiodic.csv.gz)","")
	@echo "Unable to find $(datadir)vitalAperiodic.csv.gz - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalPeriodic.csv.gz)","")
	@echo "Unable to find $(datadir)vitalPeriodic.csv.gz - exiting before build."; exit 1
endif
	@echo 'All data present!'


eicu-check:
	@echo ''
	@echo '-----------------------'
	@echo '-- Checking for data --'
	@echo '-----------------------'
	@echo ''
ifeq ("$(wildcard $(datadir)admissionDrug.csv)","")
	@echo "Unable to find $(datadir)admissionDrug.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)admissionDx.csv)","")
	@echo "Unable to find $(datadir)admissionDx.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)allergy.csv)","")
	@echo "Unable to find $(datadir)allergy.csv - exiting before build."; exit 1
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
ifeq ("$(wildcard $(datadir)carePlanCareProvider.csv)","")
	@echo "Unable to find $(datadir)carePlanCareProvider.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanEOL.csv)","")
	@echo "Unable to find $(datadir)carePlanEOL.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanGeneral.csv)","")
	@echo "Unable to find $(datadir)carePlanGeneral.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanGoal.csv)","")
	@echo "Unable to find $(datadir)carePlanGoal.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)carePlanInfectiousDisease.csv)","")
	@echo "Unable to find $(datadir)carePlanInfectiousDisease.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)customLab.csv)","")
	@echo "Unable to find $(datadir)customLab.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)diagnosis.csv)","")
	@echo "Unable to find $(datadir)diagnosis.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)hospital.csv)","")
	@echo "Unable to find $(datadir)hospital.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)infusionDrug.csv)","")
	@echo "Unable to find $(datadir)infusiondrug.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)intakeOutput.csv)","")
	@echo "Unable to find $(datadir)intakeOutput.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)lab.csv)","")
	@echo "Unable to find $(datadir)lab.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)medication.csv)","")
	@echo "Unable to find $(datadir)medication.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)microLab.csv)","")
	@echo "Unable to find $(datadir)microLab.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)note.csv)","")
	@echo "Unable to find $(datadir)note.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseAssessment.csv)","")
	@echo "Unable to find $(datadir)nurseAssessment.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseCare.csv)","")
	@echo "Unable to find $(datadir)nurseCare.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)nurseCharting.csv)","")
	@echo "Unable to find $(datadir)nurseCharting.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)pastHistory.csv)","")
	@echo "Unable to find $(datadir)pastHistory.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)patient.csv)","")
	@echo "Unable to find $(datadir)patient.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)physicalExam.csv)","")
	@echo "Unable to find $(datadir)physicalExam.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)respiratoryCare.csv)","")
	@echo "Unable to find $(datadir)respiratoryCare.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)respiratoryCharting.csv)","")
	@echo "Unable to find $(datadir)respiratoryCharting.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)treatment.csv)","")
	@echo "Unable to find $(datadir)treatment.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalAperiodic.csv)","")
	@echo "Unable to find $(datadir)vitalAperiodic.csv - exiting before build."; exit 1
endif
ifeq ("$(wildcard $(datadir)vitalPeriodic.csv)","")
	@echo "Unable to find $(datadir)vitalPeriodic.csv - exiting before build."; exit 1
endif
	@echo 'All data present!'

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
	$(DBEXEC) < duckdb_create_tables.sql
	@echo ''
	@echo '------------------'
	@echo '-- Loading data --'
	@echo '------------------'
	@echo ''
	$(DBEXEC) -cmd ".cd '$(datadir)'" < duckdb_load_data.sql
	@echo '----------------'
	@echo '-- Check data --'
	@echo '----------------'
	@echo ''
	$(DBEXEC) < duckdb_checks.sql

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
	$(DBEXEC) < duckdb_create_tables.sql
	@echo ''
	@echo '-------------------------------------'
	@echo '-- Loading data from gzipped files --'
	@echo '-------------------------------------'
	@echo ''
	$(DBEXEC) -cmd ".cd '$(datadir)'" < duckdb_load_data_gz.sql
	@echo '----------------'
	@echo '-- Check data --'
	@echo '----------------'
	@echo ''
	$(DBEXEC) < duckdb_checks.sql

.PHONY: help eicu
