#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echoS "This script is going to sync a cluster of free-servers via rsync and restart the whole cluster on sync end"

