#!/usr/bin/env bash

source ~/.global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

# restart service daily
echo -e "#!/bin/bash\n\n${freeServerRoot}/restart-shadowsocks" > /etc/cron.daily/restart-shadowsocks
chmod +x /etc/cron.daily/restart-shadowsocks

echo -e "#!/bin/bash\n\n${freeServerRoot}/restart-spdy" > /etc/cron.daily/restart-spdy
chmod +x /etc/cron.daily/restart-spdy

# smart service watcher for every 2 minutes
echo -e "*/2 * * * * root ${freeServerRoot}/restart-dead-shadowsocks" > /etc/cron.d/restart-dead-shadowsocks

echo -e "*/2 * * * * root ${freeServerRoot}/restart-dead-spdy" > /etc/cron.d/restart-dead-spdy

# restart cron service
service cron restart