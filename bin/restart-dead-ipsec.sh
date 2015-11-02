#!/bin/bash

source ~/.global-utils.sh

${freeServerRoot}/forever-process-running.sh "libexec\/ipsec" "ipsec restart"
