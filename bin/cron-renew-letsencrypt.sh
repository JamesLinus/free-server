#!/bin/bash

source /opt/.global-utils.sh
echo "6 50 *  * 1 root ${freeServerRoot}/renew-letsencrypt" > /etc/cron.d/renew_letsencrypt