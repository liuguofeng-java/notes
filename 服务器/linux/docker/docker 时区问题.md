## Docker - 时区问题

##### 1.docker run 添加参数

```shell
-v /etc/localtime:/etc/localtime

# 实例
docker run -p 3306:3306 --name mysql -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone
```

##### 2.DockerFile

```sh
FROM ubuntu:latest

LABEL author="liuguofeng-java@qq.com" \
      version="1.0"

WORKDIR /usr/local/java

# 安装 tzdata 包
RUN apt-get update && apt-get install -y tzdata

# 创建符号链接
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 设置上海时区
ENV TZ=Asia/Shanghai
```

##### 3.docker-compose

```yml
version: '1'
services:
  your_service:
    image: ubuntu:latest
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
```

