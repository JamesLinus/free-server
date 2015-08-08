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


if [ -d ${freeServerRoot} ]; then
    echoS "Old free-server installation detected. Back up config files and clean up the folder in 5 seconds.\
     Press Ctrl+C to cancel"
    sleep 5

    echoS "Removing Old free-server installation"

    # move current config files to a save place if has
    if [ -d ${configDir} ]; then
        mv ${configDir} ~/${configDir}$(appendDateToString)
    fi
    rm -rf ${freeServerRoot}

fi

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

# restore backed up config files
if [ -d ~/${configDir}$(appendDateToString) ]; then
    mv ~/${configDir}$(appendDateToString) ${configDir}
fi

#rm -rf ${freeServerRootTmp}

echoS "Start up Shadowsocks ss-redir"
${freeServerRoot}/restart-shadowsocks > /dev/null

