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

##### 5.  配置Docker的自定义镜像仓库地址。可以在'aliyun>容器镜像服务>镜像加速器'中设置

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://docker.888666222.xyz"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 查看是否配置成功
docker info
```

### 2.shell命令自动化安装

```shell
curl -fsSL https://get.docker.com -o install-docker.sh
#或者
curl -fsSL https://test.docker.com -o test-docker.sh
```