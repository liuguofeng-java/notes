## docker 安装 mysql5.7

##### 1. 拉取镜像

```shell
docker pull mysql:5.7

docker pull mysql:8.0.39
```

##### 2. 创建mysql容器

```shell
docker run --name mysql01 -p 3306:3306 \
-v /opt/mysql/log:/var/log/mysql \
-v /opt/mysql/conf:/etc/mysql/conf.d \
-v /opt/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=lbf123 \
-d mysql:5.7

docker run --name mysql8 -p 3306:3306 \
--restart=always \
-v /opt/mysql/log:/var/log/mysql \
-v /opt/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=lbf123 \
-e MYSQL_ROOT_HOST=%  \
-e TZ=Asia/Shanghai \
-d mysql:8.0.39 --lower-case-table-names=1
```

- `-p`指定mysql端口
- `-v /opt/mysql/log:/var/log/mysql` 映射mysql日志文件
- `-v /opt/mysql/conf:/etc/mysql/conf.d` 映射mysql配置文件
- `-v /opt/mysql/data:/var/lib/mysql` 映射mysql数据
- `-e MYSQL_ROOT_PASSWORD=lbf123`指定mysql的root密码
- `-d`后台运行
