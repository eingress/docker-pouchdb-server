#!/bin/sh

. lib.sh

# Creates a new user with a random password

PASS_LENGTH=16

if [ "$1" = "" ]; then
  echo "Usage: add-user [name]"
  exit 1
else
  USER="$1"
  PASS=$(random_pass ${PASS_LENGTH})
fi

OK=$(
  curl \
    -s \
    -X PUT \
    -H "Content-Type: application/json" \
    -d "{\"_id\":\"org.couchdb.user:$USER\",\"name\":\"$USER\",\"type\":\"user\",\"roles\":[],\"password\":\"$PASS\"}" \
    127.0.0.1:5984/_users/org.couchdb.user:"${USER}" |
    json_value ok
)

if [ "$OK" = "true" ]; then
  echo "Added user: ${USER}"
  echo "Password: ${PASS}"
else
  echo ${OK:-"No changes, ${USER} already exists."}
  exit 1
fi

exit 0
