## nginx 一个端口部署多个vue项目

##### 1.nginx 相关位置代码：

```json
server {
        listen       80;
        server_name  localhost;
        add_header 'Access-Control-Allow-Origin' '*';
        client_max_body_size 500m; 　　　　 #第一个项目
        location / {
            root X:/xx/xxx/client;
            index  index.html;
        }　　　　 #第二个项目　
        location /admin {
           alias  X:/xx/xxx/admin;
        }
        error_page  404       /404.html;
    }
}
```

##### 2. vue 配置文件设置

> client 文件所属项目不需要进行额外的配置，admin 文件所属项目需要对 vue.config.js 以及router/index.js 进行一些处理。

1. vue.config.js 

   ```js
   module.exports = {
     publicPath: "/admin",  //名称随意，但是需要与 nginx.conf 中的名称一致
   }
   ```

2. router/index.js

   ```js
   const createRouter = () =>
     new Router({
       scrollBehavior: () => ({
         y: 0,
       }),
       base: "/admin", //名称随意，但是需要与 nginx.conf 中的名称一致
       routes: constantRoutes,
     });
   ```

   

