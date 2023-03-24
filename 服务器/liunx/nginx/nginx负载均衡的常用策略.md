## Nginx负载均衡的常用策略

##### 1. 轮询（默认）

> 每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务宕掉，能自动删除。
>
> weight
>
> weight代表权重，默认为1，权重越高被分配的客户端越多。
>

```csharp
upstream myserver {
   	server 127.0.0.1:8080 weight=10; 
   	server 127.0.0.1:8081 weight=5;
}
```

##### 2. ip_hash

> 每个请求按访问ip的hash结果分配，这样每个访问者固定访问一个后端服务器，可以解决session的问题。

```csharp
upstream myserver {
	ip_hash;
   	server 127.0.0.1:8080; 
   	server 127.0.0.1:8081;
}
```

##### 3. least_conn

> 把请求转发给连接数较少的后端服务器。轮询算法是把请求平均的转发给各个后端，使它们的负载大致相同；但是，有些请求占用的时间很长，会导致其所在的后端负载较高。这种情况下，least_conn这种方式就可以达到更好的负载均衡效果。

```csharp
upstream myserver {
	least_conn;
   	server 127.0.0.1:8080; 
   	server 127.0.0.1:8081;
}
```

