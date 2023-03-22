## MySQL.zip安装

#### 1.官网下载MySQL8.0.15

> 直达官网下载Community版：https://dev.mysql.com/downloads/mysql/

#### 2.解压安装mysql.zip包

#### 3.在解压好mysql包根目录先新建`my.ini`文件,并写入以下参数

```shell
[mysql]
# 设置mysql客户端默认字符集
default-character-set = utf8
[mysqld]
#设置端口
port = 3306
# 设置mysql的安装目录
basedir = d:\\mysql 
# 设置mysql数据库的数据的存放目录
datadir = d:\\mysql\\data
# 允许最大连接数
max_connections = 200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server = utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine = INNODB
# 超时时间
default_password_lifetime=0
# 解决字段过多报错问题
innodb_file_per_table=1
innodb_file_format=Barracuda
innodb_file_format_check = ON
innodb_log_file_size = 512M
innodb_strict_mode = 0
#搞不清
default_authentication_plugin=mysql_native_password
# 跳过密码
skip-grant-tables
#忽略大小写
lower_case_table_names=1
```

#### 4.在mysql下的bin目录执行以下命令(以管理员运行)

```shell
mysqld --initialize --user=mysql --console #安装MySQL获取密码
mysqld --install #安装MySQL服务
net start mysql #启动MySQL服务
```

#### 5.修改密码

```sql
#修改密码
SET PASSWORD = PASSWORD('123456') 
#或：
update mysql.user set authentication_string=password('123456') where user='root' 
```

> 注意:安装完成后去掉`my.ini`中的`skip-grant-tables`否则不用密码也会登录到数据库

