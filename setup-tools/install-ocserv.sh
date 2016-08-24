#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installOcserv 2>&1  > /dev/null
    updateOcservConf
#    linkBinUtilAsShortcut


}

installOcserv() {
    cd ${gitRepoPath}

    wget ${ocservDownloadLink}
    tar -xf ${ocservTarGzName}
    cd ${ocservFolderName}

    apt-get install -y build-essential pkg-config libgnutls28-dev libwrap0-dev libpam0g-dev libseccomp-dev libreadline-dev libnl-route-3-dev
    ./configure && make && make install
}

main "$@"





