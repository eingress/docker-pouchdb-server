#!/bin/sh

. lib.sh

# Creates the first admin user with a random password
# One time only thing!

PASS_LENGTH=32

SERVER_URL='http://localhost:5984'
MESSAGE="Unauthorized, please login at ${SERVER_URL}/_utils/#login?"

if [ "$1" = "" ]; then
  echo "Usage: add-admin [name]"
  exit 1
else
  ADMIN_URL="${SERVER_URL}/_config/admins"
  USER="$1"
fi

if curl -s $ADMIN_URL | grep -q 'unauthorized'; then
  echo "${MESSAGE}"
  exit 1
else
  PASS=$(random_pass $PASS_LENGTH)
  OK=$(curl -s -X PUT "${ADMIN_URL}/${USER}" -d "\"${PASS}\"")

  if [ "$OK" = "\"\"" ]; then
    echo "Added admin: ${USER}"
    echo "Password: ${PASS}"
  else
    echo "${MESSAGE}"
  fi
fi

exit 0
