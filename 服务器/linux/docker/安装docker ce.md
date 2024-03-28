# 安装Docker CE

### 一.手动安装

> Docker有两个分支版本：Docker CE和Docker EE，即社区版和企业版。本教程基于CentOS 7安装Docker CE。

##### 1.  安装Docker的依赖库。

```shell
yum install -y yum-utils device-mapper-persistent-data lvm2
```

##### 2.  添加Docker CE的软件源信息。

```shell
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

##### 3.  安装Docker CE。

```shell
yum makecache fast
yum -y install docker-ce
```

##### 4.  启动Docker服务。

```shell
systemctl start docker
```

##### 5.  配置Docker的自定义镜像仓库地址。请将下面命令中的镜像仓库地址https://kqh8****.mirror.aliyuncs.com替换为阿里云为您提供的专属镜像加速地址。

```shell
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://kqh8****.mirror.aliyuncs.com"]
}
EOF
```

##### 6.  重新加载服务配置文件

```shell
systemctl daemon-reload
```

##### 7.  重启Docker服务。

```shell
systemctl restart docker
```

### 2.shell命令自动化安装

```shell
curl -sSL https://get.daocloud.io/docker | sh
```