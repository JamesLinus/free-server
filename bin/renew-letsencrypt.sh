#!/bin/bash

source /opt/.global-utils.sh

server=vpn.xiaofang.me

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
certPath=/etc/letsencrypt/live/$server/fullchain.pem
keyPath=/etc/letsencrypt/live/$server/privkey.pem

freeServerCert=/opt/free-server/config/SPDY.domain.crt
freeServerKey=/opt/free-server/config/SPDY.domain.key
/usr/local/bin/forever stop /opt/free-server/misc/testing-web.js
letsencryptPath=/root/letsencrypt/
cd $letsencryptPath
certLog=$(./letsencrypt-auto renew)
echo $certLog
certSkip=$(echo $certLog | grep "xiaofang.me/fullchain.pem (skipped)")

if [ $? -ne 0 ]
 then
        ERRORLOG=`tail /var/log/letsencrypt/renew.log`
        echo -e "The Lets Encrypt Cert has not been renewed! \n \n" $ERRORLOG | mail -s "Lets Encrypt Cert Alert" lanshunfang.oracle@gmail.com
elif [[ -z $certSkip ]]
 then
        rm $freeServerCert
        cp $certPath $freeServerCert
        rm $freeServerKey
        cp $keyPath $freeServerKey
        killall nghttpx
        /opt/free-server/restart-spdy-nghttpx-squid
        service nginx reload
fi
/usr/local/bin/forever start /opt/free-server/misc/testing-web.js

exit 0