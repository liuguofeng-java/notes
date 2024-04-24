## redis安装与配置

##### 1.安装gcc

```sh
# ubuntu
apt update
apt install make
apt install gcc
apt install libsystemd-dev
# centos
yum install -y gcc-c++
```

##### 2.下载源码并编译

> - **github:**https://github.com/redis/redis
>
> - **releases:**https://github.com/redis/redis/releases

1. 下载源码

   ```sh
   wget https://github.com/redis/redis/archive/refs/tags/7.2.4.tar.gz
   ```

2. 解压文件

   ```sh
   tar -zxvf redis-7.2.4.tar.gz
   ```

3. 进入目录并编译

   ```sh
   cd redis-7.2.4/
   make && make install
   ```

##### 3.redis默认安装目录

```sh
root@liuguofeng:/usr/local/bin# ll
total 30060
drwxr-xr-x  2 root root     4096 Apr 23 02:29 ./
drwxr-xr-x 10 root root     4096 Feb 16 18:37 ../
-rwxr-xr-x  1 root root  7080040 Apr 23 02:29 redis-benchmark*
lrwxrwxrwx  1 root root       12 Apr 23 02:29 redis-check-aof -> redis-server*
lrwxrwxrwx  1 root root       12 Apr 23 02:29 redis-check-rdb -> redis-server*
-rwxr-xr-x  1 root root  7404240 Apr 23 02:29 redis-cli*
lrwxrwxrwx  1 root root       12 Apr 23 02:29 redis-sentinel -> redis-server*
-rwxr-xr-x  1 root root 16283200 Apr 23 02:29 redis-server*
```

- 默认安装目录：`/usr/local/bin`

- **redis-benchmark**:性能测试工具，服务启动后运行该命令

- **redis-check-aof**:修复有问题的AOF文件

- **redis-check-dump**:修复有问题的dump.rdb文件

- **redis-cli**:客户端操作入口

- **redis-sentinel**:redis集群使用

- **reids-server**:redis服务器启动命令，用`redis-server /usr/local/redis/redis.conf`来启动redis

##### 4.配置文件

1. `bind`:默认情况下 `bind=127.0.0.1` 只能接受本机的访问请求。在不写的情况下，无限制接受任何 IP 地址的访问,一般注掉

   ```sh
   # bind 192.168.1.100 10.0.0.1     # listens on two specific IPv4 addresses
   # bind 127.0.0.1 ::1              # listens on loopback IPv4 and IPv6
   # bind * -::*                     # like the default, all available interfaces
   #
   # ~~~ WARNING ~~~ If the computer running Redis is directly exposed to the
   # internet, binding to all the interfaces is dangerous and will expose the
   # instance to everybody on the internet. So by default we uncomment the
   # following bind directive, that will force Redis to listen only on the
   # IPv4 and IPv6 (if available) loopback interface addresses (this means Redis
   # will only be able to accept client connections from the same host that it is
   # running on).
   #
   # IF YOU ARE SURE YOU WANT YOUR INSTANCE TO LISTEN TO ALL THE INTERFACES
   # COMMENT OUT THE FOLLOWING LINE.
   #
   # You will also need to set a password unless you explicitly disable protected
   # mode.
   # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   bind 127.0.0.1 -::1
   ```

2. `protected-mode`: 默认yes, 本机访问保护模式,一般关闭

   ```sh
   # Protected mode is a layer of security protection, in order to avoid that
   # Redis instances left open on the internet are accessed and exploited.
   #
   # When protected mode is on and the default user has no password, the server
   # only accepts local connections from the IPv4 address (127.0.0.1), IPv6 address
   # (::1) or Unix domain sockets.
   #
   # By default protected mode is enabled. You should disable it only if
   # you are sure you want clients from other hosts to connect to Redis
   # even if no authentication is configured.
   protected-mode yes
   ```

3. `daemonize`:是否为后台进程，即守护进程，用于后台启动，默认no，一般yes

   ```sh
   # By default Redis does not run as a daemon. Use 'yes' if you need it.
   # Note that Redis will write a pid file in /var/run/redis.pid when daemonized.
   # When Redis is supervised by upstart or systemd, this parameter has no impact.
   daemonize no
   ```

4. `requirepass`:设置密码

   ```sh
   # Using an external ACL file
   #
   # Instead of configuring users here in this file, it is possible to use
   # a stand-alone file just listing users. The two methods cannot be mixed:
   # if you configure users here and at the same time you activate the external
   # ACL file, the server will refuse to start.
   #
   # The format of the external ACL user file is exactly the same as the
   # format that is used inside redis.conf to describe users.
   #
   # aclfile /etc/redis/users.acl
   
   # IMPORTANT NOTE: starting with Redis 6 "requirepass" is just a compatibility
   # layer on top of the new ACL system. The option effect will be just setting
   # the password for the default user. Clients will still authenticate using
   # AUTH <password> as usually, or more explicitly with AUTH default <password>
   # if they follow the new protocol: both will work.
   #
   # The requirepass is not compatible with aclfile option and the ACL LOAD
   # command, these will cause requirepass to be ignored.
   #
   requirepass 123456
   ```

   



