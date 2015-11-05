#!/bin/bash

source ~/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0 FRONTEND_LISTEN_PORT"

  exit 0
fi

if [[ ! -f ${SPDYConfig} ]]; then
  echoS "The SPDY config file ${SPDYConfig} is not found . Exit"
  exit 0
fi

if [[ ! -f ${SPDYSSLKeyFile} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit"
  exit 0
fi


if [[ ! -f ${SPDYSSLCertFile} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit"
  exit 0
fi

echo -e "Start nghttpx: Username: ${username}, Port ${port} " | wall
# Testing:
# nghttpx --daemon --http2-proxy --frontend="0.0.0.0,25" --backend="localhost,3128" /root/free-server/config/SPDY.domain.key /root/free-server/config/SPDY.domain.crt
nghttpx \
--daemon \
--http2-proxy \
--http2-max-concurrent-streams=${SPDYNgHttpXConcurrentStreamAmount} \
--workers=${SPDYNgHttpXCPUWorkerAmount} \
--frontend="${SPDYFrontendListenHost},${port}" \
--backend="${SPDYForwardBackendSquidHost},${SPDYForwardBackendSquidPort}" \
"${SPDYSSLKeyFile}" "${SPDYSSLCertFile}"

