#!/usr/bin/env bash

source ~/.global-utils.sh

wget -qO- http://shadowsocks.org/debian/1D27208A.gpg | sudo apt-key add -

removeLineInFile /etc/apt/sources.list shadowsocks

echo "deb http://shadowsocks.org/debian wheezy main" >>  /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install shadowsocks-libev -y

# prepare all Shadowsocks Utils
ln -s ${utilDir}/createuser-shadowsocks.sh ${freeServerRoot}/createuser-shadowsocks
ln -s ${utilDir}/deleteuser-shadowsocks.sh ${freeServerRoot}/deleteuser-shadowsocks
ln -s ${utilDir}/restart-shadowsocks.sh ${freeServerRoot}/restart-shadowsocks
ln -s ${utilDir}/restart-dead-shadowsocks.sh ${freeServerRoot}/restart-dead-shadowsocks
ln -s ${utilDir}/cron-shadowsocks-forever-process-running-generate-cron.d.sh ${freeServerRoot}/cron-shadowsocks-forever-process-running-generate-cron.d

## create first shadowsocks account
#tmpPort=40000
#tmpPwd=`randomString 8`
#${freeServerRoot}/createuser-shadowsocks ${tmpPort} ${tmpPwd}  > /dev/null
#echoS "First Shadowsocks account placeholder created, with Port ${tmpPort} and Password ${tmpPwd}. \n \
#You should not remove the placeholder since it's used by script ${freeServerRoot}/createuser-shadowsocks"
