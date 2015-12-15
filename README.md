# free-server

Gain more freedom with my free-server for Chinese (mainland), Iranians, North Koreans, and the kind.

## News and Change logs

* 2015-12-15 [Bug] Important Fix: Now iPSec/nghttpx+Squid (HTTP2/SPDY)/Shadowsocks supports Amazon EC2 Ubuntu again.
* 2015-12-15 [Enhancement] Add Stderr Logging / Stdout Logging control to log files, and "Stop on Critical Error".

-------

* 2015-11-06 [Enhancement] Replace spdyproxy (NPM module) to nghttpx(C)+Squid.
* 2015-11-03 [Platform] Add support to Amazon EC2 Ubuntu 14.04.2 LTS. Tested pass with EC2 Singapore Data Center 
* 2015-11-02 Milestone: [Feature] Add IPSec for IOS devices
* 2015-10-30 Important fix: [Bug] fix restart dead processes bug 
  (for SPDY and Shadowsocks process healthy monitoring, tested passed on Ubuntu 15, Digital Ocean)

-------

* 2015-08-12 Testing passed on Digital Ocean Ubuntu Server 15
* 2015-08-10 Many datacenters of Linode are getting unstable due to China GFW policies. Digital Ocean or Amazon EC2 may be better candidates.
* 2015-08-10 Shadowsocks and SPDY installation is well tested on Linode Ubuntu 15 now.
* 2015-08-10 Will work on IPSec later

## Description

* This script is to assist you setup a Linux Server hosting proxy/VPN service of Shadowsocks, HTTP2/SPDY and IPSec, within Ubuntu Server 14/15.
* It has been tested on Amazon EC2 Ubuntu 14 / Digital Ocean Ubuntu 15 / Linode Ubuntu Server 15. It should be running well on all latest Ubuntu Server releases.

## Package installed
* node / npm / node-legacy
* Shadowsocks: shadowsocks-libev 
(deb http://shadowsocks.org/debian wheezy main)
* HTTP2/SPDY: nghttp2-1.4.0 + spdylay-1.3.2 + Squid3 (Ubuntu repo latest)
(https://github.com/tatsuhiro-t/nghttp2/releases/download/v1.4.0/nghttp2-1.4.0.tar.gz)
(https://github.com/tatsuhiro-t/spdylay/releases/download/v1.3.2/spdylay-1.3.2.tar.gz)
* IPSec (ikev2) 
* node forever (npm module)

## Installation

* You need to obtain a HTTPS SSL Certificate before you install HTTP2/SPDY server. Get one for free from [StartSSL](https://www.startssl.com/?app=12).
* Note that you can't use self-signed SSL cert. It must be issued by third-party authorities thanks to Chrome HTTP2/SPDY SSL validation.

```bash
rm -f install-shadowsocks-spdy-ipsec.sh
wget --no-cache -q https://raw.githubusercontent.com/lanshunfang/free-server/master/install-shadowsocks-spdy-ipsec.sh
bash install-shadowsocks-spdy-ipsec.sh
```

Note that, the script could be redeployed/reinstalled on your Ubuntu without worries on losing any old Shadowsocks, HTTP2/SPDY and iPSec account or password.
It backs them up if found any before execute re-installation.

## Create User

```bash
Shadowsocks+HTTP2/SPDY+IPSec: ${freeServerRoot}/createuser User Pass ShadowsocksPort SPDYPort

Shadowsocks Only: ${freeServerRoot}/createuser-shadowsocks Port Pass 

HTTP2/SPDY Only: ${freeServerRoot}/createuser-spdy-nghttpx-squid User Pass Port

IPSec Only: ${freeServerRoot}/createuser-ipsec User Pass
```

## How to setup clients

* All the pages are password protected. To get the password, pls email to lanshunfang#gmail.com with email title: "free-server password" (Auto respond)
* [HTTP2/SPDY (Chinese only)](http://www.xiaofang.me/2014/12/20/windowsmaclinux-%E4%BD%BF%E7%94%A8%E5%AE%88%E6%9C%9B%E6%97%A0%E5%A2%99%E8%AE%A1%E5%88%92%E7%9A%84-spdy-%E9%AB%98%E9%80%9F%E7%BF%BB%E5%A2%99%E8%AE%BE%E7%BD%AE/ "Chinese only")
* [Shadowsocks--Windows/Mac/Android (Chinese only)](http://www.xiaofang.me/2013/05/17/%E5%B0%8F%E6%96%B9%E6%97%A0%E5%A2%99%E8%AE%A1%E5%88%92%E5%9F%BA%E4%BA%8Eshadowsocks%E7%9A%84%E7%BF%BB%E5%A2%99%E5%AE%A2%E6%88%B7%E7%AB%AF%E8%AE%BE%E7%BD%AE/ "Chinese only")
* [Shadowsocks--OpenWRT Router (Chinese only)](http://www.xiaofang.me/2015/05/05/%E5%AE%88%E6%9C%9B%E6%97%A0%E5%A2%99%E8%AE%A1%E5%88%92%E5%AE%B6%E5%BA%AD%E4%BC%81%E4%B8%9Abeta1%E7%89%88-%E6%99%BA%E8%83%BD%E8%B7%AF%E7%94%B1%E5%99%A8%E6%9E%84%E5%BB%BA%E6%96%B9/ "Chinese only")
* [IPSec for iOS (Chinese only)](http://www.xiaofang.me/2015/11/06/%E3%80%90%E5%AE%88%E6%9C%9B%E6%97%A0%E5%A2%99%E3%80%91-iphone-ipad-%E4%B9%8B-ipsec-vpn-%E8%AE%BE%E7%BD%AE%EF%BC%88%E5%82%BB%E7%93%9C%E5%8C%96%E6%95%99%E7%A8%8B%EF%BC%89/ "Chinese only")


## Donation

* 如果你觉得这个程序促进了你的信息传播与资讯获取自由, 欢迎你考虑给小方一些捐赠, 5元/10元即可, 表示一下鼓励与安慰. 支付宝账号: lanshunfang#gmail.com (替换#为@), 小方会更加有力的响应需求的. 谢谢.

------

* Please consider donation to Paul so that he will be encouraged by your favor. Paypal: lanshunfang#gmail.com (replace # to @). Thank you :)

## More

* This script will add several crontab configurations to `/etc/cron.d` to monitor Shadowsocks / HTTP2 (nghttpx, squid) / iPSec / demo web server service status.
* For more stability, both Shadowsocks and HTTP2/SPDY are running in multiple instances, one per user, not single process.