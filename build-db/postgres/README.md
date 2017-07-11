# Create eICU Collaborative Research Database with Postgres

This folder loads the eICU Collaborative Research Database into a local PostgreSQL database system. Before you can create this version, you need to first need to download the CSV tables from PhysioNet.

## Instructions for use

First ensure that Postgres is running on your computer. For installation instructions, see: [http://www.postgresql.org/download/](http://www.postgresql.org/download/)

Once Postgres is installed, clone the [eicu-code](https://github.com/mit-eicu/eicu-code) repository into a local directory using the following command:

``` bash
git clone https://github.com/mit-eicu/eicu-code.git
```

Change to the ```postgres/``` directory and use ```make``` to run the Makefile, which contains instructions for creating eICU in a local Postgres database. For instructions on using the Makefile, run the following command:

``` bash
make help
```

For example, to create the database from a set of zipped CSV files in the "/path/to/data/" directory, run the following command:

``` bash
make eicu datadir="/path/to/data/"
```
