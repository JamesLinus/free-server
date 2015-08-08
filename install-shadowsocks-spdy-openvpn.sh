#!/bin/bash

export bashUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/

randomString()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

cd ~
# prepare global functions
rm ./global-utils.sh
wget --no-cache ${bashUrl}/utils/global-utils.sh
source ~/global-utils.sh

echoS "Init Env"

replaceLineInFile ${globalUtilFile} "bashUrl=" "export bashUrl=$bashUrl"
replaceLineInFile ${bashrc} "freeServerRoot=" "export freeServerRoot=$freeServerRoot"
sudo apt-get update -y

echoS "Getting and processing utility package"

wget --no-cache -qO- ${bashUrl}/setup-tools/download-files.sh | /bin/bash > /dev/null

echoS "Installing NodeJS and NPM"

${freeServerRootTmp}/install-node.sh > /dev/null

echoS "Installing and initing Shadowsocks"

${freeServerRootTmp}/install-shadowsocks.sh > /dev/null

echoS "Installing SPDY Proxy"

${freeServerRootTmp}/install-spdy.sh > /dev/null

echoS "Cleaning up env"

#rm -rf ${freeServerRootTmp}

echoS "Start up Shadowsocks ss-redir"
${freeServerRoot}/restart-shadowsocks > /dev/null

