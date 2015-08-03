#!/bin/bash

source ${freeServerRoot}/utils/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PASSWORD PORT"
  exit 0
fi

password=$1
port=$2

# both password and port should be given

( [[ -z "${password}" ]] || [[ -z "${port}" ]] ) && echoSExit "you should invoke me via \`$0 PASSWORD PORT \`. Neither PORT or PASSWORD could be omitted."

# check port available 

checkPortAvailable=$(cat ${configShadowsocks}  | grep "\"${port}\"")

if [[ ! -z "${checkPortAvailable}" ]]; then
        echoSExit "Port $port is already used. Exit."
fi

# writing to shadowsocks config file
insertLineToFile ${configShadowsocks} "port_password" "\"$port\":\"$password\","

echoS "Shadowsocks account created. \n  \
Port: ${port} \n  \
Password: ${password}"


