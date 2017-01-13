# free-server

Gain more freedom with my free-server for Chinese (mainland), Iranians, North Koreans, and the kind.

* 'You shall know the truth, and the truth shall make you free. 你们必晓得真理, 真理必叫你们得自由' -- [John 8:32](http://cnbible.com/john/8-32.htm) 

## News and Change logs

* 2017-01-14 [Enhancement] Update nghttp2 to 1.18.1 and Spdylay to 1.4.0
* 2017-01-14 [Enhancement] Limit upload&download speed of each SPDY/Shadowsocks-r instance to 300KB/s
* 2016-11-07 [Feature] Add deleteuser.sh to support delete user in a handy way
* 2016-10-08 [BreakingChange] remove ocserv (Cisco AnyConnect VPN) since Potatso (ShadowsocksR) is working well in iPhone
* 2016-08-26 [Enhancement] replace Nodejs Static server to python
* 2016-08-24 [BreakingChange] replace Shadowsocks to Shadowsocks-R
* 2016-08-24 [Enhancement] Update nghttp2-1.13.0.
* 2016-04-15 [Warning] Paul has received some information that may be relevant to free-server from Chinese policeman.
I may delete this Github source code if I get pressure from government executive force.
Please consider fork to keep the free-server long living till the day of death of G,FW.

-------
* other change logs are archived to the bottom of the page

## Description

* This script is to assist you setup a Linux Server hosting proxy/VPN service of Shadowsocks-R, HTTP2/SPDY, within Ubuntu Server.
* It has been tested on Amazon EC2 Ubuntu 16/14 LTS. Should be running well on Digital Ocean Ubuntu 15 / Linode Ubuntu Server 15 
/ Ubuntu Server 16 LTS, as well as all major Ubuntu Server releases.

## Package installed

* [Let's Encrypt](https://letsencrypt.org/)
* [Shadowsocks-R](https://github.com/breakwa11/shadowsocks.git)
* [HTTP2/SPDY: nghttp2-1.18.1](https://github.com/nghttp2/nghttp2/releases/download/v1.18.1/nghttp2-1.18.1.tar.gz)
* [Spdylay-1.4.0](https://github.com/tatsuhiro-t/spdylay/releases/download/v1.4.0/spdylay-1.4.0.tar.gz)
* Squid3 (Ubuntu repo latest)
* Trickle

## Installation

```bash
rm -f install-shadowsocks-spdy-ocserv.sh
wget --no-cache -q https://raw.githubusercontent.com/lanshunfang/free-server/master/install-shadowsocks-spdy-ocserv.sh
bash install-shadowsocks-spdy-ocserv.sh
```

Note that, the script could be redeployed/reinstalled on your Ubuntu without worries on losing any old Shadowsocks-R and HTTP2/SPDY account or password.
It backs them up if found any before execute re-installation.

## Create User

```bash
# Assume you didn't change $freeServerRoot

# Shadowsocks-r+HTTP2/SPDY VPN: 
sudo /opt/free-server/git-repo/free-server/bin/createuser.sh User Pass ShadowsocksRPort SPDYPort

# e.g. 
sudo /opt/free-server/git-repo/free-server/bin/createuser.sh test1 test123 10000 10401

```

## How to setup clients

* All the pages are password protected. To get the password, pls email to lanshunfang#gmail.com with email title: "free-server password" (Auto respond)

* [HTTP2/SPDY (Chinese only)](http://www.xiaofang.me/2014/12/20/windowsmaclinux-%E4%BD%BF%E7%94%A8%E5%AE%88%E6%9C%9B%E6%97%A0%E5%A2%99%E8%AE%A1%E5%88%92%E7%9A%84-spdy-%E9%AB%98%E9%80%9F%E7%BF%BB%E5%A2%99%E8%AE%BE%E7%BD%AE/ "Chinese only")
* [Shadowsocks-R-Android (Chinese only)](http://www.xiaofang.me/2016/08/25/shadowsocks-r-android-%E5%B0%8F%E6%96%B9%E7%95%AA%E8%8C%84%E9%85%8D%E7%BD%AE/)
* [iPhone/iPad Potatso VPN (Shadowsocks-R) (Chinese only)](http://www.xiaofang.me/2016/08/23/iphoneipad-potatso-vpn-shadowsocks-%E7%95%AA%E8%8C%84%E9%85%8D%E7%BD%AE/)


## Delete User

```bash
# Assume you didn't change $freeServerRoot

# Shadowsocks-r+HTTP2/SPDY VPN: 
sudo /opt/free-server/git-repo/free-server/bin/deleteuser.sh User Pass ShadowsocksRPort SPDYPort

# e.g. 
sudo /opt/free-server/git-repo/free-server/bin/deleteuser.sh test1 test123 10000 10401

```

## Donation

* Please consider donation to Paul so that he will be encouraged by your favor. Paypal: lanshunfang#gmail.com (replace # to @). Thank you :)
* Or, use My [Vultr Promote link](http://www.vultr.com/?ref=7037187-3B) to support me

## More

* Each connection are limited to 300KB (configured in .global-utils.sh, trickleUploadLimit) by Trickle
* This script will take port 80 for showing the status of the server via HTML page; If you do not want port 80 be taken, 
please contact Paul <lanshunfang#gmail.com> for support.
* This script will add several crontab configurations to `/etc/cron.d` to monitor Shadowsocks-R / HTTP2 (nghttpx, squid) / demo web server service status.
* For more stability, both Shadowsocks-R, HTTP2/SPDY are all running in multiple instances, one per user, not as single process.

## Archived Change Logs

* 2016-04-02 [Milestone] Add OpenConnect Cisco AnyConnect VPN support for iOS, as substitution of IPSec.
* 2016-04-02 [Milestone] Add Let's Encrypt SSL Cert auto generation for SPDY and Open Connect
* 2016-04-02 [Enhancement] Update nghttpx to 1.9.1
* 2016-03-05 [Bug] Fix locale issue of perl
* 2015-12-30 [Enhancement] Update nghttpx to 1.6.0
* 2015-12-15 [Bug] Important Fix: Now iPSec/nghttpx+Squid (HTTP2/SPDY)/Shadowsocks supports Amazon EC2 Ubuntu again.
* 2015-12-15 [Enhancement] Add Stderr Logging / Stdout Logging control to log files, and "Stop on Critical Error".
* 2015-11-06 [Enhancement] Replace spdyproxy (NPM module) to nghttpx(C)+Squid.
* 2015-11-03 [Platform] Add support to Amazon EC2 Ubuntu 14.04.2 LTS. Tested pass with EC2 Singapore Data Center 
* 2015-11-02 Milestone: [Feature] Add IPSec for IOS devices
* 2015-10-30 Important fix: [Bug] fix restart dead processes bug 
  (for SPDY and Shadowsocks process healthy monitoring, tested passed on Ubuntu 15, Digital Ocean)
* 2015-08-12 Testing passed on Digital Ocean Ubuntu Server 15
* 2015-08-10 Many datacenters of Linode are getting unstable due to China GFW policies. Digital Ocean or Amazon EC2 may be better candidates.
* 2015-08-10 Shadowsocks and SPDY installation is well tested on Linode Ubuntu 15 now.
* 2015-08-10 Will work on IPSec later

## Roadmap

* Add expiration date for an account while creating an account

## License

MIT