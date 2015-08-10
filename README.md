# free-server

## Description

This script is to helping you setup a Shadowsocks, SPDY and OpenVPN server wihtin Linode Ubuntu.
Still in progress, not done yet.
Run me within Linode Ubuntu and all set.

## Installation

```bash
rm install-shadowsocks-spdy-openvpn.sh
wget --no-cache -q https://raw.githubusercontent.com/lanshunfang/free-server/master/install-shadowsocks-spdy-openvpn.sh
bash install-shadowsocks-spdy-openvpn.sh
```

Note that, the script could be redeploy/reinstall on your Ubuntu without worries on losing any Shadowsocks/SPDY account, password.
I back them up if found before re-installation.

## Create User
```bash
Shadowsocks+SPDY: ~/free-server/createuser User Pass ShadowsocksPort SPDYPort 

Shadowsocks Only: ~/free-server/createuser-shadowsocks Port Pass 

SPDY Only: ~/free-server/createuser-spdy User Pass Port 
```

## More

* This script will add several crontab configurations to monitor Shadowsocks / SPDY service running healthy.
* For more stability, both Shadowsocks and SPDY are running in multiple instances, one per user, not single process.