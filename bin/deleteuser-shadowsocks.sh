#!/bin/bash

source ${freeServerRoot}/utils/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT"
  exit 0
fi

port=$1

# both password and port should be given

[[ -z "${port}" ]] && echoSExit "you should invoke me via \`$0 PORT \`. PORT could be omitted."

removeLineInFile ${configShadowsocks} "/\"$port\"/d"

echoS "Port $port is removed from Shadowsocks config files. You should manual restart shadowsocks to apply"
