#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi


for i in $(find ${configDir} -name "ss-*.json"); do
  if [[ -z $(ps aux | grep "$i") ]]; then
    wall -n "Restart ss-server with $i"
    /usr/bin/ss-server -c "$i" > /dev/null 2>&1 &
  else
    echo "Skipped $i since it is already stated."
  fi

done


