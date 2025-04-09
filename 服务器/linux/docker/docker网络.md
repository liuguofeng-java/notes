## docker网络

##### 1、Docker网络模式简介

> docker可以为在容器创建隔离的网络环境，在隔离的网络环境下，容器具有完全独立的网络栈，与宿主机隔离，也可以使容器共享主机或者其他容器的网络命名空间，基本可以满足开发者在各种场景下的需要。按docker官方的说法，docker容器的网络有五种模式：

| 网络模式           | 简介                                                         |
| ------------------ | ------------------------------------------------------------ |
| Bridge（默认模式） | 此模式会为每一个容器分配、设置IP等，并将容器连接到一个docker0虚拟网桥，通过docker0网桥以及Iptables nat表配置与宿主机通信。 |
| Host               | 容器将不会虚拟出自己的网卡，配置自己的IP等，而是使用宿主机的IP和端口。 |
| Container          | 创建的容器不会创建自己的网卡，配置自己的IP，而是和一个指定的容器共享IP、端口范围。(不常用) |
| None               | 该模式关闭了容器的网络功能，与宿主机、与其他容器都不连通的.  |

##### 2、默认网络

> 当你安装Docker时，它会自动创建三个网络（bridge、host、none），你可以使用以下**docker network ls**命令列出这些网络：

```sh
root@lavm-qr38c7b06s:~# docker network ls
NETWORK ID     NAME               DRIVER    SCOPE
568ce576e7bd   bridge             bridge    local
4dfdf0168e04   host               host      local
e861dd701fbb   none               null      local
```

##### 3.指定网络

>  我们在使用docker run创建Docker容器时，可以用 –net 选项指定容器的网络模式，Docker可以有以下4种网络模式：

- bridge模式：使用 --net=bridge 指定，默认设置
- host模式：使用 --net=host 指定。
- none模式：使用 --net=none 指定。
- container模式：使用 --net=container:NAME_or_ID 指定。

##### 4.自定义网络(常用)

> ###### 为什么要用自定义网络？
>
> - **隔离性**：不同网络中的容器默认无法直接通信，增强安全性。
>
> - **DNS 自动解析**：同一网络内的容器可通过容器名（或别名）直接通信，无需手动配置 IP。并且不用-p暴露端口可以直接访问同一网络的端口
>
> - **多网络支持**：一个容器可加入多个网络，适用于复杂场景（如同时连接前端和后端服务）。

###### 1.例如创建一个网络

```sh
# 创建一个网络名为localnet
docker network create -d bridge localnet
```

###### 2.运行容器并加入自定义网络

```sh
# 运行一个 Nginx 容器并加入 localnet 网络
docker run -d --name web --network localnet nginx

# 运行另一个容器并测试与 web 容器的通信（输出Nginx index.html内容）
docker run -it --rm --network localnet alpine curl http://web
```

##### 5.常用命令

```sh
# 列出运行在本地 docker 主机上的全部网络
docker network ls
# 提供 Docker 网络的详细配置信息
docker network inspect <NETWORK_NAME>
# 创建新的单机桥接网络，名为 localnet，其中 -d 不指定的话，默认是 bridge 驱动
docker network create -d bridge localnet
# 删除 Docker 主机上指定的网络
docker network rm
# 删除主机上全部未使用的网络
docker network prune
# 将名为 nginx-container 的容器连接到 localnet
docker network connect localnet nginx-container
# 断开容器与网络的连接
docker network disconnect localnet nginx-container
```







