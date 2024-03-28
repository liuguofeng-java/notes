## linux下安装ffmpeg

##### 1.下载解压

```shell
# 下载地址
https://github.com/FFmpeg/FFmpeg
```

##### 2. 进入解压后目录,输入如下命令/usr/local/ffmpeg为自己指定的安装目录

```shell
cd ffmpeg-3.1

./configure --enable-gpl --enable-libx264 --enable-libmp3lame --extra-cflags=-I/usr/local/x264/include --extra-ldflags=-L/usr/local/x264/lib --enable-libass

make && make install
```

> 如果出现错误

```shell
#出现错误
#ffmpeg: error while loading shared libraries: libavdevice.so.57: cannot open shared object file: No such file or directory

#执行
vi /etc/ld.so.conf

#添加
include ld.so.conf.d/*.conf
/usr/local/lib

#执行
ldconfig
```

##### 3.配置变量

```shell
vi /etc/profile
在最后PATH添加环境变量：
export PATH=$PATH:/usr/local/ffmpeg/bin
保存退出
查看是否生效
source /etc/profile  设置生效
```

##### 4.查看版本

```shell
ffmpeg -version    查看版本
```

#####  5. 注意：

> 若安装过程中出现以下错误：

```shell
yasm/nasm not found or too old. Use –disable-yasm for a crippled build.

If you think configure made a mistake, make sure you are using the latest
version from Git. If the latest version fails, report the problem to the
ffmpeg-user@ffmpeg.org mailing list or IRC #ffmpeg on irc.freenode.net.
Include the log file “config.log” produced by configure as this will help
solve the problem.
```

> 需要安装 yasm

```shell
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make && make install
```
