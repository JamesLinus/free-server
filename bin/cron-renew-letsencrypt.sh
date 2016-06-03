#!/bin/bash

source /opt/.global-utils.sh
echo "10 21 *  * 1 root ${freeServerRoot}/renew-letsencrypt" > /etc/cron.d/renew_letsencrypt