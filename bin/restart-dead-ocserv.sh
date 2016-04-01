#!/bin/bash

source /opt/.global-utils.sh

runCommandIfPortClosed "443" "${freeServerRoot}/restart-ocserv;  echo \"Restart Cisco AnyConnect VPN (ocserv)\""
