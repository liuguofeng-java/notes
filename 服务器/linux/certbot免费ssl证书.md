## certbot免费ssl证书

##### 1. 安装

> Certbot 是一个用于获取和管理 HTTPS/TLS 证书的工具，主要用于自动化 Let's Encrypt 证书的签发和部署过程

1.  Debian 或 Ubuntu

   ```sh
   sudo apt-get update && sudo apt-get install certbot
   ```

2. CentOS 

   ```sh
   yum install certbot
   ```

##### 2.部署

1. 手动部署:**(注意:网站需要写全域名如：www.liuguofeng.top，不能省去www)**

   ```sh
   certbot certonly --standalone -d yourdomain.com
   ```

   - 当 Certbot 成功生成证书后，证书和相关文件（如私钥、证书链）会被保存在系统默认的位置。在 Linux 系统中，一般会保存在`/etc/letsencrypt/live/yourdomain.com/`目录下。
   - 其中，`privkey.pem`是私钥文件，`fullchain.pem`是包含证书和证书链的文件。这些文件在后续手动配置服务器使用证书时会用到。

2. Nginx 服务器手动配置示例

   ```nginx
   listen 443 ssl;
   ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
   ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;
   ```

   