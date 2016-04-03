#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installOcserv 2>&1  > /dev/null
    updateOcservConf
    linkBinUtilAsShortcut


}

installOcserv() {
    cd ${freeServerRootTmp}
    wget ftp://ftp.infradead.org/pub/ocserv/ocserv-0.9.2.tar.xz
    tar -xf ocserv-0.9.2.tar.xz
    cd ocserv-0.9.2
    apt-get install -y build-essential pkg-config libgnutls28-dev libwrap0-dev libpam0g-dev libseccomp-dev libreadline-dev libnl-route-3-dev
    ./configure && make && make install
}
updateOcservConf() {

    if [[ ! -f ${ocservConfig} ]]; then
        echoS "Ocserv config file (${ocservConfig}) is not detected. This you may not install it correctly. Exit." "stderr"
        exit 1
    fi

    replaceStringInFile "${ocservConfig}" __SSL_KEY_FREE_SERVER__ "${letsEncryptKeyPath}"
    replaceStringInFile "${ocservConfig}" __SSL_CERT_FREE_SERVER__ "${letsEncryptCertPath}"


}

linkBinUtilAsShortcut() {
	ln -s ${utilDir}/restart-dead-ocserv.sh ${freeServerRoot}/restart-dead-ocserv
	ln -s ${utilDir}/createuser-ocserv.sh ${freeServerRoot}/createuser-ocserv
	ln -s ${utilDir}/restart-ocserv.sh ${freeServerRoot}/restart-ocserv
#	ln -s ${utilDir}/deleteuser-ocserv.sh ${freeServerRoot}/deleteuser-ocserv
	ln -s ${utilDir}/cron-ocserv-forever-process-running-generate-cron.d.sh ${freeServerRoot}/cron-ocserv-forever-process-running-generate-cron.d
}

main "$@"





