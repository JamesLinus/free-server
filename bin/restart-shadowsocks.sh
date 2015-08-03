#!/bin/bash

source ${freeServerRoot}/utils/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

wall -n "Restarting shadowsocks ss-redir"
pkill ss-redir
setsid /usr/bin/ss-redir -c ${configShadowsocks} > /dev/null 2>&1

