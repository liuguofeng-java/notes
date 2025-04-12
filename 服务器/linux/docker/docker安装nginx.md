## docker 安装nginx

##### 1. 拉取镜像

```shell
docker pull nginx:1.20.2
```

> 返回以下信息说明已经拉取成功

```shell
Using default tag: latest
latest: Pulling from library/nginx
6ae821421a7d: Pull complete
da4474e5966c: Pull complete
eb2aec2b9c9f: Pull complete
Digest: sha256:dd2d0ac3fff2f007d99e033b64854be0941e19a2ad51f174d9240dda20d9f534
Status: Downloaded newer image for nginx:latest
```

##### 2. 文件目录

###### 1.启动基础容器用于资源拷贝

```shell
docker run -d --name=nginx nginx:1.26.3
```

###### 2.创建nginx目录文件并进入

```shell
日志文件位置：/var/log/nginx
配置文件位置: /etc/nginx
资源存放的位置: /usr/share/nginx/html
```

注：日志目录为软连接，所以不创建logs目录

###### 3.复制配置文件并创建文件夹

```shell
docker cp nginx:/etc/nginx ./conf
```

###### 4.复制资源存文件并创建目录

```shell
docker cp nginx:/usr/share/nginx/html ./html
```

###### 5.删除基础容器

停止nginx

```shell
docker stop nginx
```

删除nginx

```shell
docker rm nginx
```

##### 3. 创建正式容器

```shell
docker run -d --restart=always --name nginx -p 80:80 -p 443:443 \
-v /opt/nginx/conf:/etc/nginx \
-v /opt/nginx/html:/usr/share/nginx/html \
-v /opt/nginx/www:/usr/share/nginx/www \
nginx:1.26.3
```
