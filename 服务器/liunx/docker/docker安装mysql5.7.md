## docker 安装 mysql5.7

##### 1. 拉取镜像

```shell
docker pull mysql:5.7
```

##### 2. 创建mysql容器

```shell
docker run --name mysql01 -p 3306:3306 \
-v /home/mysql/log:/var/log/mysql \
-v /home/mysql/conf:/etc/mysql/conf.d \
-v /home/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=lbf123 \
-d mysql:5.7
```

- `-p`指定mysql端口
- `-v /home/mysql/log:/var/log/mysql` 映射mysql日志文件
- `-v /home/mysql/conf:/etc/mysql/conf.d` 映射mysql配置文件
- `-v /home/mysql/data:/var/lib/mysql` 映射mysql数据
- `-e MYSQL_ROOT_PASSWORD=lbf123`指定mysql的root密码
- `-d`后台运行
