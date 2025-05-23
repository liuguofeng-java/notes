## 无网络安装docker

##### 1.下载地址

> https://download.docker.com/linux/static/stable/x86_64/

##### 2.解压并拷贝到**/usr/bin**

```sh
tar -xvf docker-xx.xx.xx.tar
cp docker/* /usr/bin
```

##### 3.注册docker服务 **vim /etc/systemd/system/docker.service**

```ini
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target
[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
 
[Install]
WantedBy=multi-user.target
 
```

##### 4.添加文件权限并启动docker相关服务

```sh
# 添加文件权限
chmod +x /etc/systemd/system/docker.service

# 重载unit配置文件
systemctl daemon-reload

# 启动Docker
systemctl start docker                                            

# 设置开机自启
systemctl enable docker.service
```

##### 5.验证是否安装成功

```sh
# 查看Docker状态
systemctl status docker           

# 查看版本
docker -v 
```

##### 6.添加docker用户组，让其他用户也能执行docker命令

```sh
sudo groupadd docker # 创建docker用户组
sudo usermod -aG docker test # 将 test 用户加入docker用户组
sudo systemctl restart docker # 重启docker服务
# test 用户可以使用docker了, 以上步骤需要root权限
```

