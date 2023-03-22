## contos安装nginx

1. nginx 使用c语言编程，安装nginx必须先编译，编译的话需要安装gcc,如果没有的话必须安装

   ```shell
   yum install -y gcc-c++
   ```

2. nginx 还依赖于 pcre 和 zlib 、openSSL

   ```shell
   yum install -y pcre pcre-devel
   yum install -y zlib zlib-devel
   yum install -y openssl openssl-devel
   ```

3. 下载nginx

   ```shell
   wget https://nginx.org/download/nginx-1.12.0.tar.gz
   ```

4. 解压

   ```shell
   tar -zxvf nginx-1.12.0.tar.gz
   ```

5. 配置nginx,进入解压好的文件夹执行以下命令

   ```shell
   ./configure 或 ./configure --prefix=/usr/local/nginx
   ```

6. 安装https认证模块（上文未安装这个导致使用https协议保存）：

   ```shell
   ./configure --with-http_ssl_module
   ```

7. 编译并安装nginx,安装完成一般会在/usr/local目录下可以使用，whereis nginx命令查看安装路径

   ```shell
   make && make install
   ```

8. 启动、停止、重启

   ```shell
   cd /usr/local/nginx/sbin/
   ./nginx #启动
   ./nginx -s stop #停止
   ./nginx -s quit #停止
   ./nginx -s reload #重启
   ps aux|grep nginx #查看进程
   ```

9. 开放端口

   ```shell
   firewall-cmd --query-port=8099/tcp #查看端口是否开放
   firewall-cmd --add-port=8099/tcp --permanent #开放8099端口
   firewall-cmd --reload #重新载入配置
   firewall-cmd --remove-port=8099/tcp --permanent #关闭开放端口
   ```

   

