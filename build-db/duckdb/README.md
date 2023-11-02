# Create eICU Collaborative Research Database with DuckDB

This folder loads the eICU Collaborative Research Database into a DuckDB database file. Before you can create this version, you need to first need to download the CSV tables from PhysioNet.

## Instructions for use

First ensure that DuckDB has been installed on your computer. For installation instructions, see: [https://duckdb.org/docs/installation/](https://duckdb.org/docs/installation/)

Once DuckDB is installed, clone the [eicu-code](https://github.com/mit-lcp/eicu-code) repository into a local directory using the following command:

``` bash
git clone https://github.com/mit-lcp/eicu-code.git
```

Change to the ```build-db/duckdb/``` directory and use ```make``` to run the Makefile, which contains instructions for creating eICU in a DuckDB database file. For instructions on using the Makefile, run the following command:

``` bash
make help
```

### Download data
``` bash
physionetuser=<PHYSIONETUSER> make eicu-download datadir=<DATA_PATH>
```

### Check data exists

Check all of the required files exists.
If the files are gzipped check with the following command

``` bash
make eicu-check-gz datadir=<DATA_PATH>
```

If the files are not compressed check with
``` bash
make eicu-check datadir=<DATA_PATH>
```

### Build Database

Build the database in 3 phases
1. Create tables
2. Loads data
4. Validate

To load gzipped data use
``` bash
make eicu-gz datadir=<DATA_PATH>
```

To load non-compressed data
``` bash
make eicu datadir=<DATA_PATH>
```

## Suggested flow

Assuming DuckDB is already installed and running

1. Download data
``` bash
make eicu-download physionetuser=<PYSIONETUSER> datadir=<DATA_PATH>
```
2. Build database
``` bash
make eicu-gz datadir=<DATA_PATH>
```
