#!/usr/bin/env bash

source ~/.global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

# smart service watcher for every 2 minutes
${freeServerRoot}/cron-shadowsocks-forever-process-running-generate-cron.d > /dev/null
${freeServerRoot}/cron-ipsec-forever-process-running-generate-cron.d > /dev/null
#${freeServerRoot}/cron-spdy-forever-process-running-generate-cron.d
${freeServerRoot}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d > /dev/null

# restart cron service
service cron restart  > /dev/null

echoS "Restart Shadowsocks/SPDY/IPSec"

${freeServerRoot}/restart-ipsec  > /dev/null
${freeServerRoot}/restart-shadowsocks > /dev/null
#${freeServerRoot}/restart-spdy
${freeServerRoot}/restart-spdy-nghttpx-squid > /dev/null