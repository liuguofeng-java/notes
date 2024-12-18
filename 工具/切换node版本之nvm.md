## 切换node版本之nvm

### nvm 安装

##### 1.nvm是什么

> nvm全名node.js version management，顾名思义是一个nodejs的版本管理工具。通过它可以安装和切换不同版本的nodejs。下面列出下载、安装及使用方法。

##### 2.下载

 项目地址: https://github.com/coreybutler/nvm-windows

##### 3.使用nvm安装/管理nodejs

1. 查看本地安装的所有版本；有可选参数available，显示所有可下载的版本。

   ```shell
   nvm list [available]
   ```

2. 安装，命令中的版本号可自定义，具体参考命令1查询出来的列表

   ```shell
   nvm install 11.13.0
   ```

3. 使用特定版本

   ```shell
   nvm use 11.13.0
   ```

4. 卸载

   ```shell
   nvm uninstall 11.13.0
   ```

##### 4.命令提示

1. nvm arch ：显示node是运行在32位还是64位。

1. nvm install <version> [arch] ：安装node， version是特定版本也可以是最新稳定版本latest。可选参数arch指定安装32位还是64位版本，默认是系统位数。可以添加--insecure绕过远程服务器的SSL。

1. nvm list [available] ：显示已安装的列表。可选参数available，显示可安装的所有版本。list可简化为ls。

1. nvm on ：开启node.js版本管理。

1. nvm off ：关闭node.js版本管理。

1. nvm proxy [url] ：设置下载代理。不加可选参数url，显示当前代理。将url设置为none则移除代理。

1. nvm node_mirror [url] ：设置node镜像。默认是https://nodejs.org/dist/。如果不写url，则使用默认url。设置后可至安装目录settings.txt文件查看，也可直接在该文件操作。

1. nvm npm_mirror [url] ：设置npm镜像。https://github.com/npm/cli/archive/。如果不写url，则使用默认url。设置后可至安装目录settings.txt文件查看，也可直接在该文件操作。

1. nvm uninstall <version> ：卸载指定版本node。

1. nvm use [version] [arch] ：使用制定版本node。可指定32/64位。

1. nvm root [path] ：设置存储不同版本node的目录。如果未设置，默认使用当前目录。

1. nvm version ：显示nvm版本。version可简化为v



### linux安装

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
#或者，您可以使用以下命令从GitHub克隆nvm存储库并安装：
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
cd ~/.nvm
git checkout v0.38.0
. nvm.sh
```

打开.bashrc文件：`vim ~/.bashrc`

在文件末尾添加以下内容：

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```



### nvm 安装慢问题解决

#### 1.MAC / Linux 下只需要执行如下命令即可：

```sh
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/
```

#### 2.windows
> 解决办法：在你nvm的安装路径下，找到settings.txt打开，在后面加加上

```sh
node_mirror: https://npm.taobao.org/mirrors/node/ 
npm_mirror: https://npm.taobao.org/mirrors/npm/
```



### nvm切换版本后没有npm的问题

```sh
# nvm install 版本号 --with-npm
nvm install 8.12.0 --with-npm
```



### node版本

```
https://nodejs.org/dist/index.json
```

