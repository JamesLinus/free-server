#!/usr/bin/env bash

source /root/.global-utils.sh

wget -qO- http://shadowsocks.org/debian/1D27208A.gpg | apt-key add -

removeLineInFile /etc/apt/sources.list shadowsocks

echo "deb http://shadowsocks.org/debian wheezy main" >>  /etc/apt/sources.list

ubuntu14=$(isUbuntu14)
if [[ "${ubuntu14}" == "YES" ]]; then
#  removeLineInFile /etc/apt/sources.list "wheezy-backports"
#  echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list
#  gpg --keyserver pgpkeys.mit.edu --recv-key 7638D0442B90D010
#  gpg -a --export 7638D0442B90D010 | sudo apt-key add -

  wget http://launchpadlibrarian.net/173841617/init-system-helpers_1.18_all.deb > /dev/null
  dpkg -i init-system-helpers_1.18_all.deb  > /dev/null
  rm -rf init-system-helpers_1.18_all.deb*  > /dev/null
fi

apt-get update -y > /dev/null
apt-get install shadowsocks-libev -y > /dev/null

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
