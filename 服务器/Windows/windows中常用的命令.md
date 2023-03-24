## windows中常用的命令

##### 1.查看端口占用情况,并根据端口结束掉进程

```shell
netstat -anto #查看端口占用
netstat -aon|findstr "8081" #查看具体端口
taskkill /f /t /im nginx.exe #结束进程
tasklist|findstr 'pid' #根据pid结束进程
```

##### 2.开启/关闭/删除windows服务

```shell
net start mysql #开启mysql服务
net stop mysql  #关闭mysql服务
sc del mysql #删除mysql服务
```

