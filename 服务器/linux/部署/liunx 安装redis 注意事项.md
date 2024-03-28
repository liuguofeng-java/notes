## liunx安装redis

##### 1. 下载并解压.gz包

##### 2. 编译并安装

   ```shell
   make 
   make install DESTDIR= /home/user/zws/build
   ```

##### 3. 修改配置文件redis.conf

   ```shell
   #bind 127.0.0.1 -::1 注释 bind
   
   protected-mode no 关闭protected-mode模式，此时外部网络可以直接访问
   
   requirepass lbf123 设置密码
   ```

##### 4. 启动redis ，并指定文件 ，'&' 后台运行

   ```
   /home/redis-6.2.3/src/redis-server /home/redis-6.2.3/redis.conf &
   ```

   

