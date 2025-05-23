## dockers-compose

##### 1.安装

> 官网: https://docs.docker.com/compose/install/

1. 下载和安装

   ```sh
   curl -SL https://github.com/docker/compose/releases/download/v2.26.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
   ```

2. 赋予执行权限

   ```sh
   chmod +x /usr/local/bin/docker-compose
   ```

3. 查看版本

   ```sh
   docker-compose --version
   ```




##### 3.常用命令

```sh
docker-compose -f docker-compose.yml  up -d    # 启动docker-compose管理的所有容器
docker-compose ps                               # 列出 Compose 应用中的各个容器,类似docker ps
docker-compose logs web                        # 查看web服务日志
docker-compose down                               # 停止并移除容器、网络、镜像和数据卷.比stop更彻底
docker-compose images                             # 列出所有镜像


docker-compose stop                               # 停止 Compose 应用相关的所有容器，但不会删除它们
docker-compose restart                           # 重启YAML文件中定义的服务
docker-compose kill                            # 停止服务
docker-compose rm                               # 删除指定已经停止服务的容器(它会删除容器和网络，但是不会删除卷和镜像)
docker-compose build                           # 构建或重建服务
docker-compose pull                               # 拉去并下载指定服务镜像
docker-compose push                            # push服务镜像
docker-compose top                               # 显示各个容器内运行的进程
```



##### 2.例子

 [部署一个简单的springboot+vue项目：atc-script](..\..\..\assets\atc-script) 

```yml
version: '3'
services:
  atc-mysql:
    build:
      context: ./db
    environment:
      MYSQL_ROOT_HOST: "%"
      MYSQL_ROOT_PASSWORD: atc_123456 #root密码
    command: 
      --lower_case_table_names=1 #忽略大小写
    restart: always
    container_name: atc-mysql
    image: atc-mysql
    volumes:
      - /opt/mysql/data:/var/lib/mysql
      - /opt/mysql/log:/var/log/mysql
    ports:
      - 3306:3306
    networks:
      - atc_network

  atc-redis:
    image: redis:7.0.0
    ports:
      - 6379:6379
    restart: always
    hostname: atc-redis
    container_name: atc-redis
    networks:
      - atc_network

  atc-ui:
    build:
      context: ./nginx
    restart: always
    container_name: atc-ui
    image: atc-ui
    networks:
      - atc_network
    ports:
      - 80:80
      - 443:443

  atc-api:
    build:
      context: ./api
    restart: always
    ports:
      - 8080:8080
    container_name: atc-api
    hostname: atc-api
    image: atc-api
    networks:
      - atc_network
    volumes:
      - /opt/atc/upFiles:/opt/upFiles
      - /opt/atc/webapp:/opt/webapp
      - /opt/atc/logs:/logs
  
networks:
  atc_network:
    name: atc_network
    driver: bridge


# 如果使用已经创建的网络，不创建新网络
networks:
  my-pre-existing-network:
    external: true
```

- `version`: 用于定义版本
- `services`: 用于定义服务节点
  - `pig-mysql`:容器名称或者服务名称
  - `build.context`:用于执行dockerfile指定路径
  - `environment`: 设置容器中的环境变量
  - `restart: always`: 设置容器自动重启
  - `container_name`: 设置日期名称
  - `image`: 设置镜像名称
  - `networks`: 使用的网络
  - `volumes`: 用于映射本地和镜像文件,`:`前面是本地文件目录，`:`后面是镜像文件目录
  - `ports`: 映射宿主机和容器的端口号
  - `hostname`: 设置host名称，服务可以通过指定的`hostname`主机名来访问其他服务,需要`networks`设置同一个网络下
- `networks`: 设置网络
  - `spring_cloud_default`: 网络
    - `name:  spring_cloud_default`: 网络名称
    - `driver: bridge`:在上面的示例中，networks 字段用于定义网络配置，spring_cloud_default是网络的名称。而 driver: bridge 则是网络的驱动程序。Docker 提供了多种网络驱动程序，其中最常用的是 bridge 驱动程序。
