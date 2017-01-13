#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
    installDeps
}

installDeps() {
   apt-get install -y trickle 2>&1 >> ${loggerStdoutFile}
}


main "$@"





