#!/bin/bash

source /opt/.global-utils.sh

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
 && echoS "You should invoke me via \`$0 Username Pass ShadowsocksPort SPDYPort\`. All arguments could not be omitted." "stderr" && exit 0

${freeServerRoot}/createuser-shadowsocks "${shadowsocksPort}" "${pass}"
#${freeServerRoot}/createuser-spdy "${user}" "${pass}" "${SPDYPort}"
${freeServerRoot}/createuser-spdy-nghttpx-squid "${user}" "${pass}" "${SPDYPort}"
#${freeServerRoot}/createuser-ipsec "${user}" "${pass}"
${freeServerRoot}/createuser-ocserv "${user}" "${pass}"

echoS "All done. HTTP2/SPDY, Shadowsocks, Cisco AnyConnect VPN account has been created for user $user"