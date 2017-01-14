#!/bin/bash

source /opt/.global-utils.sh

frontConfigList=$1

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
  if [[ ! -s ${SPDYConfig} ]]; then
    echoS "The SPDY config file ${SPDYConfig} is not found . Exit" "stderr"
    exit 1
  fi

  if [[ ! -s ${letsEncryptKeyPath} ]]; then
    echoS "The SSL Key file ${letsEncryptKeyPath} is not existed. Exit" "stderr"
    exit 1
  fi


  if [[ ! -s ${letsEncryptCertPath} ]]; then
    echoS "The SSL cert file ${letsEncryptCertPath} is not existed. Exit" "stderr"
    exit 1
  fi

  if [[ -z $frontConfigList ]]; then
    echo "Usage: $0 FRONTEND_LISTEN_CONFIG"
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
  #   --fastopen=3 \
  #   --no-via \

  pkill nghttpx

  startCommand="nghttpx \
  --workers=20 \
  --worker-read-rate=${nghttpxUploadLimit} \
  --worker-write-rate=${nghttpxDownloadLimit} \
  ${frontConfigList} \
  --daemon \
  --http2-proxy \
  --frontend-http2-max-concurrent-streams=${SPDYNgHttpXConcurrentStreamAmount} \
  --backend=\"${SPDYForwardBackendSquidHost},${SPDYForwardBackendSquidPort}\" \
  \"${letsEncryptKeyPath}\" \"${letsEncryptCertPath}\""

#  startCommond="nghttpx \
#  --daemon \
#  --http2-proxy \
#  --frontend=\"${SPDYFrontendListenHost},${port}\" \
#  --frontend-http2-max-concurrent-streams=${SPDYNgHttpXConcurrentStreamAmount} \
#  --backend=\"${SPDYForwardBackendSquidHost},${SPDYForwardBackendSquidPort}\" \
#  \"${letsEncryptKeyPath}\" \"${letsEncryptCertPath}\""

  echo ${startCommand}
  eval ${startCommand}

}

main "$@"