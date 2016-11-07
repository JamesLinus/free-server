#!/bin/bash

source /opt/.global-utils.sh

SPDYName=$1
SPDYPassword=$2
SPDYPort=$3

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 SPDYName SPDYPassword SPDYPort"
  exit 0
fi

if [[ -z ${SPDYName} || -z ${SPDYPassword} || -z ${SPDYPort} ]]; then
  echoS "$0 SPDYName SPDYPassword SPDYPort"
  exit 1
fi

removeLineInFile ${SPDYName},${SPDYPassword},${SPDYPort} ${SPDYConfig}

killProcessesByPort ${SPDYPort}

echoS "HTTP2/SPDY deleted for ${SPDYName}"
