#!/usr/bin/env bash

source ~/.global-utils.sh

main() {
  getSpdySslKeyFile
  getSpdySslCertFile
  installSpdyLay
  installNgHttpX
  linkBinUtilAsShortcut
}

getSpdySslKeyFile() {
  if [[ -f ${SPDYSSLKeyFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY SSL Key file detected in ${SPDYSSLKeyFileInConfigDirBackup}. Skip generating."
    return 0
  fi
  echoS "For new installation: Input the file (with path) of your SSL Key file  (*.key) : \n\n(You could not use self-signed SSL cert. You could get \
a free copy from https://www.startssl.com/)\n"


  key=$(getUserInput "Input new \x1b[46m *.key \x1b[0m file absolute path (e.g. /root/mydomain.com.key): " file 3)

  echoS "Selected key file is ${key}"
  echoS "Copy Key ${key} to ${configDir}"

  cp ${key} ${SPDYSSLKeyFile}

}

getSpdySslCertFile() {
  if [[ -f ${SPDYSSLCertFileInConfigDirBackup} ]]; then
    echoS "Previous SPDY SSL Cert file detected in ${SPDYSSLCertFileInConfigDirBackup}. Skip generating."
    return 0
  fi

  cert=$(getUserInput "Input new \x1b[46m *.crt \x1b[0m file absolute path (e.g. /root/mydomain.com.crt): " file 3)

  echoS "Selected cert file is ${cert}"
  echoS "Copy Cert ${cert} to ${configDir}"

  cp ${cert} ${SPDYSSLCertFile}

}


installSpdyLay() {

  echoS "Install SpdyLay"
  #npm install -g spdyproxy > /dev/null 2>&1
  apt-get install autoconf automake \
  autotools-dev libtool pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libevent-dev \
  -y > /dev/null

  wget ${SPDYSpdyLayDownloadLink}
  tar zxf ${SPDYSpdyLayTarGzName} > /dev/null

  cd ${SPDYSpdyLayTarGzName}/
  autoreconf -i > /dev/null \
    && automake > /dev/null \
    && autoconf >/dev/null \
    && ./configure > /dev/null \
    && make > /dev/null \
    && make install \
    > /dev/null
  ldconfig

}

installNgHttpX() {

  echoS "Install NgHttpX"
  #npm install -g spdyproxy > /dev/null 2>&1
  apt-get install g++ make binutils autoconf automake autotools-dev libtool pkg-config   \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev   \
  libjemalloc-dev cython python3-dev python-setuptools apache2-utils -y > /dev/null

  wget ${SPDYNgHttp2DownloadLink}
  tar zxf ${SPDYNgHttp2TarGzName} > /dev/null

  cd ${SPDYNgHttp2TarGzName}/
  autoreconf -i > /dev/null \
    && automake > /dev/null \
    && autoconf >/dev/null \
    && ./configure > /dev/null \
    && make > /dev/null \
    && make install \
    > /dev/null
  ldconfig

}

generateSquidConf() {
  # SPDYSquidConfig
  replaceStringInFile ${SPDYSquidConfig} "FREE_SERVER_BASIC_HTTP_AUTH_PASSWD_FILE" ${SPDYSquidPassWdFile}
  replaceStringInFile ${SPDYSquidConfig} "SQUID_AUTH_PROCESS" ${SPDYSquidAuthSubProcessAmount}
}


installSquid() {

  echoS "Install Squid"
  apt-get install squid3 -y > /dev/null
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


main "$@"