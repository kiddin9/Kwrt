#### OpenWrt with NGINX for X86/64, NanoPi R2S, NanoPi R4S, NanoPi R5S, NanoPi R2C, Phicomm N1, NanoPi NEO3, 树莓派 4B, DoorNet1, DoorNet2, 香橙派 Orange Pi R1 Plus, 香橙派 Orange Pi R1 Plus LTS, 红米AX6, 小米AX3600, 小米AX9000, 红米AX6S/小米AX3200, 红米AC2100, 小米AC2100, 小米CR6606/TR606(联通版), CR6608/TR608(移动版), CR6609/TR609(电信版), 小米4, 小米 R3G, 小米R3P, 小娱C5, newifi-d2, H1 Box, 贝壳云 P1 , 我家云 lL Pro, x96 Max, 微加云 V-Plus, 章鱼星球 ZYXQ, GT-King, Odroid N2, MXQ Pro+
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

<a href="https://t.me/opwrt" target="_blank">TG通知频道</a>
## 1. **特色**

+ Cutting edge,openwrt官方openwrt-22.03分支版本, Kernel 5.15, 与官方最新源码同步.

+ 原生极致纯净,固件默认只包含基础上网功能, 后台在线选装插件,系统升级不丢失插件和配置.

+ 自建插件仓库囊括了市面上几乎所有开源插件,插件库日更,系统自动更新所有已安装插件.

+ 在线一键定制固件,可在[supes.top](https://supes.top)也可在后台系统定制升级菜单中一键定制, 同时支持github云编译和本地一键编译.

+ 后台一键OTA更新固件,省去了每次固件升级都需要找固件,下载固件,上传固件等繁琐操作.

+ 后台一键设置旁路由,一键开关IPv6.

+ 支持在线安装Kmod内核模块.

+ 重构版SSR-PLUS,国内外智能DNS解析,支持DOH,Trojan-Go等

+ 替换 Uhttpd 为 Nginx, 支持 反向代理; WebDAV等诸多玩法.

+ 性能,友好度,易用性,插件,以及针对国内特殊环境等的自定义优化, 开箱即用

+ 自定制清爽Material风格新主题Edge

## 2. **固件**

固件生成有3种方式：在线定制化生成、GitHub编译、本地化编译。

可根据需要选择任意一种进行固件生成。

### 2.1 **在线生成**

通过浏览器访问[https://supes.top](https://supes.top)进行固件定制，等待固件生成结束之后直接下载使用即可。

### 2.2 **GitHub编译**

+ 将仓库进行fork

+ 按需添加相关环境参数REPO_TOKEN、SCKEY、TELEGRAM_CHAT_ID

+ Actions页面选择 Repo Dispatcher 点击 Run workflow
### 2.3 **GitHub结合浏览器插件编译**
请在支持油猴的浏览器中安装 [脚本](https://greasyfork.org/scripts/407616-github-actions-trigger/code/Github%20Actions%20Trigger.user.js) ,仓库右上角会出现 x86_64 Actions,K2P Actions等按钮,点击对应按钮即可.更多玩法 [repo-dispatcher](https://github.com/tete1030/github-repo-dispatcher)

### 2.4 **本地化编译**

#### 注意：

1. **不**要用 **root** 用户 git 和编译！！！

2. 国内用户编译前请准备好梯子,使用大陆白名单或全局模式

3. 请使用Ubuntu 64bit，推荐  Ubuntu 18 或 Ubuntu 20

#### 首次编译:

```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/opbuild.sh)"
```

#### 二次编译:

```
screen -S openwrt
bash -c "$(curl -fsSL https://git.io/rebuild.sh)"
```


## 3. **使用**

### 3.1 **后台**

+ 登录地址 op/ 或 10.0.0.1 (若后台无法打开，请尝试插拔交换wan、lan网线顺序。)

+ 默认用户 root

+ 默认密码 root

### 3.2 **快捷访问**
部分服务需要先自行在软件包中安装并启用，可自行在 /etc/nginx/conf.d/shortcuts.conf 中调整和添加更多快捷访问。

+ op/ 可打开 OpenWRT后台 即 lan ip

+ ql/ 可打开 青龙后台 即 lan ip:5700

+ adg/ 可打开 AdGuardHome管理后台 即 lan ip:3000

+ pve/ 可打开 Proxmox VE虚拟机管理 默认为 10.0.0.10:8006

+ by/ 可打开 Bypass插件页面 即 ip/luci/admin/services/bypass

+ pk/ 可打开 Packages插件管理页面 即 ip/luci/admin/system/opkg

+ ag/ 可打开 Aria2 Web面板 即 ip/ariang

+ ug/ 可打开 固件在线更新页面 即 ip/luci/admin/services/gpsysupgrade

## 4. **注意事项**

+ 第一次使用请采用全新安装,避免出现升级失败以及其他一些可能的Bug.

+ 云编译需要 [在此](https://github.com/settings/tokens) 创建个token,然后在此仓库Settings->Secrets中添加个名字为REPO_TOKEN的Secret,填入token值,否者无法触发编译。

+ 在仓库Settings->Secrets中分别添加 PPPOE_USERNAME, PPPOE_PASSWD 可设置默认拨号账号密码.有 [安全隐患](https://github.com/kiddin9/OpenWrt_x86-r2s-r4s/issues/23)。

+ 在仓库Settings->Secrets中添加 SCKEY 可通过[Server酱](http://sc.ftqq.com) 推送编译结果到微信。

+ 在仓库Settings->Secrets中添加 TELEGRAM_CHAT_ID, TELEGRAM_TOKEN 可推送编译结果到Telegram Bot. [教程](https://longnight.github.io/2018/12/12/Telegram-Bot-notifications)

+ DIY云编译教程参考: [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)


+ 默认插件包含: Opkg 软件包管理、Bypass 智能过墙、Samba4 文件共享(x86)、UPNP 自动端口转发、Turbo ACC 网络加速。
其他插件请自行在 后台->软件包 中安装,系统升级不会丢失插件.每次系统升级完成连接网络后,会自动安装所有已自选安装的插件。

## 5. **系统截图展示**
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
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
- [aparcar](https://github.com/openwrt/asu)
- [unifreq](https://github.com/unifreq/openwrt_packit)
- [Boos4721](https://github.com/Boos4721/openwrt)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)


