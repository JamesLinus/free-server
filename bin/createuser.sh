#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0 Username Pass ShadowsocksPort SPDYPort"
  exit 0
fi

user=$1
pass=$2
shadowsocksPort=$3
SPDYPort=$4

# both password and port should be given

( [[ -z "${user}" ]] || [[ -z "${pass}" ]] || [[ -z "${shadowsocksPort}" ]] || [[ -z "${SPDYPort}" ]] ) \
 && echoSExit "You should invoke me via \`$0 Username Pass ShadowsocksPort SPDYPort\`. All arguments could not be omitted."

${freeServerRoot}/createuser-shadowsocks ${pass} ${shadowsocksPort}
${freeServerRoot}/createuser-spdy ${user} ${pass} ${shadowsocksPort}

echoS "All done. Shadowsocks and SPDY account has been created for user $user"