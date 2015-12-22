#!/bin/bash

source /opt/.global-utils.sh

${utilDir}/forever-process-running.sh "libexec\/ipsec" "ipsec restart"
