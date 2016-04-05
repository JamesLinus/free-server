#!/bin/bash

source /opt/.global-utils.sh

## file to write to cron.d
file="/etc/cron.d/free-server-reboot-daily"

## restart daily
restartCommand="/sbin/shutdown -r now"

## restart process every day at 5am
echo "5 21 * * * root ${restartCommand}" >> ${file}

echo "Done, cat ${file}"
cat ${file}

## restart crond
service cron restart
echo "Crontab restart, new PID: $(pgrep cron)"