#!/usr/bin/env bash

source ~/.global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

# smart service watcher for every 2 minutes
${freeServerRoot}/cron-shadowsocks-forever-process-running-generate-cron.d.sh
${freeServerRoot}/cron-ipsec-forever-process-running-generate-cron.d.sh
${freeServerRoot}/cron-spdy-forever-process-running-generate-cron.d.sh

# restart cron service
service cron restart