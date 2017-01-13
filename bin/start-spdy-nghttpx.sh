#!/bin/bash

source /opt/.global-utils.sh

port=$1

main() {
  showHelp
  commonCheck
  startNgHttpX
}

showHelp() {
  if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
  then
    echo "Usage: $0 FRONTEND_LISTEN_PORT"

    exit 0
  fi
}

commonCheck() {
  if [[ ! -f ${SPDYConfig} ]]; then
    echoS "The SPDY config file ${SPDYConfig} is not found . Exit" "stderr"
    exit 1
  fi

  if [[ ! -f ${letsEncryptKeyPath} ]]; then
    echoS "The SSL Key file ${key} is not existed. Exit" "stderr"
    exit 1
  fi


  if [[ ! -f ${letsEncryptCertPath} ]]; then
    echoS "The SSL cert file ${cert} is not existed. Exit" "stderr"
    exit 1
  fi

  if [[ -z $port ]]; then
    echo "Usage: $0 FRONTEND_LISTEN_PORT"
    exit 1
  fi

}


startNgHttpX() {
  # Testing:
  # nghttpx --daemon --http2-proxy --frontend="0.0.0.0,25" --backend="localhost,3128" /root/free-server/config/SPDY.domain.key /root/free-server/config/SPDY.domain.crt
  # --cacert=${SPDYSSLCaPemFile} \
  # --errorlog-file="${loggerRuntimeErrFile}" \
  # --log-level="ERROR" \

  #  --workers=${SPDYNgHttpXCPUWorkerAmount} \


  trickle -u ${trickleUploadLimit} -d ${trickleDownloadLimit} nghttpx \
  --daemon \
  --http2-proxy \
  --no-via \
  --fastopen=3 \
  --frontend-http2-max-concurrent-streams=${SPDYNgHttpXConcurrentStreamAmount} \
  --frontend="${SPDYFrontendListenHost},${port}" \
  --backend="${SPDYForwardBackendSquidHost},${SPDYForwardBackendSquidPort}" \
  "${letsEncryptKeyPath}" "${letsEncryptCertPath}"

}

main "$@"