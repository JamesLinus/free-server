#!/usr/bin/env bash

source /opt/.global-utils.sh

main() {
 copyConf
}

copyConf() {
    cp -r ${configSampleDir}/* ${configDir}/
}

main "$@"



