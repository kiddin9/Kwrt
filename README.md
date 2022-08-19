#### 一Compile and customize exclusive firmware online in minutes: [supes.top](https://supes.top)
#### Support 150+ devices:
X86/64, Friendly NanoPi, R2S, R4S, R4SE, R5S, R2C, NEO3, PHICOMM N1, K2P, K3, Raspberry Pi 4B, 3B/3B+, 2B, DoorNet1, DoorNet2, Orange Pi R1 Plus, R1 Plus LTS, Redmi AX6, Xiaomi AX3600, Xiaomi AX9000, Redmi AX6S/Xiaomi AX3200, Redmi AC2100, Xiaomi AC2100, PHICOM K3, 360V6, Fanke Cloud, HIWIFI HC5962 (Xi Route 4, B70), HC5661A, HC5761A, HC5861B, Mi 4, Mi R3G, Mi R3P, newifi-d2 (new router 3), Xiaoyu XY-C5, Jingdouyun 2.0 (P&W R619AC), GL.iNet MT1300, AX1800, microuter-N300, MT300N V2 , Xiaomi CR660X(CR6606/CR6608/CR6609), Xiaomi 4A Gigabit Edition, Xiaomi R3G-v2, Xiaomi Youth Edition Nano, Thunderbolt timecloud, Youku yk-l2, Youhua wr1200js, Sunflower X3A, ASUS RT-ACRH17, RT-AC58u/RT-ACRH13, RT-ac85p, RT-n56u-b1, RT-AC88U, RT-AC1200, RT-AC1200 V2, NETGEAR R6220, R6260, R6120, R6700-v2, R6800, R6850, R6900- v2, R7450, wndr3700-v5, H1 Box, Shell Cloud P1, My Home Cloud lL Pro, x96 Max, Weijia Cloud V-Plus, Octopus Planet ZYXQ, GT-King, Odroid N2, MXQ Pro+, JD Cloud RE- SP-01B, Linksys WRT1200AC, WRT1900AC v1, WRT1900AC v2, WRT3200ACM, WRT1900ACS v1, WRT1900ACS v2, WRT32X, etc.

[1]: https://img.shields.io/badge/license-GPLV2-brightgreen.svg
[2]: /LICENSE
[3]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg
[4]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/pulls
[5]: https://img.shields.io/badge/Issues-welcome-brightgreen.svg
[6]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/issues/new
[7]: https://img.shields.io/github/v/release/hyird/Action-Openwrt
[8]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/releases
[10]: https://img.shields.io/badge/Contact-telegram-blue
[11]: https://t.me/opwrt
[12]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/actions/workflows/Openwrt-AutoBuild.yml/badge.svg
[13]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/actions

