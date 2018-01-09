#!/bin/bash
if [ -z ${DBPASS+x} ]; then
  echo "DBPASS is unset";
  exit 1
else
  echo "DBPASS is set";
fi

if [ -z ${DBNAME+x} ]; then
  DBNAME=eicu
  echo "DBNAME is unset, using default '$DBNAME'";
else
  echo "DBNAME is set to '$DBNAME'";
fi

if [ -z ${DBUSER+x} ]; then
  DBUSER=postgres
  echo "User is unset, using default '$DBUSER'";
else
  echo "User is set to '$DBUSER'";
fi

PSQL='psql'

# add in the host/port, if they were specified (not null, -n)
# omitted the "+x" so we treat an empty string as equivalent to unset variable
if [ -n "${DBHOST}" ]; then
  echo "Adding DBHOST ${DBHOST}"
  PSQL=$PSQL' -h '$DBHOST
fi

if [ -n "${DBPORT}" ]; then
  echo "Adding DBPORT ${DBPORT}"
  PSQL=$PSQL' -p '$DBPORT
fi

if hash gosu 2>/dev/null; then
   SUDO='gosu postgres'
else
   SUDO='sudo -u postgres'
fi

# check if SUDO is needed by checking if we can login with postgres without it
err2=`psql postgres postgres -c "select 1;" 2>&1 >/dev/null`

if [[ $err2 == *"Peer authentication failed for user"* ]]; then
  # we need to call sudo every time for postgres
  echo 'Not logged in as postgres user. Script will require sudo.'

  echo "*** Ignore any warnings of the form: 'could not change directory to...' ***"
  echo "These indicate you are running the script in a folder that the postgres user does not have access to."
  echo "The script will still work - so these warnings can be safely ignored."

  PSQL=$SUDO' '$PSQL
fi

# step 1) create user, if needed
if [ "$DBUSER" != "postgres" ]; then
    # we need to create this user via postgres
    if $PSQL -U postgres -d postgres -t -c '\du' | cut -d \| -f 1 | grep -qw $DBUSER; then
      echo "User already exists. Not recreating user."
    else
      $PSQL -U postgres -d postgres -c "CREATE USER $DBUSER WITH PASSWORD '$DBPASS';"
    fi
fi

if [ "$DBNAME" != "postgres" ]; then
  # drop and recreate the database
  $PSQL -U postgres -d postgres -c "DROP DATABASE IF EXISTS $DBNAME;"
  $PSQL -U postgres -d postgres -c "CREATE DATABASE $DBNAME OWNER $DBUSER;"
fi

# create the schema on the database
$PSQL -U postgres -d $DBNAME -c "CREATE SCHEMA $DBSCHEMA AUTHORIZATION $DBUSER;"
