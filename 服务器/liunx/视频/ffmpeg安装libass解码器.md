## ffmpeg安装libass解码器



#### 安装 libfreetype

如果ffmpeg编译参数包含 --enable-libass 则需要先安装 libfreetype fribidi fontconfig libass

```shell
wget "https://download.savannah.gnu.org/releases/freetype/freetype-2.9.1.tar.gz"

tar zxvf freetype-2.9.1.tar.gz

cd freetype-2.9.1/

./configure --prefix=/usr/local --disable-static

make

make install
```

#### 安装 fribidi

```shell
wget "https://github.com/fribidi/fribidi/releases/download/v1.0.4/fribidi-1.0.4.tar.bz2"

tar xf fribidi-1.0.4.tar.bz2

cd fribidi-1.0.4

./configure --prefix=/usr/local/ --enable-shared

make

make install
```

#### 安装 fontconfig

为防止出现找不到 libfreetype 的错误，首先修改 PKG_CONFIG_PATH 环境变量：

```shell
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

wget "https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.0.tar.gz"

tar zxvf fontconfig-2.13.0.tar.gz

cd fontconfig-2.13.0

./configure --prefix=/usr/local/ --enable-shared --enable-libxml2

make

make install


### 如果报错 No package 'uuid' found 则按如下步骤解决：

yum -y install libuuid-devel



### 如果报错 WARNING: 'gperf' is missing on your system. 则按如下步骤解决：

wget http://mirrors.ustc.edu.cn/gnu/gperf/gperf-3.1.tar.gz

tar zxvf gperf-3.1.tar.gz

cd gperf-3.1

./configure

make

make install
```

#### 安装 libass

```shell
wget https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz

tar xvf libass-0.14.0.tar.xz

cd libass-0.14.0

./configure --prefix=/usr/local/ --disable-static

make

make install
```