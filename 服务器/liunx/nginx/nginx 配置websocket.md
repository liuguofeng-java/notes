## nginx 配置websocket

> 介绍
> WebSocket 协议与 HTTP 协议不同，但 WebSocket 握手与 HTTP 兼容，使用 HTTP 升级工具将连接从 HTTP 升级到 WebSocket。这允许 WebSocket 应用程序更容易地适应现有的基础架构。例如，WebSocket 应用程序可以使用标准 HTTP 端口80和443，从而允许使用现有的防火墙规则。

##### 1.nginx 配置
出现报错时的配置

```json
location /ws {
    proxy_set_header  Host $host;
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X-Forwarded-Proto   $scheme;
    proxy_pass        http://127.0.0.1:9000/ws;
}     
```

##### 2.反向代理成功的配置

```json
location /ws {
    proxy_set_header  Host $host;
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X-Forwarded-Proto   $scheme;
    proxy_pass        http://127.0.0.1:9000/ws;
    
    # 关键配置 start
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    # 关键配置 end

}         
```

