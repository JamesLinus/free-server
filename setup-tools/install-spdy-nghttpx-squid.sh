#!/bin/bash

source /opt/.global-utils.sh

main() {
  getSpdySslKeyFile
  getSpdySslCertFile
#  getSpdySslCaPemFile
  installSpdyLay
  installNgHttpX
  linkBinUtilAsShortcut
  generateSquidConf
  linkSquid3DefaultConf
  installSquid
  linkSquid3DefaultConf

  squid3 -f /etc/squid3/squid.conf  -k reconfigure
  sleep 2
  pkill squid3
  sleep 2

}

getSpdySslKeyFile() {
  if [[ -f ${SPDYSSLKeyFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY/HTTP2 SSL Key file detected in ${SPDYSSLKeyFileInConfigDirBackup}. Skip generating." "stderr"
    return 0
  fi
  echoS "Input the file (with path) of your HTTPS/SSL PRIVATE KEY file : \n\n\
  (You could generate your own from https://letsencrypt.org/)"


  key=$(getUserInput "Input \x1b[46m HTTPS SSL PRIVATE KEY \x1b[0m absolute path (e.g. /etc/letsencrypt/live/DOMAIN/privkey.pem): " file 3)

  if [[ ! -f ${key} ]]; then

    echoErr "HTTPS/SSL PRIVATE KEY file is required for installation of SPDY/HTTP2 server."

  else

    echoS "Selected key file is ${key}"
    echoS "Copy Key ${key} to ${configDir}"
    cp ${key} ${SPDYSSLKeyFile}

  fi


}

getSpdySslCertFile() {
  if [[ -f ${SPDYSSLCertFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY/HTTP2 SSL Cert file detected in ${SPDYSSLCertFileInConfigDirBackup}. Skip generating." "stderr"
    return 0
  fi

  cert=$(getUserInput "Input \x1b[46m HTTPS SSL CERTIFICATE \x1b[0m absolute path (e.g. /etc/letsencrypt/live/DOMAIN/fullchain.pem): " file 3)


  if [[ ! -f ${cert} ]]; then

    echoErr "HTTPS/SSL Cert file is required for installation of SPDY/HTTP2 server."

  else

    echoS "Selected cert file is ${cert}"
    echoS "Copy Cert ${cert} to ${configDir}"

    cp ${cert} ${SPDYSSLCertFile}

  fi

}


getSpdySslCaPemFile() {
  if [[ -f ${SPDYSSLCaPemFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY/HTTP2 SSL CA Pem file detected in ${SPDYSSLCaPemFileInConfigDirBackup}. Skip generating." "stderr"
    return 0
  fi
  echoS "Input the file (with path) of your SSL Ca pem file"

  caPem=$(getUserInput "Input \x1b[46m ca.pem \x1b[0m file absolute path (e.g. /root/ssl/sub.class1.server.ca.pem): " file 3)

  if [[ ! -f ${caPem} ]]; then

    echoErr "SSL CA Pem file  (ca.pem) is required for installation of SPDY/HTTP2 server."

  else

    echoS "Selected ca.pem file is ${caPem}"
    echoS "Copy Key ${caPem} to ${configDir}"

    cp ${caPem} ${SPDYSSLCaPemFile}

  fi

}


installSpdyLay() {

  echoS "Install SpdyLay"
  #npm install -g spdyproxy > /dev/null 2>&1
  catchError=$(apt-get install -y autoconf automake \
  autotools-dev libtool pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libevent-dev \
   2>&1 >> ${loggerStdoutFile})
  exitOnError "${catchError}"

  rm -rf ${SPDYSpdyLayTarGzName}
  rm -rf ${SPDYSpdyLayFolderName}

  echoS "Downloading ${SPDYSpdyLayDownloadLink}"

  wget ${SPDYSpdyLayDownloadLink} >> /dev/null 2>&1
  echoS "Installing, may need 5 minutes..."
  warnNoEnterReturnKey

  catchError=$(tar zxf ${SPDYSpdyLayTarGzName} 2>&1 >> ${loggerStdoutFile})
  exitOnError "${catchError}"

  cd ${SPDYSpdyLayFolderName}/
  autoreconf -i >> /dev/null \
    && automake >> /dev/null \
    && autoconf >> /dev/null \
    && ./configure >> /dev/null \
    && make >> /dev/null \
    && make install \
     >> /dev/null

  ldconfig

  cd ..
  rm -rf ${SPDYSpdyLayTarGzName}
  rm -rf ${SPDYSpdyLayFolderName}

}

installNgHttpX() {

  echoS "Install NgHttpX"
  #npm install -g spdyproxy > /dev/null 2>&1
  catchError=$(apt-get install -y g++ make binutils autoconf automake autotools-dev libtool pkg-config   \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev   \
  libjemalloc-dev cython python3-dev python-setuptools apache2-utils -y 2>&1 >> ${loggerStdoutFile})
  exitOnError "${catchError}"

  warnNoEnterReturnKey

  rm -rf ${SPDYNgHttp2FolderName}
  rm -rf ${SPDYNgHttp2TarGzName}

  echoS "Downloading ${SPDYNgHttp2DownloadLink}"

  wget ${SPDYNgHttp2DownloadLink} >> /dev/null 2>&1

  catchError=$(tar zxf ${SPDYNgHttp2TarGzName} 2>&1 >> ${loggerStdoutFile})
  exitOnError "${catchError}"

  cd ${SPDYNgHttp2FolderName}/
  echoS "Installing, may need 5 minutes..."
  warnNoEnterReturnKey

  autoreconf -i >> /dev/null \
    && automake >> /dev/null \
    && autoconf >> /dev/null \
    && ./configure >> /dev/null \
    && make >> /dev/null \
    && make install \
     >> /dev/null

  ldconfig

  cd ..
  rm -rf ${SPDYNgHttp2FolderName}
  rm -rf ${SPDYNgHttp2TarGzName}

}

generateSquidConf() {
  # SPDYSquidConfig
  replaceStringInFile ${SPDYSquidConfig} FREE_SERVER_BASIC_HTTP_AUTH_PASSWD_FILE ${SPDYSquidPassWdFile}
  replaceStringInFile ${SPDYSquidConfig} SQUID_AUTH_PROCESS ${SPDYSquidAuthSubProcessAmount}
  touch ${SPDYSquidPassWdFile}
  chown proxy.proxy ${SPDYSquidPassWdFile}
  touch ${SPDYConfig}
}


installSquid() {

  mkdir -p $SPDYSquidCacheDir

  chmod -R 777 $SPDYSquidCacheDir

  echoS "Install Squid, may need 5 minutes."

  catchError=$(apt-get install squid -y 2>&1 >> ${loggerStdoutFile})
  exitOnError "${catchError}"

}

linkBinUtilAsShortcut() {
  ln -s ${utilDir}/createuser-spdy-nghttpx-squid.sh ${freeServerRoot}/createuser-spdy-nghttpx-squid
  ln -s ${utilDir}/restart-spdy-nghttpx-squid.sh ${freeServerRoot}/restart-spdy-nghttpx-squid
  ln -s ${utilDir}/start-spdy-nghttpx.sh ${freeServerRoot}/start-spdy-nghttpx
  ln -s ${utilDir}/restart-spdy-squid.sh ${freeServerRoot}/restart-spdy-squid
  ln -s ${utilDir}/restart-dead-spdy-nghttpx-squid.sh ${freeServerRoot}/restart-dead-spdy-nghttpx-squid
  ln -s ${utilDir}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d.sh \
    ${freeServerRoot}/cron-spdy-nghttpx-squid-forever-process-running-generate-cron.d
}

linkSquid3DefaultConf() {
    config=/etc/squid3/squid.conf
    mkdir -p /etc/squid3
    touch $config
    rm $config
    ln -s ${SPDYSquidConfig} /etc/squid3/squid.conf
}

main "$@"

#EOF