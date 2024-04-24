## Redis主从复制

#####  1.Redis 主从复制的意义

- `提高系统的可靠性`主从复制可以将数据备份到多个节点上，当主节点出现故障时，可以快速切换到从节点上，保证系统的高可用性和可靠性。

- `减轻主节点的负载`主从复制可以实现读写分离，从节点可以承担一部分读操作的负载，减轻主节点的压力，提高系统的性能。

- `数据的容灾备份`主从复制可以将数据备份到多个节点上，当节点出现故障时，可以快速恢复数据，保证数据的安全性和完整性。

- `数据的分布式处理`主从复制可以将数据分布到多个节点上，实现数据的分布式处理，提高系统的并发性能和处理能力。

- `数据的实时同步`主从复制可以实现数据的实时同步，保证数据的一致性，提高系统的稳定性和可靠性。

##### 2.准备三台服务器（一主二从）

```sh
192.168.0.60 master
192.168.0.61 slave
192.168.0.62 slave
```

##### 3.配置文件

1. `master` 配置文件redis.conf

   ```sh
   # 设置当前redis后台运行，其实是设置为守护线程
   daemonize yes
   # 全部ip都能访问
   bind 0.0.0.0
   # 配置密码
   requirepass 123456
   # 日志文件名称
   logfile ./redis.log
   # pid文件
   pidfile ./redis.pid
   ```

2. 设置两个`slave`配置文件

   ```sh
   daemonize yes
   bind 0.0.0.0
   requirepass 123456
   pidfile ./redis.pid
   logfile ./redis.log
   #用来指定主机：旧版本：slaveof 主机ip 端口，新版本：replicaof 主机ip 端口 
   replicaof 192.168.0.60 6379
   #主机的密码
   masterauth 123456
   ```

3. 启动三台`redis`查看信息

   ```sh
   # master信息
   127.0.0.1:6379> info Replication
   # Replication
   role:master
   connected_slaves:2
   slave0:ip=192.168.0.61,port=6379,state=online,offset=714,lag=1
   slave1:ip=192.168.0.62,port=6379,state=online,offset=714,lag=1
   master_failover_state:no-failover
   master_replid:b910bcee0bb179efef1406f579e9d7e8040da267
   master_replid2:0000000000000000000000000000000000000000
   master_repl_offset:714
   second_repl_offset:-1
   repl_backlog_active:1
   repl_backlog_size:1048576
   repl_backlog_first_byte_offset:1
   repl_backlog_histlen:714
   
   # slave信息
   127.0.0.1:6379> info Replication
   # Replication
   role:slave
   master_host:192.168.0.60
   master_port:6379
   master_link_status:up
   master_last_io_seconds_ago:11
   master_sync_in_progress:0
   slave_read_repl_offset:210
   slave_repl_offset:210
   slave_priority:100
   slave_read_only:1
   replica_announced:1
   connected_slaves:0
   master_failover_state:no-failover
   master_replid:b910bcee0bb179efef1406f579e9d7e8040da267
   master_replid2:0000000000000000000000000000000000000000
   master_repl_offset:210
   second_repl_offset:-1
   repl_backlog_active:1
   repl_backlog_size:1048576
   repl_backlog_first_byte_offset:15
   repl_backlog_histlen:196
   ```

   