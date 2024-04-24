## Redis启动时警告

```sh
root@liuguofeng:/usr/local/bin# redis-server redis.conf
1524:C 24 Apr 2024 02:04:28.356 # WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
```

1.找到  **/etc/sysctl.conf**  文件，打开

2.在添加一行，保存：

```sh
vm.overcommit_memory = 1
```

3.要使更改生效

```sh
sysctl vm.overcommit_memory=1
```

