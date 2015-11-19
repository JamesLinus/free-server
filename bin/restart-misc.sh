#!/bin/bash

source /opt/.global-utils.sh

forever start ${freeServerRootMisc}/testing-web.js
forever restart ${freeServerRootMisc}/testing-web.js
