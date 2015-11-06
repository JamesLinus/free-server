#!/bin/bash

source /root/.global-utils.sh

## file to write to cron.d
file="/etc/cron.d/forever-process-running-spdy"

## process restart daily command
restartCommand="${freeServerRoot}/restart-spdy"

## write watching process every 5 minutes
echo "*/2 * * * * root ${freeServerRoot}/restart-dead-spdy" > ${file}

## restart process every day at 5am
echo "5 5 * * * root ${restartCommand}" >> ${file}

echo "Done, cat ${file}"
cat ${file}

## restart crond
service cron restart
echo "Crontab restart, new PID: $(pgrep cron)"