#!/bin/bash

source /opt/.global-utils.sh


if [[ -z $freeServerName ]]; then
    echoS "freeServerName is empty. Stop renewing Let's Encrypt Cert." "stderr"
    exit 1
fi


if [[ ! -f $letsEncryptCertPath ]]; then
    echoS "[Let's Encrypt] $letsEncryptCertPath is not a file" "stderr"
    exit 1
fi

if [[ ! -f $letsEncryptKeyPath ]]; then
    echoS "[Let's Encrypt] $letsEncryptKeyPath is not a file" "stderr"
    exit 1
fi


if [[ ! -f $letsencryptAutoPath ]]; then
    echoS "[Let's Encrypt] $letsencryptAutoPath is not a file" "stderr"
    exit 1
fi

echoS "Start to Renew Let's Encrypt Cert."

prepareLetEncryptEnv

certLog=$(eval "$letsencryptAutoPath renew")
echo $certLog
certSkip=$(echo $certLog | grep "/fullchain.pem (skipped)")

if [ $? -ne 0 ]
 then
        ERRORLOG=`tail /var/log/letsencrypt/renew.log`
        echo -e "The Lets Encrypt Cert has not been renewed! \n \n" $ERRORLOG | mail -s "Lets Encrypt Cert Alert" lanshunfang.oracle@gmail.com
elif [[ -z $certSkip ]]
 then
        rm $SPDYSSLCertFile
        cp $letsEncryptCertPath $SPDYSSLCertFile
        rm $SPDYSSLKeyFile
        cp $letsEncryptKeyPath $SPDYSSLKeyFile
        killall nghttpx
        /opt/free-server/restart-spdy-nghttpx-squid
fi

afterLetEncryptEnv


exit 0