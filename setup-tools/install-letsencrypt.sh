#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installLetsencrypt
    linkBinUtilAsShortcut
    prepareLetEncryptEnv
    getCert
    afterLetEncryptEnv
    enableAutoRenew
}

installLetsencrypt() {
    echoS "Installing git"
    catchError=$(apt-get install -y git 2>&1 >> ${loggerStdoutFile})
    exitOnError "${catchError}"

    git config --global user.name "Free Server"
    git config --global user.email "${freeServerUserEmail}"
    cd ${letsencryptInstallationFolder}

    echoS "Installing Let's Encrypt"
    git clone https://github.com/letsencrypt/letsencrypt ./ 2>&1 >> ${loggerStdoutFile}
    ./letsencrypt-auto --help --agree-tos 2>&1 >> ${loggerStdoutFile}


}

getCert() {
    eval "${letsencryptAutoPath} certonly --standalone --agree-tos yes --email ${freeServerUserEmail} -d ${freeServerName} --non-interactive --agree-tos"
}

enableAutoRenew() {
    echo "6 50 *  * 1 root ~/renew_letsencrypt.sh" > /etc/cron.d/renew_letsencrypt
    # run for first time
}

linkBinUtilAsShortcut() {

    ln -s ${utilDir}/renew-letsencrypt.sh ${freeServerRoot}/renew-letsencrypt

}

main "$@"





