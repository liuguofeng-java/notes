## nginx部署问题

##### 1.启动/关闭/重启nginx

```shell
start nginx #启动(常用)
nginx -s stop #快速停止nginx(常用)
nginx -s reload #重新加载配置(常用)
nginx -s quit #完整有序的停止nginx
nginx -s reopen #重新打开日志文件
```

##### 2.这块代码用来开启gzip,大流量的WEB站点常常使用gizp压缩技术来让用户感受更快的速度

```shell
 #gzip  on;
 gzip  on;# 开启gzip
 gzip_min_length 1k;# 启用gzip压缩的最小文件，小于设置值的文件将不会压缩
 gzip_buffers 32 4K; #  设置压缩所需要的缓冲区大小 
 gzip_comp_level 6; # gzip 压缩级别，1-9，数字越大压缩的越好，也越占用CPU时间
 gzip_types application/javascript text/css text/xml; # 类型
 #配置禁用gzip条件，支持正则。此处表示ie6及以下不启用gzip（因为ie低版本不支持）
 gzip_disable "MSIE [1-6]\."; # 禁用IE 6 gzip
 gzip_vary on; # 是否在http header中添加Vary: Accept-Encoding，建议开启
```

##### 3.指定前端项目目录`如:vue打包后端dist文件`和入口文件

```shell
location / {
	#网站主页路径。此路径仅供参考，具体请您按照实际目录操作。
    #例如，您的网站运行目录在/etc/www下，则填写/etc/www。
    root html/dist;
    try_files $uri $uri/ /index.html; 
    index  index.html index.htm;
}
```

##### 4./api 是后端api接口地址,nginx代理到配置的端口下(主要防止前端跨域问题)

```csharp
location /api {
	 	rewrite ^/api(.*) /$1 break; #过滤掉接口前缀
   		proxy_pass  http://192.168.0.1:8080; # 后端接口地址，
}
```

##### 5.nginx配置文件

```shell
#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    client_max_body_size 1024m;
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;
    gzip  on;# 开启gzip
    gzip_min_length 1k;# 启用gzip压缩的最小文件，小于设置值的文件将不会压缩
    gzip_buffers 32 4K; #  设置压缩所需要的缓冲区大小 
    gzip_comp_level 6; # gzip 压缩级别，1-9，数字越大压缩的越好，也越占用CPU时间
    gzip_types application/javascript text/css text/xml; # 类型
    #配置禁用gzip条件，支持正则。此处表示ie6及以下不启用gzip（因为ie低版本不支持）
    gzip_disable "MSIE [1-6]\."; # 禁用IE 6 gzip
    gzip_vary on; # 是否在http header中添加Vary: Accept-Encoding，建议开启
	
	
    server {
		client_max_body_size 1024m;
        #SSL 访问端口号为 443
        listen 443 ssl; 
        #填写绑定证书的域名
        server_name liuguofeng.top; 
        #证书文件名称
        ssl_certificate liuguofeng.com_bundle.crt; 
        #私钥文件名称
        ssl_certificate_key liuguofeng.top.key; 
        ssl_session_timeout 5m;
        #请按照以下协议配置
        ssl_protocols TLSv1.2; 
        #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;
        location / {
           #网站主页路径。此路径仅供参考，具体请您按照实际目录操作。
           #例如，您的网站运行目录在/etc/www下，则填写/etc/www。
            root html/dist;
    	    try_files $uri $uri/ /index.html; 
            index  index.html index.htm;
        }
		location ^~/api/ {
			client_max_body_size 1024m;
			rewrite ^/api/(.*) /$1 break; # 过滤掉接口前缀
			proxy_pass  http://1.14.26.101:8888/; # 后端接口地址，
		}
		
		location /admin {
			#如果不是根目录/ 如果/admin,要把root 替换传alias 否则会404,并且vue中路由也要改变
            alias /usr/share/nginx/html/dist; 
            try_files $uri $uri/ /index.html; 
            index  index.html index.htm;
        }
		
		error_page  404  /404.html;
        location = /404.html {
            root   html/404;
        }
    }

    server {
		listen 80;
		#填写绑定证书的域名
		server_name liuguofeng.top; 
		#把http的域名请求转成https
		return 301 https://$host$request_uri; 
    }

}
```
