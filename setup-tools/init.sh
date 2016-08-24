#!/usr/bin/env bash

source /opt/.global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

/bin/bash ${utilDir}/cron-reboot-daily-generate-cron.d.sh  2>&1 >> ${loggerStdoutFile}

catchError=$(/bin/bash ${utilDir}/cron-renew-letsencrypt.sh  2>&1 >> ${loggerStdoutFile})

# smart service watcher for every 2 minutes
catchError=$(/bin/bash ${utilDir}/cron-shadowsocks-r-forever-process-running-generate-cron.d.sh  2>&1 >> ${loggerStdoutFile})

#catchError=$(${freeServerRoot}/cron-ipsec-forever-process-running-generate-cron.d 2>&1 >> ${loggerStdoutFile})
catchError=$(/bin/bash ${utilDir}/cron-ocserv-forever-process-running-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

catchError=$(/bin/bash ${utilDir}/cron-ocserv-renew-route-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

#${freeServerRoot}/cron-spdy-forever-process-running-generate-cron.d
catchError=$(/bin/bash ${utilDir}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

/bin/bash ${utilDir}/cron-misc-forever-process-running-generate-cron.d.sh

# restart cron service
catchError=$(service cron restart 2>&1 >> ${loggerStdoutFile})

#echoS "Restart Shadowsocks/SPDY/IPSec"
echoS "Restart ShadowsocksR/SPDY/Cisco AnyConnect"

#${freeServerRoot}/restart-ipsec
${freeServerRoot}/restart-ocserv

${freeServerRoot}/restart-shadowsocks-r

#${freeServerRoot}/restart-spdy
${freeServerRoot}/restart-spdy-nghttpx-squid

echoS "Create a simple website for testing purpose."

npm install -g forever

${utilDir}/restart-misc.sh

#EOF