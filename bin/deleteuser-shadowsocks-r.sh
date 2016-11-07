#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT"
  exit 0
fi

port=$1

if [[ -z ${port} ]]; then
  echoS "$0 PORT"
  exit 1
fi

cfg=${configDir}/ssr-${port}.json

shadowsocksRConfigList=$(find ${configDir} -name "ssr-*.json")

for i in ${shadowsocksRConfigList}; do

  if [[ "${i}" != "${cfg}" ]];then
      continue
  fi

  cd ${shadowsocksRFolder}
  python server.py -c ${i} -d stop
  rm -y $cfg

  echoS "Shadowsocks R deleted for ${port}"

done
