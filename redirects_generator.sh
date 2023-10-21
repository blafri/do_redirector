#!/bin/bash

CONFIGURATION_FILE_PATH=${1:-"./test_default.conf"}

IFS=',' read -ra RAW_REDIRECTS <<< ${REDIRECTS:-""}

for raw_redirect in "${RAW_REDIRECTS[@]}"; do
  IFS='>' read -ra DATA <<< $raw_redirect

  FROM=${DATA[0]}
  TO=${DATA[1]}

  if ! [[ $FROM =~ ^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$ ]]; then
    echo "Invalid domain $FROM" 1>&2
    exit 1
  fi

  if ! [[ $TO =~ ^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$ ]]; then
    echo "Invalid domain $TO" 1>&2
    exit 1
  fi

  echo "Create a redirect for $FROM to $TO"

  cat >> $CONFIGURATION_FILE_PATH << EOF
server {
    listen 80;
    server_name $FROM;
    return 302 https://$TO\$request_uri;
}
EOF
done
