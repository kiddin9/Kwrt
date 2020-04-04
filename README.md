# Actions OpenWrt Snapshot With Nginx

### 特色:

+ 全网最新,openwrt官方master分支版本,Kernel 5.4. 插件,内核,luci,packages都与官方最新源码同步.

+ 性能,友好度,易用性,插件,以及针对国内特殊环境等的自定义优化

+ uhttpd替换为nginx,大大增加可玩性:
     + nginx搭配PHP与可道云,建站,NAS两不误,基本可替换群晖等专业NAS系统
     + 通过nginx实现Webdav 自建共享同步网盘神器
     + nginx反向代理 实现后台每个页面与服务都可通过自定义域名访问

+ 内置AdguardHome搭配SmartDNS综合优化方案, 开箱即用,实现恶意网站过滤+区分国内外域名解析加速+ 防污染+ DNS优选

+ SSL兼容,可同时使用http IP访问和绑定域名开启https访问

+ 可傻瓜式定时全自动云编译专属固件,无需专业知识,无需linux服务器即可定制编译自己的专属固件.

[lean](https://github.com/coolsnowwolf/lede/tree/master/package/lean) 源码里的所有插件都有移植过来,增加插件只需在X86_64.config文件中开启然后云编译即可.

X86_64固件在此 [Releases](https://github.com/garypang13/Actions-OpenWrt-Snapshot/releases) 下载,周更.

后台入口 10.0.0.1 &nbsp;(若后台无法打开,请插拔交换wan,lan网线顺序,默认第一个网口eth0为wan口,第二个网eth1口为lan口.)

默认密码 root

第一次使用请采用全新安装,避免出现升级失败以及其他一些可能的Bug.

建议fork此项目,按自己路由器类型与需求调整.config文件来适配路由器与增删插件,再通过github云编译来编译自己的定制化专属固件

云编译需要[在此](https://github.com/settings/tokens)创建个token,然后在此仓库Settings->Secrets中添加个名字为REPO_TOKEN的Secret,填入token值,否者无法release

点击右上角的Star按钮开始编译

diy云编译教程: [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

### 默认插件包含:

+ SSR PLUS
+ PASSWALL
+ AdguardHome DNS+恶意网址过滤
+ 上网时间控制
+ 微信推送
+ ACME自动SSL证书生成
+ 网易云音乐解锁
+ 动态DDNS
+ SmartDNS 域名解析加速+抗污染
+ 硬盘休眠
+ WatchCat 网络连通性监控
+ vlmcsd KMS微软相关激活工具
+ ttyd 网页版终端
+ UPNP 自动端口转发
+ Aria2 全能下载工具
+ cifsd 网络共享
+ Netdata 全能性能监控
+ diskman 磁盘管理
+ qBittorrent BT下载工具
+ 可道云 做NAS必备
+ PHP 建站与可道云必备
+ 微力同步
+ baidupcs-web 百度网盘下载管理工具
+ aMule 电骡下载 ed2k必备
+ Turbo ACC 网络加速
+ SQM QOS 智能网络优化
+ eqos IP限速
+ nlbwmon 宽带监控

### 如何在本地编译自己需要的 OpenWrt 固件

#### 注意：

1. **不**要用 **root** 用户 git 和编译！！！
2. 国内用户编译前最好准备好梯子
3. 默认登陆10.0.0.1, 密码 root

#### 编译命令如下:
-
1. 首先装好 Ubuntu 64bit，推荐  Ubuntu  18 LTS x64

2. 命令行输入 `sudo apt-get update` ，然后输入
`
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib
`

3. 使用 `git clone https://github.com/coolsnowwolf/lede` 命令下载好源代码，然后 `cd lede` 进入目录

4. ```bash
   ./scripts/feeds update -a && ./scripts/feeds install -a
   make menuconfig
   ```

5. `make -j8 download v=s` 下载dl库（国内请尽量全局科学上网）


6. 输入 `make -j1 V=s` （-j1 后面是线程数。第一次编译推荐用单线程）即可开始编译你要的固件了。

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars)](https://github.com/P3TERX/Actions-OpenWrt/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks)](https://github.com/P3TERX/Actions-OpenWrt/fork)

Build OpenWrt using GitHub Actions

[GitHub Actions Group](https://t.me/GitHub_Actions) | [GitHub Actions Channel](https://t.me/GitHub_Actions_Channel)

### Usage

- Sign up for [GitHub Actions](https://github.com/features/actions/signup)
- Fork [this GitHub repository](https://github.com/P3TERX/Actions-OpenWrt)
- Generate `.config` files using [OpenWrt](https://github.com/openwrt/openwrt/tree/openwrt-19.07) source code.
- Push `.config` file to the GitHub repository, and the build starts automatically.Progress can be viewed on the Actions page.
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

