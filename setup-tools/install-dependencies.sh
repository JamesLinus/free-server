#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installDeps
}

installDeps() {
   echoS "Installing Dependencies"
   apt-get install -y trickle 2>&1 >> ${loggerStdoutFile}
}


main "$@"





