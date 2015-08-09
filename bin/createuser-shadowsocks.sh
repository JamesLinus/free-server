#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT PASSWORD ENCRYPT_METHOD"
  exit 0
fi

port=$1
password=$2
encrypt=$3

configFile="${configDir}/ss-${port}.json"

# both password and port should be given

( [[ -z "${password}" ]] || [[ -z "${port}" ]] ) && echoSExit "you should invoke me via \`$0 PASSWORD PORT \`. \
 None of the parameters could be omitted." \
 && exit 0

# check port available 

checkPortAvailable=$(ls ${configDir}  |gawk "/ss-${port}\./ {print $1}")

if [[ ! -z "${checkPortAvailable}" ]]; then
        echoS "Port $port is already used in file ${checkPortAvailable}. Exit."
        exit 0
fi

if [ -z ${encrypt} ]; then
  encrypt="aes-128-cfb"
fi

# writing to shadowsocks config file
#insertLineToFile ${configShadowsocks} "port_password" "\"$port\":\"$password\","
echo -e "{ \n\
\"server\": \"0.0.0.0\",\n\
\"timeout\":60,\n\
\"server_port\":${port},\n\
\"password\":\"${password}\",\n\
\"method\":\"${encrypt}\"\n \
}\
" > ${configFile}

echoS "Shadowsocks account created. \n\
Port: ${port} \n\
Password: ${password} \n\
Encrypt: ${encrypt} \n\n\
Starting ss-server instance...\
"

/usr/bin/ss-server -c ${configFile} > /dev/null 2>&1 &

