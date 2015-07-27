#!/bin/bash

utilDir=~/free-server/

bashrc=~/.bashrc
bashUrl=http://www.xiaofang.me
bashUrlInstallDir=${bashUrl}/wp-content/uploads/ftp/free-server/

echoS(){
  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"
  echo "##"
  echo "## $1"
  echo "##"

  echo "***********++++++++++++++++++++++++++++++++++++++++++++++++++***********"

}

randomString()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

echoS "Initialing env"

mkdir -p ${utilDir}

echoS "Installing Shadowsocks"

wget -O- http://shadowsocks.org/debian/1D27208A.gpg | sudo apt-key add -
sed -i.old  -E "/shadowsocks/d"   /etc/apt/sources.list
echo "deb http://shadowsocks.org/debian wheezy main" >>   /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install shadowsocks-libev -y

echoS "Getting and processing utility package"

wget ${bashUrlInstallDir}/createUserShadowsocks.sh ${utilDir}
wget ${bashUrlInstallDir}/globals.sh ${utilDir}
source ${utilDir}/globals.sh

echoS "Getting shadowsocks config file template and set it to bashrc"

sed -i.old  -E "/config_shadowsocks/d" ${bashrc}

source ${bashrc}
mv ${config_shadowsocks} ${config_shadowsocks}.bak
wget ${bashUrlInstallDir}/config.json -O ${config_shadowsocks}

echoS "Cleaning up env and start up everything"
# set executable for all shell scripts
chmod -R +x *.sh

# create first shadowsocks account
tmpPort=40000
tmpPwd=`randomString 8`
${utilDir}/createUserShadowsocks.sh ${tmpPort} ${tmpPwd} > /dev/null
echoS "First Shadowsocks account placeholder created, with Port ${tmpPort} and Password ${tmpPwd}. \n \
You should not remove the placeholder since it's used by script ${utilDir}/createUserShadowsocks.sh"

