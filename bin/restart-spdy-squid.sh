#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0"

  exit 0
fi
echoS "Restart SPDY Squid3"
killall squid3
killall squid

squid3 -z

squid3 -f ${SPDYSquidConfig} -k kill
sleep 2

squid3 -f ${SPDYSquidConfig}
squid3 -f ${SPDYSquidConfig} -k reconfigure

cat /var/log/squid/cache.log
cat /var/log/squid3/cache.log