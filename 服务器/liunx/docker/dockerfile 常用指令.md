## dockerfile 常用指令

1. FROM

   指定基础（base）镜像，

2. MAINTAINER

   Author，对作者的简单描述，自定义。

3. COPY

   将文件或目录从 build context 复制到镜像

   如:`COPY py /home/py`把当`py`文件夹拷贝到容器的`/home/py`下面

4. ADD

   与 COPY 类似，复制文件到镜像，不同的是会自动解压文件

5. ENV

   设置环境变量，该变量可被后面的指令使用。

6. EXPOSE

   指定容器中的进程会监听的某个端口

7. VOLUME

   将文件或目录声明为 volume，同样 Docker 可以将该目录或文件映射出来。

8. WORKDIR

   设定工作目录,为后面的 RUN、CMD、ENTRYPOINT、ADD、COPY 指令设置镜像中的当前工作目录。

9. RUN

   使用命令`docker build`时执行命令

10. CMD

    启动容器时运行指定的命令，Dockerfile 中可以有多个 CMD 指令，但只有最后一个生效，如果 docker run 后面指定有参数，该参数将会替换 CMD 的参数。

11. ENTRYPOINT

    同样，在 Dockerfile 中可以有多个 ENTRYPOINT 指令，也是只有最后一个生效，但与 CMD 不同的是，CMD 或 docker run 之后的参数会被当作参数传给 ENTRYPOINT。

    如`ENTRYPOINT pip install lxml && pip install requests && pip install flask`可以执行多个命令,但是会从后往前执行

#### 实例

```dockerfile
#指定基础（base）镜像，
FROM python:3.9.14-buster

#指定作者
MAINTAINER liuguofeng

#指定工作目录
WORKDIR /home

#复制py文件到容器
COPY py /home/py

#指定端口
EXPOSE 8080

#打包时执行命令
RUN pip install --upgrade pip && pip install lxml && pip install requests && pip install flask

#运行时执行命令
ENTRYPOINT python /home/py/http_server.py
```

## 解决文件乱码

```dockerfile
#指定基础（base）镜像，
FROM centos:centos7

#指定作者
MAINTAINER liuguofeng

#指定工作目录
WORKDIR /home

#复制py文件到容器
COPY halo.jar /home

ADD jdk-11.0.12_linux-x64_bin.tar.gz /home

#指定端口
EXPOSE 8090

# 更新软件
RUN yum -y upgrade
# 安装中文包
RUN yum install -y kde-l10n-Chinese
# 重新安装glibc-common
RUN yum -y reinstall glibc-common
# 编译生成语言库
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
# 设置语言默认值为中文，时区改为东八区
RUN echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8 

# #运行时执行命令
ENTRYPOINT /home/jdk-11.0.12/bin/java -Dfile.encoding=UTF-8 -jar halo.jar


#docker run -d --name demo -p 8090:8090 -v /home/notes:/home/notes  h:v1
```

