#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

wall -n "Restarting shadowsocks ss-redir"
pkill ss-redir

for i in $(find ${configDir} -name "*.json"); do
    setsid /usr/bin/ss-server -c "$i" > /dev/null 2>&1
done
#setsid /usr/bin/ss-server -c ${configShadowsocks} > /dev/null 2>&1
#setsid /usr/bin/ss-server -c /root/free-server/config/config-swlsf.json > /dev/null 2>&1

