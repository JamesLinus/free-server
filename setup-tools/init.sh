#!/usr/bin/env bash

source /opt/.global-utils.sh


echoS "Write to crontab for auto restart"

/bin/bash ${binDir}/cron-reboot-daily-generate-cron.d.sh  2>&1 >> ${loggerStdoutFile}

catchError=$(/bin/bash ${binDir}/cron-renew-letsencrypt.sh  2>&1 >> ${loggerStdoutFile})

# smart service watcher for every 2 minutes
catchError=$(/bin/bash ${binDir}/cron-shadowsocks-r-forever-process-running-generate-cron.d.sh  2>&1 >> ${loggerStdoutFile})

#catchError=$(${freeServerRoot}/cron-ipsec-forever-process-running-generate-cron.d 2>&1 >> ${loggerStdoutFile})
#catchError=$(/bin/bash ${binDir}/cron-ocserv-forever-process-running-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

#catchError=$(/bin/bash ${binDir}/cron-ocserv-renew-route-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

#${freeServerRoot}/cron-spdy-forever-process-running-generate-cron.d
catchError=$(/bin/bash ${binDir}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d.sh 2>&1 >> ${loggerStdoutFile})

/bin/bash ${binDir}/cron-misc-forever-process-running-generate-cron.d.sh

# restart cron service
catchError=$(service cron restart 2>&1 >> ${loggerStdoutFile})

#echoS "Restart Shadowsocks/SPDY/IPSec"
echoS "Restart ShadowsocksR/SPDY"

#${freeServerRoot}/restart-ipsec
#${binDir}/restart-ocserv.sh

${binDir}/restart-shadowsocks-r.sh

#${freeServerRoot}/restart-spdy
${binDir}/restart-spdy-nghttpx-squid.sh

echoS "Create a simple website for testing purpose."
#catchError=$(npm install -g forever 2>&1 >> ${loggerStdoutFile})

${binDir}/restart-misc.sh

#EOF