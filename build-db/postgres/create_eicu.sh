#!/bin/bash

if psql -t -c '\du' | cut -d \| -f 1 | grep -qw $DBUSER; then
  echo "User already exists."
else
  psql postgres -c "CREATE USER $DBUSER WITH PASSWORD '$DBPASS'"
fi

psql postgres -c "DROP DATABASE IF EXISTS $DBNAME"
psql postgres -c "CREATE DATABASE $DBNAME OWNER $DBUSER"


PGPASSWORD=$DBPASS psql -U $DBUSER -c "DROP SCHEMA IF EXISTS $DBSCHEMA"
PGPASSWORD=$DBPASS psql -U $DBUSER -c "CREATE SCHEMA $DBSCHEMA AUTHORIZATION $DBUSER"
