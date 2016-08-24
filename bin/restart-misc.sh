#!/bin/bash

source /opt/.global-utils.sh

forever stop ${miscDir}/testing-web.js
forever start ${miscDir}/testing-web.js
