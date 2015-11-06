#!/bin/bash

source /root/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echo -e "Restarting all shadowsocks ss-server instances" | wall
pkill ss-server

for i in $(find ${configDir} -name "ss-*.json"); do
  echo "Process $i"
  /usr/bin/ss-server -c "$i" > /dev/null 2>&1 &
done


