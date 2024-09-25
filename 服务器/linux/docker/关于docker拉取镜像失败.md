

## 设置[国内源](https://so.csdn.net/so/search?q=国内源&spm=1001.2101.3001.7020)：

```
提示：常规方案（作用不大）
```

阿里云提供了镜像源：https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors 登录后你会获得一个专属的地址
使用命令设置[国内镜像源](https://so.csdn.net/so/search?q=国内镜像源&spm=1001.2101.3001.7020)：通过vim /etc/docker/daemon.json 进入修改添加 registry-mirrors 内容后重启 Docker

```java
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://***替换为你的地址***.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

此命令会创建一个 /etc/[docker](https://so.csdn.net/so/search?q=docker&spm=1001.2101.3001.7020)/daemon.json 文件，并将国内源的配置写入其中。然后你只需要重启 Docker 服务即可使配置生效，可以通过运行 sudo systemctl restart docker 命令来重启 Docker 服务。

## 解决目前无法访问，超时连接方法

**解决方案1：配置加速地址**

配置加速地址：适用于Ubuntu 16.04+、Debian 8+、CentOS 7+

方式一：使用以下命令设置registry mirror：但是需要重启docker服务

```c
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://do.nark.eu.org",
        "https://dc.j8.work",
        "https://docker.m.daocloud.io",
        "https://dockerproxy.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://docker.nju.edu.cn"
    ]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

> **检查加速是否生效：**
> 查看docker系统信息 docker info，如果从输出结果中看到了 registry mirror 刚配置的内容地址，说明配置成功。

方式二：如果您当前有正在运行的容器不方便重启Docker服务，则不用设置环境也可以直接使用，用法示例：

```java
docker pull do.nark.eu.org/library/mysql:5.7
1
```

第三方镜像：

AtomHub 可信镜像中心 - 大部分需要的镜像都是有的。
可信镜像中心官网：https://atomhub.openatom.cn/
通过搜索需要的镜像名称，进行pull拉取，用法示例：

```java
docker pull atomhub.openatom.cn/amd64/redis:7.0.13
```

> 注意：docker compose 中要执行部署时，可以把版本与 atomhub 提供的版本匹配上，之后通过【拉取命令】进行单独拉取后，在执行 docker compose 就可以了。

加速代理站点：

专门为Github用户提供下载加速服务的代理站点。由于Github的下载速度在某些地区可能会受到限制，导致开发者在获取代码库、项目文件等资源时遇到困难。该代理站点通过优化的网络节点和高速服务器，为用户提供快速、稳定的Github资源下载服务。
站点地址：https://docker.888666222.xyz/

```java
第一步：为了加速镜像拉取，你可以使用以下命令设置 registry mirror:

sudo tee /etc/docker/daemon.json <<EOF
{
    "registry-mirrors": ["https://docker.888666222.xyz"]
}
EOF
第二步：为了避免 Worker 用量耗尽，你可以手动 pull 镜像然后 re-tag 之后 push 至本地镜像仓库:

docker pull docker.888666222.xyz/library/alpine:latest # 拉取 library 镜像
docker pull docker.888666222.xyz/coredns/coredns:latest # 拉取 coredns 镜像
```

**解决方案2：使用代理拉取镜像**

```java
第一步：创建配置文件
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf

第二步：在文件中添加代理
[Service]
Environment="HTTP_PROXY=socks5://user:pass@127.0.0.1:1080"
Environment="HTTPS_PROXY=socks5://user:pass@127.0.0.1:1080"

第三步：重启Docker
sudo systemctl daemon-reload
sudo systemctl restart docker

第四步：查看环境变量
sudo systemctl show --property=Environment docker
```

**解决方案3：备用办法：直接传送镜像**

国外服务器拉取镜像后打包压缩到本地，然后传输到国内服务器，myimage为镜像名

```java
第一步：A服务器保存Docker镜像
docker save myimage > myimage.tar

第二步：传送到B服务器
scp myimage.tar root@192.0.2.0:/home
然后输入B服务器root密码

第三步：B服务器加载Docker镜像
cd /home
docker load < myimage.tar

第四步：查看镜像
docker images
```

## 目前可用的镜像代理：

拉取 pull 镜像时，遇到不可用、关停、访问比较慢的状态，建议同时配置多个镜像源。

| 提供商         | 地址                                    |
| -------------- | --------------------------------------- |
| DaoCloud       | https://docker.m.daocloud.io            |
| 阿里云         | https://<your_code>.mirror.aliyuncs.com |
| Docker镜像代理 | https://dockerproxy.com                 |
| 百度云         | https://mirror.baidubce.com             |
| 南京大学       | https://docker.nju.edu.cn               |
| 中科院         | https://mirror.iscas.ac.cn              |

**小福利：**
近期 Rainbond 社区为了方便拉取 Docker 镜像,自主搭建了个镜像加速服务，采用 CloudFlare + 国外服务器 Nginx 反代的方案为 Rainbond 社区的用户们提供镜像加速服务。

```java
方式一：直接获取 Docker Hub 镜像
docker pull docker.rainbond.cc/library/node:20
docker pull docker.rainbond.cc/rainbond/rainbond:v5.17.2-release-allinone

方式二：配置镜像加速器
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://docker.rainbond.cc"]
}
EOF
systemctl daemon-reload
systemctl restart docker

技术栈参考LINK
https://www.rainbond.com/docs/quick-start/quick-install
```

## 解决办法千万条：

面对问题时，解决的途径和方法是多种多样的。每个人、每个团队在面对问题时，都可以根据自身的情况和资源，创造性地找到最适合自己的解决办法。

> 1. Docker Hub 镜像加速： https://gitee.com/wanfeng789/docker-hub
> 2. 国内无法访问下载Docker镜像的多种解决方案：https://www.bilibili.com/read/cv35387254/
> 3. 总结目前国内加速拉取 docker 镜像的几种方法：https://zhuanlan.zhihu.com/p/703322576
> 4. 从Docker Hub拉取镜像受阻？这些解决方案帮你轻松应对：https://mp.weixin.qq.com/s/pXrxedldKOoD97bMDYy3pQ文章知识点与官方知识档案匹配，可进一步学习相关知识

