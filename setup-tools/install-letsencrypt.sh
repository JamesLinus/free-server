#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installLetsencrypt
    prepareLetEncryptEnv
    getCert
    afterLetEncryptEnv
    enableAutoRenew
}

installLetsencrypt() {
    echoS "Installing git"
    catchError=$(apt-get install git 2>&1 >> ${loggerStdoutFile})
    exitOnError "${catchError}"

    git config --global user.name "Free Server"
    git config --global user.email "${freeServerUserEmail}"
    cd ${letsencryptInstallationFolder}
    git clone https://github.com/letsencrypt/letsencrypt ./
    ./letsencrypt-auto --help
}

getCert() {
    eval "${letsencryptAutoPath} certonly --standalone --email ${freeServerUserEmail} -d ${freeServerName} --non-interactive"
}

enableAutoRenew() {
    echo "6 50 *  * 1 root ~/renew_letsencrypt.sh" > /etc/cron.d/renew_letsencrypt
    # run for first time
}

main "$@"





