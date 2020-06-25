# Actions OpenWrt Snapshot With Nginx
[1]: https://img.shields.io/badge/license-GPLV2-brightgreen.svg
[2]: /LICENSE
[3]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg
[4]: https://github.com/garypang13/Actions-OpenWrt-Nginx/pulls
[5]: https://img.shields.io/badge/Issues-welcome-brightgreen.svg
[6]: https://github.com/garypang13/Actions-OpenWrt-Nginx/issues/new
[7]: https://img.shields.io/github/v/release/hyird/Action-Openwrt
[8]: https://github.com/garypang13/Actions-OpenWrt-Nginx/releases
[10]: https://img.shields.io/badge/Contact-telegram-blue
[11]: https://t.me/openwrt_nginx
[12]: https://github.com/garypang13/Actions-OpenWrt-Nginx/workflows/Openwrt-AutoBuild/badge.svg
[13]: https://github.com/garypang13/Actions-OpenWrt-Nginx/actions

[![license][1]][2]
[![PRs Welcome][3]][4]
[![Issue Welcome][5]][6]
[![Release Version][7]][8]
[![Contact Me][10]][11]
[![AutoBuild][12]][13]

<a href="https://t.me/openwrt_nginx" target="_blank">Telegram</a>
### 特色:

+ Cutting edge,openwrt官方master分支版本,内核升级到5.4. 与官方最新源码同步.

+ 原生极致纯净,固件默认只包含基础上网功能,后台在线选装插件,自建插件仓库囊括了市面上主流开源插件,系统升级不丢失插件和配置.

+ 性能,友好度,易用性,插件,以及针对国内特殊环境等的自定义优化

+ uhttpd替换为nginx,大大增加可玩性(只针对X64设备):
     + Nginx+PHP+MariaDB, 用于搭建FileRun,可道云等云盘,建站等.
     + 通过nginx实现Webdav 自建共享同步网盘神器
     + nginx反向代理 实现后台每个页面与服务都可通过自定义域名访问

+ 内置AdguardHome搭配SmartDNS综合优化方案, 开箱即用,实现恶意网站过滤+区分国内外域名解析加速+ 防污染+ DNS优选 (需在后台安装luci-app-adguardhome和luci-app-smartdns,K2P只需安装luci-app-smartdns)

+ 无需专业知识,无需linux服务器,人人皆可通过云编译定制编译自己的专属固件.

+ 持续更新,  每周日零点定时自动云编译更新固件,不用再担心因停更而需更换固件.

+ SSL兼容,可同时使用http IP访问和绑定域名开启https访问(只针对X64设备)

固件下载 [Releases](https://github.com/garypang13/Actions-OpenWrt-Nginx/releases),每周日更新固件.

后台入口 10.0.0.1 &nbsp;(若后台无法打开,请插拔交换wan,lan网线顺序.)

默认密码 root

第一次使用请采用全新安装,避免出现升级失败以及其他一些可能的Bug.

云编译需要 [在此](https://github.com/settings/tokens) 创建个token,然后在此仓库Settings->Secrets中添加个名字为REPO_TOKEN的Secret,填入token值,否者无法release

在仓库Settings->Secrets中分别添加 PPPOE_USERNAME, PPPOE_PASSWD 可设置默认拨号账号密码.

Secrets中添加 SCKEY 可通过[Server酱](http://sc.ftqq.com) 推送编译结果到微信

Secrets中添加 TELEGRAM_BOT_URL 可推送编译结果到Telegram Bot. [获取机器人](https://t.me/notificationme_bot)

fork后点击右上角的Star按钮开始编译

diy云编译教程: [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

### 默认插件包含:

+ Opkg 软件包管理
+ UPNP 自动端口转发
+ Turbo ACC 网络加速

其他插件请自行在 后台->软件包 中安装,系统升级不会丢失插件.每次系统升级完成连接网络后,会自动安装所有已自选安装的插件.

#### 默认后台地址 10.0.0.1, 密码 root

#### X64设备请分配不低于800M 的磁盘空间.


[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/garypang13/Actions-OpenWrt-Nginx/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/garypang13/Actions-OpenWrt-Nginx.svg?style=flat-square&label=Stars)](https://github.com/P3TERX/Actions-OpenWrt/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/garypang13/Actions-OpenWrt-Nginx.svg?style=flat-square&label=Forks)](https://github.com/P3TERX/Actions-OpenWrt/fork)

Build OpenWrt using GitHub Actions

### Usage

- Sign up for [GitHub Actions](https://github.com/features/actions/signup)
- Fork [this GitHub repository](https://github.com/garypang13/Actions-OpenWrt-Nginx)
- click the `Star` button, and the build will starts automatically.Progress can be viewed on the Actions page.
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.

### Acknowledgments
- [OpenWrt](https://github.com/openwrt/openwrt)
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [upload-release-action](https://github.com/svenstaro/upload-release-action)
- [Microsoft](https://www.microsoft.com)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cisco](https://www.cisco.com/)

