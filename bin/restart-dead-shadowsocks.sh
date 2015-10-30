#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

shadowsocksConfigList=$(find ${configDir} -name "ss-*.json")

for i in ${shadowsocksConfigList}; do
  isProcessRunning=$(ps aux | awk '$0~v' v="-c\\ ${i}")
  if [[ -z ${isProcessRunning} ]]; then
    wall -n "Restart ss-server with $i"
    /usr/bin/ss-server -c "$i" > /dev/null 2>&1 &
  else
    echo "Skipped $i since it is already stated. Process: ${isProcessRunning}"
  fi

done