[![license][1]][2]
[![GitHub Stars](https://img.shields.io/github/stars/kiddin9/OpenWrt_x86-r2s-r4s.svg?style=flat-square&label=Stars)](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/kiddin9/OpenWrt_x86-r2s-r4s.svg?style=flat-square&label=Forks)](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/fork)
[![PRs Welcome][3]][4]
[![Issue Welcome][5]][6]
[![AutoBuild][12]][13]

<a href="https://t.me/opwrt" target="_blank">TG notification channel</a>
## 1. **特色**

+ Cutting edge, openwrt official openwrt-22.03 branch version, Kernel 5.15, is synchronized with the latest official source code.

+ The original is extremely pure, the firmware only includes basic Internet access functions by default, and online optional plug-ins are available in the background. The system upgrade does not lose plug-ins and configurations.

+ The self-built plug-in repository includes almost all open source plug-ins on the market, the plug-in library is updated daily, and the system automatically updates all installed plug-ins.

+ Customize exclusive firmware online through [supes.top](https://supes.top), without any professional knowledge, and generate it in one minute. It also supports github cloud compilation and local one-click compilation.

+ One-click OTA update firmware in the background, eliminating the need to find firmware, download firmware, upload firmware and other cumbersome operations for each firmware upgrade.

+ One-click to set the bypass route in the background, and one-click to switch IPv6.

+ Support online installation of Kmod kernel modules.

+ Refactored version of SSR-PLUS, intelligent DNS resolution at home and abroad, support DOH, Trojan-Go, etc.

+ Replace Uhttpd with Nginx, support reverse proxy; WebDAV and many other games.

+ Performance, friendliness, ease of use, plug-ins, and custom optimization for special domestic environments, etc., out of the box

+ Customized fresh material style new theme Edge

## 2. **firmware**

There are 3 ways to generate firmware: online customized generation, GitHub compilation, and localized compilation.

Either one can be selected for firmware generation as needed.

### 2.1 **Generate online**

Access [https://supes.top](https://supes.top) through a browser to customize the firmware, and download and use it directly after the firmware is generated.

### 2.2 **GitHub compilation**

+ Fork the repository

+ Add relevant environment parameters REPO_TOKEN, SCKEY, TELEGRAM_CHAT_ID as needed

+ On the Actions page, select Repo Dispatcher and click Run workflow
### 2.3 **GitHub compiles with browser plugins**
Please install the [script](https://greasyfork.org/scripts/407616-github-actions-trigger/code/Github%20Actions%20Trigger.user.js) in a browser that supports oil monkey, the upper right corner of the repository will appear x86_64 Actions, K2P Actions and other buttons, click the corresponding button. More gameplay [repo-dispatcher](https://github.com/tete1030/github-repo-dispatcher)

### 2.4 **localized compilation**

#### Notice:

1. **DO NOT** git and compile with the **root** user! ! !

2. For domestic users, please prepare the ladder before compiling, and use the mainland whitelist or global mode

3. Please use Ubuntu 64bit, Ubuntu 18 or Ubuntu 20 is recommended

#### First compile:

```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/opbuild.sh)"
```

#### Secondary compilation:

```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/rebuild.sh)"
```


## 3. **use**

### 3.1 **Background**

+ login address op/ or 10.0.0.1 (If the background cannot be opened, please try plugging and unplugging the order of wan and lan network cables.)

+ default user root

+ default password root

### 3.2 **quick access**
Some services need to be installed and enabled in the package first. You can adjust and add more shortcuts in /etc/nginx/conf.d/shortcuts.conf.

+ op/ open OpenWRT background is lan ip

+ ql/ You can open the Qinglong background that is lan ip:5700

+ adg/ You can open the AdGuardHome management background, that is, lan ip: 3000

+ pve/ Can open Proxmox VE virtual machine management Default is 10.0.0.10:8006

+ by/ You can open the Bypass plugin page, ie ip/luci/admin/services/bypass

+ pk/ You can open the Packages plugin management page, ie ip/luci/admin/system/opkg

+ ag/ Aria2 web panel can be opened i.e. ip/ariang

+ ug/ You can open the firmware online update page i.e. ip/luci/admin/services/gpsysupgrade

## 4. **Precautions**

+ Please use a new installation for the first time to avoid upgrade failures and other possible bugs.

+ Cloud compilation requires [here](https://github.com/settings/tokens) to create a token, and then add a Secret named REPO_TOKEN in Settings->Secrets of this repository, and fill in the token value, otherwise it cannot be triggered compile.

+ Add PPPOE_USERNAME and PPPOE_PASSWD to the repository Settings->Secrets to set the default dial-up account password. There are [security risks](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/issues/23).

+ Add SCKEY in the repository Settings->Secrets to push the compilation results to WeChat through [Server sauce](http://sc.ftqq.com).

+ Add TELEGRAM_CHAT_ID, TELEGRAM_TOKEN in repository Settings->Secrets to push compilation results to Telegram Bot. [Tutorial](https://longnight.github.io/2018/12/12/Telegram-Bot-notifications)

+ DIY cloud compilation tutorial reference: [Read the details in my blog (in Chinese) | Chinese tutorial](https://p3terx.com/archives/build-openwrt-with-github-actions.html)


+ Default plug-ins include: Opkg package management, Bypass intelligent over-the-wall, Samba4 file sharing (x86), UPNP automatic port forwarding, Turbo ACC network acceleration.
For other plug-ins, please install them in the background -> software package. The system upgrade will not lose the plug-ins. After each system upgrade is completed and connected to the network, all the self-installed plug-ins will be automatically installed.

## 5. **System screenshot display**
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/1.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/3.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/8.png)


------
For English

Build OpenWrt using GitHub Actions

## Usage

- Sign up for [GitHub Actions](https://github.com/features/actions/signup)
- Fork [this GitHub repository](https://github.com/kiddin9/OpenWrt)
- click the `Star` button, and the build will starts automatically.Progress can be viewed on the Actions page.
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.


## Acknowledgments

#### Rockchip的Kernel等部分源码来源 https://github.com/coolsnowwolf/lede
#### ipq807x的Kernel等部分源码来源 https://github.com/Boos4721/openwrt
#### ipq60xx的Kernel等部分源码来源 https://github.com/coolsnowwolf/openwrt-gl-ax1800

- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
- [aparcar](https://github.com/openwrt/asu)
- [unifreq](https://github.com/unifreq/openwrt_packit)
- [Boos4721](https://github.com/Boos4721/openwrt)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)


