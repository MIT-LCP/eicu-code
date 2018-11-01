# Create eICU Collaborative Research Database with Postgres

This folder loads the eICU Collaborative Research Database into a local PostgreSQL database system. Before you can create this version, you need to first need to download the CSV tables from PhysioNet.

## Instructions for use

First ensure that Postgres is running on your computer. For installation instructions, see: [http://www.postgresql.org/download/](http://www.postgresql.org/download/)

Once Postgres is installed, clone the [eicu-code](https://github.com/mit-lcp/eicu-code) repository into a local directory using the following command:

``` bash
git clone https://github.com/mit-lcp/eicu-code.git
```

Change to the ```postgres/``` directory and use ```make``` to run the Makefile, which contains instructions for creating eICU in a local Postgres database. For instructions on using the Makefile, run the following command:

``` bash
make help
```

### Download data
``` bash
physionetuser=<PHYSIONETUSER> make eicu-download datadir=<DATA_PATH>
```

### Check data exists

Check all of the required files exists.
If the files are gzipped check with the following command -
``` bash
make eicu-check-gz datadir=<DATA_PATH>
```

If the files are not compressed check with -
``` bash
make eicu-check datadir=<DATA_PATH>
```

### Create the user/database/schema (optional)

Runs the `create_eicu_user.sh` script which creates user, database and schema using the environment variables for DBUSER, DBPASS, DBSCHEMA and DBNAME. The default database name, schema, user, password, etc. are defined at the beginning of the Makefile.

``` bash
make initialize
```

If you would like to specify a value (e.g. your own user name for the user), you can do so by adding the environment variable set as you would like; e.g.:

```bash
make initialize DBUSER=myusername DBPASS=mypassword
```

Note that you will need to continually pass these settings to the subsequent make commands, otherwise the build will fail.

### Build Database

Build the database in 4 phases -
1. Create tables
2. Loads data
3. Add indices
4. Validate

To load gzipped data use -
``` bash
make eicu-gz datadir=<DATA_PATH>
```

To load non-compressed data -
``` bash
make eicu datadir=<DATA_PATH>
```

## Suggested flow

Assuming postgres is already installed and running

1. Download data
``` bash
make eicu-download physionetuser=<PYSIONETUSER> datadir=<DATA_PATH>
```
2. Create user, database and schema -
``` bash
make initialize
```
3. Build database -
``` bash
make eicu-gz datadir=<DATA_PATH>
```
