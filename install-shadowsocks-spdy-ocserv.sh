#!/bin/bash

clear

if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi

export bashUrl=https://raw.githubusercontent.com/lanshunfang/free-server/master/
export self="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$0"

# get global utils
globalUtilStoreDir=/opt
mkdir -p ${globalUtilStoreDir}
chmod 755 ${globalUtilStoreDir}
cd ${globalUtilStoreDir}
# prepare global functions
rm -f .global-utils.sh
wget --no-cache ${bashUrl}/utils/.global-utils.sh
source .global-utils.sh

enforceInstallOnUbuntu

# stop accepting client locale setting for Ubuntu
replaceStringInFile "/etc/ssh/sshd_config" AcceptEnv "\#AcceptEnv"
service sshd restart

echoS "apt-get update and install required tools"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo LC_CTYPE=\"en_US.UTF-8\" > /etc/default/locale
echo LC_ALL=\"en_US.UTF-8\" >> /etc/default/locale
echo LANG=\"en_US.UTF-8\" >> /etc/default/locale

apt-get install language-pack-en-base -y && locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales 2>&1 > /dev/null


# fix hostname -f
hostName=$(hostname)
hostNameF=$(hostname -f)
if [[ -z $hostNameF && ! -z $hostName ]]; then

    echo "127.0.1.1 ${hostName}" >> /etc/hosts
    echo "127.0.1.1 ${hostName}.local" >> /etc/hosts

fi

warnNoEnterReturnKey
apt-get update -y > /dev/null

catchError=$(apt-get install -y gawk 2>&1 > /dev/null)
exitOnError "${catchError}"

catchError=$(apt-get install -y curl 2>&1 > /dev/null)
exitOnError "${catchError}"

catchError=$(apt-get install -y git 2>&1 > /dev/null)
exitOnError "${catchError}"

echoS "Migrate obsolete installation"
cd ${globalUtilStoreDir}
rm -f migrate.sh

catchError=$(downloadFileToFolder ${baseUrlSetupTools}/migrate.sh ${globalUtilStoreDir}/ 2>&1  > /dev/null)
exitOnError "${catchError}"

chmod 755 ./migrate.sh
./migrate.sh

echoS "Init Env"
warnNoEnterReturnKey

if [[ -d ${freeServerRoot} ]]; then
    echoS "Old free-server installation detected. Script is going to perform Save Upgrading in 5 seconds.\
     Press Ctrl+C to cancel"

    echoS "If you want to perform fresh installation, just remove or rename ${freeServerRoot}"
    sleep 5

    echoS "Removing Old free-server installation"

    # restore backed up config files
    if [[ -d ${configDirBackup} ]]; then
        echoS "Old backed up config files found in ${configDirBackup} ${configDirBackupDate}. \
        This is not correct. You should move it to other place or just delete it before proceed. Exit"
        exit 0
    fi

    # clear up previous stdout/stderr file
    rm -f ${loggerStdoutFile}
    rm -f ${loggerStderrFile}

    rm -f ${configDir}/haproxy.conf
    rm -f ${configDir}/haproxy-user.conf
    rm -f ${configDir}/squid.conf
    rm -f ${configDir}/ocserv.conf
    rm -f ${configDir}/ocserv.xml

    # move current config files to a save place if has

    mv ${configDir} ${configDirBackup}
    # copy a another backup
    cp -nr ${configDirBackup} ${configDirBackupDate}

    rm -rf ${freeServerRoot}

fi


echoS "Create Folder scaffold"

wget --no-cache -qO- ${baseUrlSetupTools}/init-folders.sh | /bin/bash

echoS "Restore Config"


# restore backed up config files
if [ -d ${configDirBackup} ]; then
    rm -rf ${configDir}
    mv ${configDirBackup} ${configDir}
    source .global-utils.sh
fi


echoS "Get Global Settings"

if [[ -z $freeServerName ]]; then
    setServerName
    source .global-utils.sh
fi

if [[ -z $freeServerUserEmail ]]; then
    setEmail
    source .global-utils.sh
fi

# clear all old crontab
rm -f /etc/cron.d/forever-process-running-*
rm -f /etc/cron.d/renew_letsencrypt
rm -f /etc/cron.d/free-server*
service cron restart 2>&1 > /dev/null


echoS "Getting and processing utility package"
warnNoEnterReturnKey

#downloadFileToFolder ${bashUrl}/setup-tools/download-files.sh ${freeServerRootTmp}
#chmod 755 ${freeServerRootTmp}/download-files.sh
#${freeServerRootTmp}/download-files.sh || exit 1

echoS "Git Cloning project"
cd ${gitRepoPath}
rm -rf ${gitRepoFreeServerPath}
git clone https://github.com/lanshunfang/free-server.git

find ./ -name "*.sh" | xargs chmod +x
cd free-server
git add .
git commit -m "chmod"


#echoS "Installing NodeJS and NPM"
#warnNoEnterReturnKey
#${setupToolsDir}/install-node.sh || exit 1

echoS "Copy Config samples"
${setupToolsDir}/copy-conf.sh || exit 1

echoS "Installing Dependencies"
${setupToolsDir}/install-dependencies.sh || exit 1

echoS "Installing Let's Encrypt"
${setupToolsDir}/install-letsencrypt.sh || exit 1

echoS "Installing and initialing Shadowsocks-R"
warnNoEnterReturnKey

${setupToolsDir}/install-shadowsocks-r.sh || exit 1

echoS "Installing SPDY Proxy"
warnNoEnterReturnKey

#${setupToolsDir}/install-spdy.sh
${setupToolsDir}/install-spdy-nghttpx-squid.sh || exit 1

#echoS "Installing IPSec/IKEv2 VPN (for IOS)"
#${setupToolsDir}/install-ipsec-ikev2.sh || exit 1

#echoS "Installing Cisco AnyConnect (Open Connect Ocserv)"
#${setupToolsDir}/install-ocserv.sh || exit 1

#echoS "Installing and Initiating Free Server Cluster for multiple IPs/Domains/Servers with same Login Credentials support"
#
#${setupToolsDir}/install-cluster.sh





echoS "Restart and Init Everything in need"

${setupToolsDir}/init.sh || exit 1

echoS "All done. Create user example: \n\n\
\
Shadowsocks-R+SPDY: ${binDir}/createuser.sh User Pass ShadowsocksPort SPDYPort \n\n\
\
Shadowsocks-R Only: ${binDir}/createuser-shadowsocks-r.sh Port Pass \n\n\
\
SPDY Only: ${binDir}/createuser-spdy-nghttpx-squid.sh User Pass Port \n\n\
\
"

echoS "\x1b[46m Next step: \x1b[0m\n\n\
1. Create a user: ${binDir}/createuser.sh USERNAME PASSWORD ShadowsocksRPort SPDYPort \n\n\
2. Config Chrome or other client. Tutorial is here: https://github.com/lanshunfang/free-server#how-to-setup-clients \n\n\
"

#echoS "Note that, the IpSec PSK(Secret) is located: \x1b[46m ${ipsecSecFile} \x1b[0m. You may want to reedit the PSK field."
# remove self
rm -f "$self"




