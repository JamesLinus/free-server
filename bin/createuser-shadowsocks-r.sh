#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT PASSWORD [ENCRYPT_METHOD] [OBFUSCATE_METHOD] [PROTOCOL_METHOD] [OBFUSCATE_PARAM] [PROTOCOL_PARAM]"
  exit 0
fi

port=$1
password=$2
encrypt=$3

# https://github.com/breakwa11/shadowsocks-rss/blob/master/ssr.md
obfuscate=$4
protocol=$5

obfuscateParam=$6
protocolParam=$7

configFile="${configDir}/ssr-${port}.json"

# both password and port should be given

( [[ -z "${password}" ]] || [[ -z "${port}" ]] ) && echoSExit "you should invoke me via \`$0 PASSWORD PORT \`. \
 None of the parameters could be omitted." "stderr" \
 && exit 0

# check port available 

checkPortAvailable=$(ls ${configDir} | gawk "/ssr-${port}\./ {print $1}")

if [[ ! -z "${checkPortAvailable}" ]]; then
        echoS "Port $port is already used in file ${configDir}/ssr-${port}.json. Exit." "stderr"
        exit 0
fi

if [ -z ${encrypt} ]; then
  encrypt="aes-128-cfb"
fi

if [ -z ${obfuscate} ]; then
#  encrypt="http_simple"
  obfuscate="tls1.2_ticket_auth"
fi


if [ -z ${protocol} ]; then
#  encrypt="http_simple"
  protocol="auth_sha1_v2"
fi

if [ -z ${obfuscateParam} ]; then
#  encrypt="http_simple"
  obfuscateParam="s3.amazonaws.com"
fi

if [ -z ${protocolParam} ]; then
#  encrypt="http_simple"
  protocolParam=""
fi


# writing to shadowsocks config file
#insertLineToFile ${configShadowsocks} "port_password" "\"$port\":\"$password\","
echo -e "{ \n\
\"server\": \"0.0.0.0\",\n\
\"timeout\":60,\n\
\"server_port\":${port},\n\
\"password\":\"${password}\",\n\
\"protocol\":\"${protocol}\",\n\
\"protocol_param\":\"${protocolParam}\",\n\
\"obfs\":\"${obfuscate}\",\n\
\"obfs_param\":\"${obfuscateParam}\",\n\
\"fast_open\":true,\n\
\"redirect\":[\"awsmedia.s3.amazonaws.com:443\"],\n\
\"method\":\"${encrypt}\"\n \
}\
" > ${configFile}

python server.py -c ${configFile} -d restart

echoS "Shadowsocks-R account created. \n\
Port: ${port} \n\
Password: ${password} \n\
Obfuscate: ${obfuscate} \n\
Protocol: ${protocol} \n\
Encrypt: ${encrypt} \n\n\
Starting SSR instance...\
"