#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT"
  exit 0
fi

port=$1

cfg=${configDir}/ssr-${port}.json

shadowsocksRConfigList=$(find ${configDir} -name "ssr-*.json")

for i in ${shadowsocksRConfigList}; do

  if [[ "${i}" != "${cfg}" ]];then
      continue
  fi

  python server.py -c ${i} -d stop
  rm -y $cfg

done
