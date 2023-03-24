## ngrok内网穿透工具

#####  1.介绍

ngrok 是一个反向代理，通过在公共端点和本地运行的 Web 服务器之间建立一个安全的通道，实现内网主机的服务可以暴露给外网。ngrok 可捕获和分析所有通道上的流量，便于后期分析和重放，所以ngrok可以很方便地协助服务端程序测试。

#####  2.使用

```shell
#下载
git clone https://github.com/open-dingtalk/pierced.git
#启动服务(指定二级域名为'liuguofeng',端口为'8080')
ding -config=./ding.cfg -subdomain=liuguofeng 8080
```

