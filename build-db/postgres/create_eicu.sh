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

echo ""

if hash gosu 2>/dev/null; then
   SUDO='gosu postgres'
else
   SUDO='sudo -u postgres'
fi

# err2 checks if we can login with postgres
err2=`psql postgres postgres -c "select 1;" 2>&1 >/dev/null`

if [[ $err2 == *"Peer authentication failed for user"* ]]; then
  # we need to call sudo every time for postgres
  echo 'Not logged in as postgres user. Script will require sudo.'
  PSQL=$SUDO' psql'
else
  PSQL='psql'
fi

# step 1) create user, if needed
if [ "$DBUSER" != "postgres" ]; then
    # we need to create this user via postgres
    if $PSQL postgres postgres -t -c '\du' | cut -d \| -f 1 | grep -qw $DBUSER; then
      echo "User already exists. Not recreating user."
    else
      $PSQL postgres postgres -c "CREATE USER $DBUSER WITH PASSWORD '$DBPASS';"
    fi
fi

if [ "$DBUSER" != "postgres" ]; then
  # drop and recreate the database
  $PSQL postgres postgres -c "DROP DATABASE IF EXISTS $DBNAME;"
  $PSQL postgres postgres -c "CREATE DATABASE $DBNAME OWNER $DBNAME;"
fi

# create the schema on the database
$PSQL $DBNAME postgres -c "CREATE SCHEMA $DBSCHEMA AUTHORIZATION $DBUSER;"
