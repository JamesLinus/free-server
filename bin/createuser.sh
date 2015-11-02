#!/bin/bash

source ~/.global-utils.sh

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
 && echoS "You should invoke me via \`$0 Username Pass ShadowsocksPort SPDYPort\`. All arguments could not be omitted." && exit 0

${freeServerRoot}/createuser-shadowsocks "${shadowsocksPort}" "${pass}"
${freeServerRoot}/createuser-spdy "${user}" "${pass}" "${SPDYPort}"
${freeServerRoot}/createuser-ipsec "${user}" "${pass}"

echoS "All done. Shadowsocks and SPDY account has been created for user $user"