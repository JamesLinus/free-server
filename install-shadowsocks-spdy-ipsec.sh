#!/bin/bash

clear

export bashUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/
export self="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$0"

cd ~
# prepare global functions
rm ./.global-utils.sh
wget --no-cache ${bashUrl}/utils/.global-utils.sh
source ~/.global-utils.sh

enforceInstallOnUbuntu

if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi

echoS "apt-get update and install required tools"
apt-get update -y >> /dev/null
apt-get install -y gawk  >> /dev/null
apt-get install -y curl  >> /dev/null


echoS "Init Env"


if [ -d ${freeServerRoot} ]; then
    echoS "Old free-server installation detected. Back up config files and clean up the folder in 5 seconds.\
     Press Ctrl+C to cancel"
    sleep 5

    echoS "Removing Old free-server installation"

    # restore backed up config files
    if [ -d ~/config-bak$(appendDateToString) ]; then
        echoS "Old backed up config files found in ~/${configDir}$(appendDateToString). \
        This is not correct. You should move it to other place or just delete it before proceed. Exit"
        exit 0
    fi

    # move current config files to a save place if has

    mv ${configDir} ~/config-bak$(appendDateToString)

    rm -rf ${freeServerRoot}

fi

echoS "Create Folder scaffold"

wget --no-cache -qO- ${baseUrlSetup}/init-folders.sh | /bin/bash


echoS "Getting and processing utility package"

downloadFileToFolder ${bashUrl}/setup-tools/download-files.sh ${freeServerRootTmp}
/bin/bash ${freeServerRootTmp}/download-files.sh

echoS "Installing NodeJS and NPM"

${freeServerRootTmp}/install-node.sh > /dev/null

echoS "Installing and initing Shadowsocks"

${freeServerRootTmp}/install-shadowsocks.sh > /dev/null

echoS "Installing SPDY Proxy"

${freeServerRootTmp}/install-spdy.sh

echoS "Installing IPSec/IKEv2 VPN (for IOS)"

${freeServerRootTmp}/install-ipsec-ikev2.sh

echoS "Cleaning up env"

${freeServerRootTmp}/init.sh

# restore backed up config files
if [ -d ~/config-bak$(appendDateToString) ]; then
    cp -r ${configDir}/* ~/config-bak$(appendDateToString)
    rm -rf ${configDir}
    mv ~/config-bak$(appendDateToString) ${configDir}
    echoS "Restart Shadowsocks and SPDY"
    ${freeServerRoot}/restart-shadowsocks
    ${freeServerRoot}/restart-spdy
fi

echoS "All done. Create user example: \n\n\
Shadowsocks+SPDY+IPSec: ${freeServerRoot}/createuser User Pass ShadowsocksPort SPDYPort \n\n\
Shadowsocks Only: ${freeServerRoot}/createuser-shadowsocks Port Pass \n\n\
SPDY Only: ${freeServerRoot}/createuser-spdy User Pass Port \n\n\
IPSec Only: ${freeServerRoot}/createuser-ipsec User Pass \n\n\
"
# remove self
rm "$self"

if [[ ! -f ${ipsecSecFileBakQuericy} ]]; then
    echoS "\n\n\
    One more step: Please edit test IPSec Account/PSK in\n\n\
     ${ipsecSecFile} after server test pass in your iOS device"
fi




