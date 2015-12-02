#!/bin/bash

source /opt/.global-utils.sh

forever stop ${freeServerRootMisc}/testing-web.js
forever start ${freeServerRootMisc}/testing-web.js
