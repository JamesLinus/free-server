#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0"

  exit 0
fi
echoS "Restart SPDY Squid3"
pkill squid3
squid3 -f ${SPDYSquidConfig} -k kill
pkill squid3
sleep 2
squid3 -f ${SPDYSquidConfig}
squid3 -f ${SPDYSquidConfig} -k reconfigure