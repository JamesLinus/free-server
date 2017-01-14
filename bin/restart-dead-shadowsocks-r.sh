#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

cd ${shadowsocksRFolder}

shadowsocksRConfigList=$(find ${configDir} -name "ssr-*.json")

for configFile in ${shadowsocksRConfigList}; do
  isProcessRunning=$(ps aux | awk '$0~v' v="-c\\ ${configFile}")
  if [[ -z ${isProcessRunning} ]]; then
    echo -e "Restart SSR with $configFile" | wall
    trickle -v -s -u ${trickleUploadLimit} -d ${trickleDownloadLimit}  python server.py -c ${configFile} >> /dev/null 2&>1 &

  else
    echo "Skipped $i since it is already stated. Process: ${isProcessRunning}"
  fi

done
