#!/bin/bash

utilDir=~/free-server/

source ${utilDir}/globals.sh

port=$1
password=$2

# both password and port should be given

( [[ -z "${password}" ]] || [[ -z "${port}" ]] ) && echoSExit "you should invoke me via \`$0 PORT PASSWORD\`. Neither PORT or PASSWORD could be omitted."

# check port available 

checkPortAvailable=$(cat ${config_shadowsocks}  | grep "\"${port}\"")

if [[ ! -z "${checkPortAvailable}" ]]; then
        echoSExit "Port $port is already used. Exit."
fi

# writing to shadowsocks config file
newline="\"$port\":\"$password\","
sed -i -e "/\"port_password\"/ a $newline" ${config_shadowsocks}

echoS "Shadowsocks account created. \n  \
Port: ${port} \n  \
Password: ${password}"


