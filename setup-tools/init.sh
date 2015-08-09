#!/usr/bin/env bash

source ~/global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

# restart service daily
echo -e "#!/bin/bash\n\n${freeServerRoot}/restart-shadowsocks" > /etc/cron.daily/restart-shadowsocks
chmod +x /etc/cron.daily/restart-shadowsocks

echo -e "#!/bin/bash\n\n${freeServerRoot}/restart-spdy" > /etc/cron.daily/restart-spdy
chmod +x /etc/cron.daily/restart-spdy

# smart service watcher for every 2 minutes
echo -e "*/2 * * * * ${freeServerRoot}/restart-dead-shadowsocks" > /etc/cron.d/restart-dead-shadowsocks
chmod +x /etc/cron.d/restart-dead-shadowsocks
