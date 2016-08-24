#!/bin/bash

source /opt/.global-utils.sh

${binDir}/forever-process-running.sh "libexec\/ipsec" "ipsec restart"
