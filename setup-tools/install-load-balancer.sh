#!/usr/bin/env bash

source /opt/.global-utils.sh

# clusterDefFilePath in /opt/.global-utils.sh

init() {
  installHaproxy
  linkConfig
}

installHaproxy() {
    rm /etc/default/haproxy
    rm /etc/haproxy/haproxy.cfg
    sudo add-apt-repository ppa:vbernat/haproxy-1.6 -y
    sudo apt-get update -y
    sudo apt-get install haproxy -y
}

linkConfig() {
  if [[ -f ${SPDYSSLKeyFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY/HTTP2 SSL Key file detected in ${SPDYSSLKeyFileInConfigDirBackup}. Skip generating." "stderr"
    return 0
  fi
	removeLineInFile /etc/default/haproxy CONFIG
	echo CONFIG=\"${configDir}/haproxy.conf\" >> /etc/default/haproxy
}

init "$@"
