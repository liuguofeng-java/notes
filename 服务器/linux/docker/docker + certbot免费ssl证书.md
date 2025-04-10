## docker + certbot免费ssl证书

##### 1. 介绍

`certbot `是一个用于获取和管理 HTTPS/TLS 证书的工具，主要用于自动化 Let's Encrypt 证书的签发和部署过程

`certbot`的命令有很多种不同的参数，这些参数也主要是为了自动生成http验证文件或自动添加dns解析等功能，主要的大体说下：

- `--nginx` ，走http验证，如果不用`docker`且用nginx感觉是最方便的，会自动修改nginx的配置文件，增加http请求的访问配置及后续的ssl配置，但由于我们`certbot`是在`docker`容器内，所以要修改另一个`nginx`容器的配置文件及控制启停不太好实现，所以不采用这种方式。查资料时发现有人会将`nginx` 和 `certbot`通过`dockerfile`打包到一个镜像内，这样此命令就比较方便的执行了，感觉是个好办法，但个人没有测试了解。
- `--standalone`，走http验证，这种方式你就算是没有`nginx`等服务，仍然可以验证域名并获取证书，它会虚拟一个服务来进行验证，但需要保证你的`80`端口别被占用，由于我这边有`nginx`了，所以便没有用此类方法测试。
- `--webroot`，走http验证，已有类似nginx等服务的情况下可以用此方法，会自动在你配置的目录下生成http验证文件，与`standalone`相比好处是不需要预留80端口，也就是原有的网站不需要停止就可以申请证书，而缺点就是你还需要在`nginx`等服务中手动配置`/.well-known/acme-challenge/`使其对应到自动生成的验证文件上。后续我们用的就是这种。

##### 1.docker安装nginx

参考[docker安装nginx](./docker安装nginx.md)

> 其中 **-v /home/nginx/www:/usr/share/nginx/www**：用于`certbot`验证域名

```sh
docker run -d --restart=always --name nginx -p 80:80 -p 443:443 \
-v /home/nginx/conf:/etc/nginx \
-v /home/nginx/html:/usr/share/nginx/html \
-v /home/nginx/www:/usr/share/nginx/www \
nginx:1.26.3
```

##### 2.修改配置文件

```nginx
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;
    client_max_body_size 1024m;
    
    #配置http验证可访问
    location /.well-known/acme-challenge {
        #对应宿主机volumes中的http验证目录，而宿主机的又与certbot容器中命令--webroot-path指定目录一致
        root /usr/share/nginx/www/;
    }
    
    location / {
       root   /usr/share/nginx/html/dist;
              try_files $uri $uri/ /index.html;
        index  index.html index.htm;
    }
}
```

##### 3.启动certbot获取证书

```sh
docker run -it --rm   \
 -v /home/nginx/www:/data/letsencrypt  \
 -v /home/nginx/conf/ssl:/etc/letsencrypt  \
 -v /home/nginx/certbot/logs:/var/log/letsencrypt \
 certbot/certbot certonly -n --webroot --webroot-path=/data/letsencrypt -m 邮箱@qq.com --agree-tos -d "www.域名.cn"  
```

- **-v /home/nginx/www:/data/letsencrypt**：用于`certbot`验证签名
- **-v /home/nginx/conf/ssl:/etc/letsencrypt**：映射证书颁发目录
- **-v /home/nginx/certbot/logs:/var/log/letsencrypt**：`certbot`日志

##### 4.配置ssl证书

```nginx
server {
    client_max_body_size 1024m;
    listen 443 ssl;
    server_name test.liuguofeng.online;
    # 启动nginx映射的ssl目录，要和certbot证书生成目录一致
    ssl_certificate /etc/nginx/ssl/live/test.liuguofeng.online/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/test.liuguofeng.online/privkey.pem;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;

    location / {
       root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

##### 5.使用**crontab**自动续签

> Let's Encrypt 证书默认有效期 **90 天**，Certbot 仅在到期前 **30 天** 自动续期。若证书有效期剩余超过 30 天，续期操作会被跳过

1. 新建**/home/nginx/certbot.renew_cert.sh**

   ```sh
   echo -e "\n[$(date +'%Y-%m-%d %H:%M:%S')] 脚本启动"
   
   # 换证书
   docker run --rm   \
    -v /home/nginx/www:/data/letsencrypt  \
    -v /home/nginx/conf/ssl:/etc/letsencrypt  \
    -v /home/nginx/certbot/logs:/var/log/letsencrypt \
    certbot/certbot certonly -n --webroot --webroot-path=/data/letsencrypt -m 邮箱@qq.com --agree-tos -d "www.域名.cn"  
   
   # 重新启动nginx
   docker restart nginx
   ```

2. 使用**crontab -e**编辑`crontab`配置文件，并添加如下内容

   ```sh
   # 定时10天0点执行，并把执行结果输出到cron.log
   0 0 */10 * * /home/nginx/certbot/renew_cert.sh >> /home/nginx/certbot/cron.log 2>&1
   ```

   