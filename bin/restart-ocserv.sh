#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "Usage: $0"

  exit 0
fi

if [[ ! -f ${SPDYSSLKeyFile} ]]; then
  echoS "The SSL Key file ${key} is not existed. Exit" "stderr"
  exit 0
fi


if [[ ! -f ${SPDYSSLCertFile} ]]; then
  echoS "The SSL cert file ${cert} is not existed. Exit" "stderr"
  exit 0
fi

# set iptable to connecto Internet
ipt=/sbin/iptables
sysctl --quiet -w net.ipv4.ip_forward=1
$ipt -F FORWARD
$ipt -P FORWARD DROP
$ipt -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
$ipt -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
$ipt -A FORWARD -i vpns+ -o eth0 -j ACCEPT
$ipt -A FORWARD -i vpns+ -o vpns+ -j ACCEPT

$ipt -t nat -F POSTROUTING
$ipt -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# kill and start
pkill ocserv
ocserv -c ${ocservConfig}
