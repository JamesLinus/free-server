#!/bin/bash

source ~/global-utils.sh

if [ "x$1" = "x-h" -o "x$1" = "x--help" ]
then
  echo "${utilDir}/restart-spdy.sh"
  exit 0
fi
#
#wall -n Restarting SPDY proxy
#kill $(ps aux | grep '[s]pdyproxy' | awk '{print $2}')
#${utilDir}/start-spdy.sh /home/ec2-user/spdy/config.txt
#/usr/local/bin/forever --slient --spinSleepTime 10000 start /home/ec2-user/fakewebsite/fake.js
#service openvpn restart
#service mysqld stop
#service httpd stop
#service php-fpm stop
#service nginx stop


