## window 下安装Redis

#### 1.下载

windows版本 https://github.com/MicrosoftArchive/redis/tags

#### 2.打开cmd 窗口，进入redis 目录

#### 3.输入命令

```shell
redis-server --service-install redis.windows.conf --loglevel verbose
```

#### 4.启动服务

```shell
redis-server --service-start
```

#### 5.停止服务

```shell
redis-server --service-stop
```

#### 6.设置密码

```shell
config set requirepass 123456
```



