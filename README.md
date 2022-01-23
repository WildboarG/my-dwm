# my-dwm
backup my dwm config

---

## 基本配置存放

1. 下载dwm 源码包并解压

   - 移动到dwm目录下并编译

     ```shell
     make
     ```

     

2. 将 `.dwm `文件夹复制到主目录文件下

   - 该目录下的脚本是开机自定义脚本
   - 将`scripts` 文件加移动打到`.dwm`文件夹下
     - 里边存放的是键位映射的脚本

3. 将`config.h` 和 `dwm.c` 文件复制到你的dwm文件夹下

​		编译 

```shell
sudo make clean install
```

## 触摸板手势

### 触摸板驱动

首先看一看 wiki

> 警告: `xf86-input-synaptics` 已经停止维护，请尽量使用 `libinput`。

如果想要在 Xorg 上 安装 `libinput`，使用 `xf86-input-libinput` 包。此包允许 libinput 在 X 上作为驱动使用。此驱动会代替 `evdev` 和 `synaptics` 运行

所以我们就需要安装 `xf86-input-libinput` 包

```shell
sudo pacman -S xf86-input-libinput
```

自定义配置文件应放在 `/etc/X11/xorg.conf.d/` 中，并且通常选择被广泛使用的命名模式 `30-touchpad.conf` 作为文件名

```bash
$ sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
EndSection
```

写入配置之后记得重启

### 手势操作

要使用 `libinput-gestures`, 请安装 `libinput-gestures`。 你能使用很多系统级别的手势操作，也能自定义配置文件。详情请看 [README](https://github.com/bulletmark/libinput-gestures/blob/master/README.md) 。

```bash
$ sudo pacman -S libinput-gestures
```

libinput-gestures 的文档中说了：必须是 input 组的成员才能具有读取触摸板设备的权限，所以需要添加用户到 input

```bash
$ sudo gpasswd -a $USER input
```

退出登录后生效（或者重启）

然后安装需要的包

```bash
$ sudo pacman -S xdotool wmctrl
```

写入配置文件

```bash
$ vim .config/libinput-gestures.conf

gesture swipe left 4 xdotool key MODKEY+XK_Return # 4指左划: 交换主区域
gesture swipe right 4 xdotool key super+Ctrl+Right # 4指右划: 切换到右侧工作
区
gesture swipe up 4 xdotool key Shift+Alt+d# 4指上划: 关机
gesture swipe down 4 xdotool key Alt+b # 4指下划: 隐藏状态栏
gesture pinch in 4 xdotool key super+r # 4指捏: 调整窗口大

gesture swipe left 3 xdotool key Alt+Enter # 3指左划: 交换主区域

gesture swipe right 3 xdotool key Alt+Enter # 3指右划: 窗口移动到右边
gesture swipe up 3 xdotool key Alt+m # 3指下划: 全屏
gesture swipe down 3 xdotool key Alt+t # 3指上划: 平铺
gesture pinch in 3 xdotool key ctrl+minus # 3指捏: 缩小
gesture pinch out 3 xdotool key ctrl+plus # 3指捏: 放大

gesture pinch in 2 xdotool key ctrl+minus # 2指捏: 缩小
gesture pinch out 2 xdotool key ctrl+plus # 2指张: 放大
```

这里可以根据自己的习惯来搭配，然后启动`ibinput-gestures`。

```bash
$ libinput-gestures-setup autostart
$ libinput-gestures-setup start
```



## 自启脚本

---

> 配合dwm 的补丁使用

- 在`dwm`目录下新建存放补丁的路径`pacthes`

- 移动到`patches`目录下

  ```shell
  ## 下载本人使用的补丁
  wget https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-20211119-58414bee958f2.diff
  wget https://dwm.suckless.org/patches/barpadding/dwm-barpadding-20211020-a786211.diff
  wget https://dwm.suckless.org/patches/alpha/dwm-alpha-20201019-61bb8b2.diff
  wget https://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff
  ```

- 移动回`dwm`目录下，删除`config.def.h`防止配置被重置

  ```shell
  rm -rf config.def.h
  ```

  

- 安装补丁

  ```shell
  ## 如下 四个要安装
  ## 按照提示把补丁位置添加到config.h
  patch < ~/dwm/patches/dwm-barpadding-20211020-a786211.diff
  ```

  

  

- 重新`make`安装

  ```shell
  sudo make clean install
  ```

  



`archlinux,dwm`
