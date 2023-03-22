## cronolog日志分割

#### 介绍

> Linux下运行的Web服务，默认日志文件是不分割的，一个整文件既不易于管理，也不易于分析统计。安装cronolog后，可以将日志文件按时间分割

1. 安装

```shell
yum install cronolog
```

------

###### 问题出现: 可用软件包 nload。 错误：无须任何处理

yum没有找到对应依赖包，更新epel第三方软件库，运行命令：

```shell
yum install -y epel-release
```

------

2. 配合nohup

```shell
 nohup java -jar demo.jar 2>&1 | cronolog log/log.%Y-%m-%d_%H_%M.out >> /dev/null &
```

3. 时间格式

```
%Y: 年

%m: 月

%d: 日

%H: 时

%M: 分
```



