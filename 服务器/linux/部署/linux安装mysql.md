## linux安装mysql

##### 1.下载mysql安装包

> https://downloads.mysql.com/archives/community/

##### 2.解压文件

```sh
# 解压文件
tar Jxvf mysql-8.3.0-linux-glibc2.17-x86_64.tar.xz

# 移动到指定目录
mv mysql-8.3.0-linux-glibc2.17-x86_64/ /usr/local/mysql/
```

##### 3.添加用户组和用户

```sh
groupadd mysql 
useradd -r -g mysql mysql
mkdir -p /usr/local/mysql/data
chown mysql:mysql -R /usr/local/mysql/data
```

##### 4.创建配置文件 `/usr/local/mysql/my.cnf`

```ini
[mysqld]
bind-address=0.0.0.0
port=3306
user=mysql
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock
log-error=/usr/local/mysql/data/mysql.err
pid-file=/usr/local/mysql/data/mysql.pid
#character config
character_set_server=utf8mb4
symbolic-links=0
explicit_defaults_for_timestamp=true
```

##### 5.初始化数据库

```sh
cd /usr/local/mysql/bin
./mysqld --defaults-file=/usr/local/mysql/my.cnf --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data --user=mysql --initialize
```

##### 6.查看密码 密码是`p53-4M!uyG.`

```sh
root@liuguofeng:/usr/local/mysql/bin# cat /usr/local/mysql/data/mysql.err
2024-06-26T03:17:54.257133Z 0 [System] [MY-015017] [Server] MySQL Server Initialization - start.
2024-06-26T03:17:54.257926Z 0 [Warning] [MY-011070] [Server] 'Disabling symbolic links using --skip-symbolic-links (or equivalent) is the default. Consider not using this option as it' is deprecated and will be removed in a future release.
2024-06-26T03:17:54.262876Z 0 [System] [MY-013169] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.3.0) initializing of server in progress as process 20760
2024-06-26T03:17:54.268847Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2024-06-26T03:17:54.531531Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2024-06-26T03:17:56.077469Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: :p53-4M!uyG.
2024-06-26T03:17:58.488054Z 0 [System] [MY-015018] [Server] MySQL Server Initialization - end.
```

##### 7.启动mysql服务

```sh
# 复制服务
cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

# 启动mysql服务
systemctl start mysql

# 开机自启动
systemctl enable mysql
```

##### 8.修改密码

> 开启免密码登陆 修改my.cnf文件   默认在/etc/my.cnf。
>
> vim /etc/my.cnf         在【mysqld】模块下面添加：skip-grant-tables 保存退出。

```sh
# 重启mysql服务
service mysql restart

# 登陆     
/usr/local/mysql/bin/mysql -u root -p
```

```sql
# 选择访问mysql库
use mysql

# 使root能再任何host访问
update user set host = '%' where user = 'root';

# 刷新
FLUSH PRIVILEGES; 

# 修改密码
ALTER USER "root"@"%" IDENTIFIED  BY "1234";

# 刷新
FLUSH PRIVILEGES; 

# 退出mysql
quit

# 把/etc/my.cnf免密删掉，重启服务
service mysql restart
```

