#!/usr/bin/env bash

source /opt/.global-utils.sh


echoS "Cleanup Memory"

forever stop ${miscDir}/testing-web.js
pkill -ef ^ocserv
killProcessesByPattern server.py
pkill ^nghttpx

killall squid3
squid3 -z
squid3 -f ${SPDYSquidConfig} -k kill