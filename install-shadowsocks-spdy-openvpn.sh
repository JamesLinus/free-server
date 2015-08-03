#!/bin/bash

export bashUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/

randomString()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

# Initialing env
# folder should be empty
if [ "$(ls -A ${freeServerRoot})" ]; then
   echo "Folder ${freeServerRoot} should be empty. Exit";
   exit
fi

# prepare global functions
rm ./global-utils.sh -y
curl ${bashUrl}/utils/global-utils.sh | source

echoS "Init Env"

replaceLineInFile ${globalUtilFile} "bashUrl=" "export bashUrl=$bashUrl"
replaceLineInFile ${bashrc} "freeServerRoot=" "export freeServerRoot=$freeServerRoot"
sudo apt-get update -y > /dev/null

echoS "Getting and processing utility package"

curl ${bashUrl}/setup-tools/download-files.sh | sh > /dev/null

echoS "Installing NodeJS and NPM"

${freeServerRootTmp}/install-node.sh > /dev/null

echoS "Installing and initing Shadowsocks"

${freeServerRootTmp}/install-shadowsocks.sh > /dev/null

echoS "Installing SPDY Proxy"

${freeServerRootTmp}/install-spdy.sh > /dev/null

echoS "Cleaning up env"

rm -rf ${freeServerRootTmp}

echoS "Start up Shadowsocks ss-redir"
${freeServerRoot}/restart-shadowsocks > /dev/null

