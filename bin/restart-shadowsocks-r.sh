#!/bin/bash

source /opt/.global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "$0"
  exit 0
fi

cd ${shadowsocksRFolder}

echo -e "Restarting all shadowsocks-R instances" | wall
killProcessesByPattern server.py
python server.py -d stop

for i in $(find ${configDir} -name "ssr-*.json"); do
  echo "Process $i"
#  /usr/bin/ss-server -c "$i" > /dev/null 2>&1 &
#    python server.py -p 27000 -k pass -m aes-256-cfb --obfs=tls1.2_ticket_auth_compatible --protocol=auth_sha1_v2_compatible --fast-open
  python server.py -c ${i} -d restart
done


