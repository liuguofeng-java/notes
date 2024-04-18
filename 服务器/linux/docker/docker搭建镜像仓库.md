## docker搭建镜像仓库

##### 1.下载

> https://github.com/goharbor/harbor/releases

##### 2.安装

> 前提条件需要有`docker` 和`docker-compose`环境

```sh
# 解压
tar -zxvf harbor-offline-installer-v2.10.2.tgz
# 进入目录
cd harbor
# 复制配置文件
cp harbor.yml.tmpl harbor.yml
```

**编辑harbor.yml**

![image-20240415110802472](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240415110802472.png)

```sh
# 安装
sudo  ./install.sh
```

##### 3.解决docker登录问题

> Error response from daemon:Get “https:.//.../v2/"": http: server gave HTTP response to HTTs client

```sh
# 编辑 /etc/docker/daemon.json 添加
{ "insecure-registries":["你的harborip:端口"] }

# 重启服务
systemctl daemon-reload
systemctl restart docker
```

##### 4.解决服务器重启harbor不能使用问题

1. 在 `/etc/systemd/system`新建`harbor.service`

   ```ini
   [Unit]
   Description=harbor
   After=docker.service systemd-networkd.service systemd-resolved.service
   Requires=docker.service
   Documentation=http://github.com/vmware/harbor
   
   [Service]
   Type=simple
   Restart=on-failure
   RestartSec=5
   ExecStart=/usr/local/bin/docker-compose -f  /usr/local/harbor/docker-compose.yml up
   ExecStop=/usr/local/bin/docker-compose -f  /usr/local/harbor/docker-compose.yml down
   
   [Install]
   WantedBy=multi-user.target
   ```

2. 使用`systemctl enable harbor.service`来设置开机自启动即可

   ```sh
   systemctl enable harbor.service
   ```

   
