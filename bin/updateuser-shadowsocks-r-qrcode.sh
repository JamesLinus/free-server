#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 PORT PASSWORD [ENCRYPT_METHOD] [OBFUSCATE_METHOD] [PROTOCOL_METHOD]"
  echo "https://github.com/breakwa11/shadowsocks-rss/blob/master/ssr.md"
  echo "."
  echo "$0 20457 Y&Ysk003"
  echo "$0 20857 Po@kdkwo^ aes-256-cfb http_simple auth_sha1"
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


# both password and port should be given

( [[ -z "${password}" ]] || [[ -z "${port}" ]] ) && echoSExit "you should invoke me via \`$0 PASSWORD PORT \`. \
 None of the parameters could be omitted." "stderr" \
 && exit 0

cd ${freeServerRoot}

./deleteuser-shadowsocks-r ${port}

./createuser-shadowsocks-r ${port} ${password} ${encrypt} ${obfuscate} ${protocol} ${obfuscateParam} ${protocolParam}