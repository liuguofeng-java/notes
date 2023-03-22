## linux 增加运行内存交换分区

##### 使用swap将硬盘当做内存使用，解决内存容量不足的问题

查看内存使用的状态:

```shell
free -h
```

#####  此时的Swap为0

创建一个分区文件（bs每块的大小，count文件有多少块，这里的swap就是2G）

```shell
dd if=/dev/zero of=/opt/swap bs=1M count=2048
```

##### 将/opt/swap文件设置为swap分区文件

```shell
mkswap /opt/swap
```

##### 直接激活可能会有提示为不安全的权限,建议进行swap文件的权限修改（改不改都可以）

```shell
chmod 600 /opt/swap 
```

##### 激活swap，启动分区交换文件

```shell
swapon /opt/swap
```


此时查看free -h


此时Swap就有了2G的空间

##### 查看swap

```shell
cat /proc/swaps
```


##### 停止swap分区

```shell
swapoff /opt/swap
```


##### 然后删除swap文件

```shell
rm -rf /opt/swap
```

