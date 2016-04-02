#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installOcserv

}

installOcserv() {
    cd ${freeServerRootTmp}
    wget ftp://ftp.infradead.org/pub/ocserv/ocserv-0.9.2.tar.xz
    tar -xf ocserv-0.9.2.tar.xz
    cd ocserv-0.9.2
    apt-get install -y build-essential pkg-config libgnutls28-dev libwrap0-dev libpam0g-dev libseccomp-dev libreadline-dev libnl-route-3-dev
    ./configure && make && make install
}

linkBinUtilAsShortcut() {
	ln -s ${utilDir}/restart-dead-ocserv.sh ${freeServerRoot}/restart-dead-ocserv
	ln -s ${utilDir}/createuser-ocserv.sh ${freeServerRoot}/createuser-ocserv
	ln -s ${utilDir}/restart-ocserv.sh ${freeServerRoot}/restart-ocserv
	ln -s ${utilDir}/renew-letsencrypt.sh ${freeServerRoot}/renew-letsencrypt
	ln -s ${utilDir}/deleteuser-ocserv.sh ${freeServerRoot}/deleteuser-ocserv
	ln -s ${utilDir}/cron-ocserv-forever-process-running-generate-cron.d.sh ${freeServerRoot}/cron-ocserv-forever-process-running-generate-cron.d
}

main "$@"





