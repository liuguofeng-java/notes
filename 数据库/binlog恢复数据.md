## binlog恢复数据

- binlog 是一种逻辑日志，他里边所记录的是一条 SQL 语句的原始逻辑，例如给某一个字段 +1，注意这个区别于 redo log 的物理日志（在某个数据页上做了什么修改）。

- binlog 文件写满后，会自动切换到下一个日志文件继续写，而不会覆盖以前的日志，这个也区别于 redo log，redo log 是循环写入的，即后面写入的可能会覆盖前面写入的。

- 一般来说，我们在配置 binlog 的时候，可以指定 binlog 文件的有效期，这样在到期后，日志文件会自动删除，这样避免占用较多存储空间。

#### 1.开启binlog

> 使用`show variables like '%log_bin%'`查看是否开启binlog; `log_bin=OFF `就表示 binlog 是一个关闭状态

```sql
mysql> show variables like '%log_bin%';
+---------------------------------+-------+
| Variable_name                   | Value |
+---------------------------------+-------+
| log_bin                         | OFF   |
| log_bin_basename                |       |
| log_bin_index                   |       |
| log_bin_trust_function_creators | OFF   |
| log_bin_use_v1_row_events       | OFF   |
| sql_log_bin                     | ON    |
+---------------------------------+-------+
6 rows in set (0.10 sec)
```

> 开启 binlog 在 MySQL 的配置文件 mysqld.cnf 下的`[mysqld]`的节点下配置:

```shell
# 这个参数表示启用 binlog 功能，并指定 binlog 的存储目录
log-bin=binlog

# 设置一个 binlog 文件的最大字节
# 设置最大 100MB
max_binlog_size=104857600

# 设置了 binlog 文件的有效期（单位：天）
expire_logs_days = 7

# binlog 日志只记录指定库的更新（配置主从复制的时候会用到）
#binlog-do-db=binlog

# binlog 日志不记录指定库的更新（配置主从复制的时候会用到）
#binlog-ignore-db=javaboy_no_db

# 写缓存多少次，刷一次磁盘，默认 0 表示这个操作由操作系统根据自身负载自行决定多久写一次磁盘
# 1 表示每一条事务提交都会立即写磁盘，n 则表示 n 个事务提交才会写磁盘
sync_binlog=0

# 为当前服务取一个唯一的 id（MySQL5.7 之后需要配置）
server-id=1
```

> 配置完成重启mysql服务;再次执行 `show variables like 'log_bin%';` 即可看到 binlog 已经开启了。

```sql
mysql> show variables like '%log_bin%';
+---------------------------------+----------------------------------------------------+
| Variable_name                   | Value                                              |
+---------------------------------+----------------------------------------------------+
| log_bin                         | ON                                                 |
| log_bin_basename                | D:\software\mysql-5.7.27-winx64\data\binlogs       |
| log_bin_index                   | D:\software\mysql-5.7.27-winx64\data\binlogs.index |
| log_bin_trust_function_creators | OFF                                                |
| log_bin_use_v1_row_events       | OFF                                                |
| sql_log_bin                     | ON                                                 |
+---------------------------------+----------------------------------------------------+
6 rows in set (0.06 sec)
```

#### 2.操作binlog

1.使用` show master logs;`命令,查看所有 binlog 日志

```sql
mysql> show master logs;
+----------------+-----------+
| Log_name       | File_size |
+----------------+-----------+
| binlogs.000001 |      6801 |
| binlogs.000002 |       154 |
+----------------+-----------+
2 rows in set (0.07 sec)
```

2.查看 master 状态,这个命令我们在搭建 MySQL 主从的时候经常会用到：

```sql
mysql> show master status;
+----------------+----------+--------------+------------------+-------------------+
| File           | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+----------------+----------+--------------+------------------+-------------------+
| binlogs.000002 |      154 |              |                  |                   |
+----------------+----------+--------------+------------------+-------------------+
1 row in set (0.11 sec)
```

3.查看 binlog,由于 binlog 是二进制日志文件，要使用mysql命令打开:

```sql
show binlog events [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count];
```

- log_name：可以指定要查看的 binlog 日志文件名，如果不指定的话，表示查看最早的 binlog 文件。
- pos：从哪个 pos 点开始查看，凡是 binlog 记录下来的操作都有一个 pos 点，这个其实就是相当于我们可以指定从哪个操作开始查看日志，如果不指定的话，就是从该 binlog 的开头开始查看。
- offset：这是是偏移量，不指定默认就是 0。
- row_count：查看多少行记录，不指定就是查看所有。

例如:

```sql
mysql> show binlog events in 'binlogs.000002';
+----------------+------+----------------+-----------+-------------+---------------------------------------+
| Log_name       | Pos  | Event_type     | Server_id | End_log_pos | Info                                   
+----------------+------+----------------+-----------+-------------+---------------------------------------+
| binlogs.000002 |    4 | Format_desc    |         1 |         123 | Server ver: 5.7.27-log, Binlog ver: 4   
| binlogs.000002 |  123 | Previous_gtids |         1 |         154 |                                         
| binlogs.000002 |  154 | Anonymous_Gtid |         1 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'   
| binlogs.000002 |  219 | Query          |         1 |         298 | BEGIN                                   
| binlogs.000002 |  298 | Table_map      |         1 |         401 | table_id: 99 (recruitment.sys_oper_log) 
| binlogs.000002 |  401 | Delete_rows    |         1 |        2625 | table_id: 99 flags: STMT_END_F         
| binlogs.000002 | 2625 | Xid            |         1 |        2656 | COMMIT /* xid=8 */                     
| binlogs.000002 | 2656 | Anonymous_Gtid |         1 |        2721 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'   
| binlogs.000002 | 2721 | Query          |         1 |        2800 | BEGIN                                  
| binlogs.000002 | 2800 | Table_map      |         1 |        2903 | table_id: 99 (recruitment.sys_oper_log)
| binlogs.000002 | 2903 | Delete_rows    |         1 |        5127 | table_id: 99 flags: STMT_END_F         
| binlogs.000002 | 5127 | Xid            |         1 |        5158 | COMMIT /* xid=11 */                     
+----------------+------+----------------+-----------+-------------+---------------------------------------+
12 rows in set (0.11 sec)
```

- 在 Pos 154-5127之间删除了两条数据

#### 3.数据恢复

1.根据范围

```sql
mysqlbinlog /var/lib/mysql/binlogs.000002 --start-position=219 --stop-position=5158 --database=recruitment | mysql -uroot -p
```

- --start-position=219 表示从 219 这个 Pos开始恢复
- --stop-position=5158 表示恢复到 5158 这个 Pos，
- –-database=recruitment表示恢复 recruitment这个库