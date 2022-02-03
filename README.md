# OpenWrt with NGINX for x86_64 NanoPi-R2S R4S Raspberry-Pi-4B
[1]: https://img.shields.io/badge/license-GPLV2-brightgreen.svg
[2]: /LICENSE
[3]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg
[4]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/pulls
[5]: https://img.shields.io/badge/Issues-welcome-brightgreen.svg
[6]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/issues/new
[7]: https://img.shields.io/github/v/release/hyird/Action-Openwrt
[8]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/releases
[10]: https://img.shields.io/badge/Contact-telegram-blue
[11]: https://t.me/opwrts
[12]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/actions/workflows/Openwrt-AutoBuild.yml/badge.svg
[13]: https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/actions

[![license][1]][2]
[![GitHub Stars](https://img.shields.io/github/stars/kiddin9/OpenWrt_x86-r2s-r4s.svg?style=flat-square&label=Stars)](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/kiddin9/OpenWrt_x86-r2s-r4s.svg?style=flat-square&label=Forks)](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/fork)
[![PRs Welcome][3]][4]
[![Issue Welcome][5]][6]
[![AutoBuild][12]][13]

<a href="https://t.me/opwrts" target="_blank">Telegram</a>
### 特色:

+ Cutting edge,openwrt官方openwrt-21.02分支版本, Kernel 5.10, 与官方最新源码同步.

+ 原生极致纯净,固件默认只包含基础上网功能, 后台在线选装插件,系统升级不丢失插件和配置.

+ 自建插件仓库囊括了市面上几乎所有开源插件,插件库日更,系统自动更新所有已安装插件.

+ 在线一键定制固件,可在[bf.supes.top](https://bf.supes.top)也可在后台系统定制升级菜单中一键定制, 同时支持github云编译和本地一键编译.

+ 后台一键OTA更新固件,省去了每次固件升级都需要找固件,下载固件,上传固件等繁琐操作.

+ 后台一键设置旁路由,一键开关IPv6.

+ 支持在线安装Kmod内核模块.

+ 重构版SSR-PLUS,国内外智能DNS解析,支持DOH,Trojan-Go等

+ 替换 Uhttpd 为 Nginx, 支持 反向代理; WebDAV等诸多玩法.

+ 性能,友好度,易用性,插件,以及针对国内特殊环境等的自定义优化, 开箱即用

+ 自定制清爽Material风格新主题Edge


| 设备           | 固件下载                                             | 🐳 Docker |说明                                 |
|----------------|-----------------------------------------------------|--|--------------------------------------|
| X86_64         | [📥](https://op.supes.top/firmware/x86_64/)  | [kiddin9/openwrt-nginx:x86_64](https://hub.docker.com/r/kiddin9/openwrt-nginx)      | 请分配不少于1G的存储空间           |
| NanoPi-R2S    | [📥](https://op.supes.top/firmware/nanopi-r2s/) | [kiddin9/openwrt-nginx:nanopi-r2s](https://hub.docker.com/r/kiddin9/openwrt-nginx)   | 默认交换了网口,靠近电源口的是WAN口   |
| NanoPi-R4S    | [📥](https://op.supes.top/firmware/nanopi-r4s/) | [kiddin9/openwrt-nginx:nanopi-r4s](https://hub.docker.com/r/kiddin9/openwrt-nginx)   |
| Raspberry Pi 4B (树莓派4B)| [📥](https://op.supes.top/firmware/Rpi-4B/)  | [kiddin9/openwrt-nginx:rpi-4b](https://hub.docker.com/r/kiddin9/openwrt-nginx)   |

####  固件下载与定制: [https://bf.supes.top](https://bf.supes.top)

#### 后台入口 op/ 或 10.0.0.1 &nbsp;(若后台无法打开,请插拔交换wan,lan网线顺序.)

#### 默认密码 root

#### 固件内置的快捷访问入口(部分服务需要先自行在软件包中安装并启用):

+ op/ 可打开 OpenWRT后台 即 lan ip
+ ql/ 可打开 青龙后台 即 lan ip:5700
+ adg/ 可打开 AdGuardHome管理后台 即 lan ip:3000
+ pve/ 可打开 Proxmox VE虚拟机管理 默认为 10.0.0.10:8006
+ by/ 可打开 Bypass插件页面 即 ip/luci/admin/services/bypass
+ pk/ 可打开 Packages插件管理页面 即 ip/luci/admin/system/opkg
+ ag/ 可打开 Aria2 Web面板 即 ip/ariang
+ ug/ 可打开 固件在线更新页面 即 ip/luci/admin/services/gpsysupgrade
##### 可自行在 /etc/nginx/conf.d/shortcuts.conf 中调整和添加更多快捷访问

第一次使用请采用全新安装,避免出现升级失败以及其他一些可能的Bug.

云编译需要 [在此](https://github.com/settings/tokens) 创建个token,然后在此仓库Settings->Secrets中添加个名字为REPO_TOKEN的Secret,填入token值,否者无法触发编译

在仓库Settings->Secrets中分别添加 PPPOE_USERNAME, PPPOE_PASSWD 可设置默认拨号账号密码.有 [安全隐患](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/issues/23)

Secrets中添加 SCKEY 可通过[Server酱](http://sc.ftqq.com) 推送编译结果到微信

Secrets中添加 TELEGRAM_CHAT_ID, TELEGRAM_TOKEN 可推送编译结果到Telegram Bot. [教程](https://longnight.github.io/2018/12/12/Telegram-Bot-notifications)

编译触发方式: 
   + 方式1: Actions页面选择 Repo Dispatcher 点击 Run workflow
   + 方式2: 请在支持油猴的浏览器中安装 [脚本](https://greasyfork.org/scripts/407616-github-actions-trigger/code/Github%20Actions%20Trigger.user.js) ,仓库右上角会出现 x86_64 Actions,K2P Actions等按钮,点击对应按钮即可.更多玩法 [repo-dispatcher](https://github.com/tete1030/github-repo-dispatcher)
diy云编译教程: [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

### 默认插件包含:

+ Opkg 软件包管理
+ Bypass 智能过墙
+ Samba4 文件共享(x86)
+ UPNP 自动端口转发
+ Turbo ACC 网络加速

其他插件请自行在 后台->软件包 中安装,系统升级不会丢失插件.每次系统升级完成连接网络后,会自动安装所有已自选安装的插件.


### 如何在本地使用此项目编译自己需要的 OpenWrt 固件

#### 注意：

1. **不**要用 **root** 用户 git 和编译！！！
2. 国内用户编译前请准备好梯子,使用大陆白名单或全局模式
3. 请使用Ubuntu 64bit，推荐  Ubuntu 18 或 Ubuntu 20

#### 一键脚本:

 首次编译:
```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/opbuild.sh)"
```

 二次编译:
```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/rebuild.sh)"
```

Build OpenWrt using GitHub Actions

### Usage

- Sign up for [GitHub Actions](https://github.com/features/actions/signup)
- Fork [this GitHub repository](https://github.com/kiddin9/OpenWrt)
- click the `Star` button, and the build will starts automatically.Progress can be viewed on the Actions page.
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.

### Acknowledgments
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [CTCGFW's Team](https://github.com/immortalwrt/immortalwrt)
- [Lienol](https://github.com/Lienol/openwrt)
- [P3TERX](https://github.com/P3TERX/OpenWrt_x86-r2s-r4s/blob/master/LICENSE)
- [upload-release-action](https://github.com/svenstaro/upload-release-action)
- [Microsoft](https://www.microsoft.com)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cisco](https://www.cisco.com/)

![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/1.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/2.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/3.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/8.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/4.png)
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/5.png)
<br/>
<br />
<img src="https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/6.png" width="550" />
![](https://github.com/kiddin9/luci-theme-edge/raw/master/Screenshots/7.png)
