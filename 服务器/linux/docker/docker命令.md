## docker命令

##### 1.帮助命令

```shell
docker info #查看docker系统信息
docker version #查看docker版本
docker -hple #帮助文档
```

##### 2.镜像命令

```shell
docker images #查看所有容器
docker search nginx #查找命令  https://registry.hub.docker.com/
docker pull nginx:1.19 #指定版本 1.19 可以在dockerhub上查看
docker rmi 镜像id #删除镜像
```

##### 3.容器命令

```shell
docker run 
        -p #指定端口
        -d #后台运行
        -it #交互模式
        --name #指定容器名字
        -v 主机路径:镜像路径 #挂载路径，如:docker run -it  -p 8080:8080 -v /home/webapps:/usr/local/tomcat/webapps --name tomcat03 -d tomcat:9.0.45-jdk8-corretto
docker ps
        -a #查出全部默认查出运行的容器
docker rm 容器id  #删除容器
docker start 容器id #启动容器
docker stop 容器id #停止容器
docker restart 容器id #重启容器
docker kill 容器id #强制停止容器

docker logs 容器id
        -f #动态打印日志
        --tail 10 #打印后10条数据
docker top 容器id  #查看容器内进程
docker exec -it 容器id /bin/bash #进入容器
docker attach 容器id #进入容器运行目录
docker cp 容器id:容器路径 linux路径 #把容器文件拷贝到linux内 如 docker cp 8da5eed17170:/etc/nginx/nginx.conf /home/

docker stats #查看容器cpu占用率

#如:docker commit -a "liuguofeng" -m "add tomcat" 5994575143d6 tomcat01_commit:0.0.1
docker commit -m="描述信息" -a="作者" 容器id 目标镜像名:[版本TAG] #打包镜像命令 

#开机自启,新建容器时配置自启参数
docker run --restart=always 容器id 或 容器名称
#开机自启,已存在的容器配置自启
docker update --restart=always 容器id 或 容器名称

#查看-v挂载的信息
docker inspect ab20 | grep Mounts -A 50

#打包dockerfile
docker build -t springboot_demo:v1 .

#将正在运行的容器打包为镜像
docker commit  nginx  nginx:wlx

#将此镜像保存为文件
docker save -o nginx.tar nginx:wlx

# 加载还原镜像
docker load -i nginx.tar 
```
