#!/usr/bin/env bash

source ~/global-utils.sh

ln -s ${utilDir}/createuser.sh ${freeServerRoot}/createuser

echoS "Write to crontab for auto restart"

# restart service daily
echo -e "#!/bin/bash\n\n${freeServerRoot}/restart-shadowsocks" > /etc/cron.daily/restart-shadowsocks
chmod +x /etc/cron.daily/restart-shadowsocks

# restart service daily
echo -e "*/2 * * * * ${freeServerRoot}/restart-dead-shadowsocks" > /etc/cron.d/restart-dead-shadowsocks
chmod +x /etc/cron.d/restart-dead-shadowsocks


