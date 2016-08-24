#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

cd ${shadowsocksRFolder}

shadowsocksRConfigList=$(find ${configDir} -name "ssr-*.json")

for i in ${shadowsocksRConfigList}; do
  isProcessRunning=$(ps aux | awk '$0~v' v="-c\\ ${i}")
  if [[ -z ${isProcessRunning} ]]; then
    echo -e "Restart SSR with $i" | wall
    python server.py -c ${i} -d restart
  else
    echo "Skipped $i since it is already stated. Process: ${isProcessRunning}"
  fi

done
