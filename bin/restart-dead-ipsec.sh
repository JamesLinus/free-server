#!/bin/bash

source /root/.global-utils.sh

${freeServerRoot}/forever-process-running.sh "libexec\/ipsec" "ipsec restart"
