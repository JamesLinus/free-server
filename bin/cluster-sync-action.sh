#!/bin/bash

source /root/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

echoS "This script is going to sync a cluster of free-servers via rsync and restart the whole cluster on sync end"

echoS "This script assume you have run \x1b[46m ${freeServerRoot}/cluster-deploy-ssh-mutual-auth \
to deploy SSH mutual login to cluster servers \x1b[0m"

