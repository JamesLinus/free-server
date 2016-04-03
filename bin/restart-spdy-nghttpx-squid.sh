#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0"

  exit 0
fi

if [[ ! -f ${SPDYConfig} ]]; then
  echoS "The SPDY config file ${SPDYConfig} is not found . Exit" "stderr"
  exit 0
fi

if [[ ! -f ${letsEncryptKeyPath} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit" "stderr"
  exit 0
fi


if [[ ! -f ${letsEncryptCertPath} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit" "stderr"
  exit 0
fi

pkill nghttpx

${freeServerRoot}/restart-spdy-squid

${freeServerRoot}/restart-dead-spdy-nghttpx-squid

