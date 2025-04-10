## linux开机启动crontab



> `crontab` 是 Linux/Unix 系统中用于设置周期性执行任务的工具。它通过配置文件（称为 **cron表**）来管理任务，适合定时执行脚本、命令或程序。以下是详细用法：

##### 1. 基本命令

```sh
# 编辑当前用户的 cron 表
crontab -e

# ​​查看当前用户的 cron 表
crontab -l
```

##### 2.使用cronta

1. cron 时间格式

   > *Cron 表达式在线工具：*https://www.jyshare.com/front-end/9444/

   ```sh
   *    *    *    *    * 
   -    -    -    -    -
   |    |    |    |    |
   |    |    |    |    +----- 星期中星期几 (0 - 6) (星期天 为0)
   |    |    |    +---------- 月份 (1 - 12) 
   |    |    +--------------- 一个月中的第几天 (1 - 31)
   |    +-------------------- 小时 (0 - 23)
   +------------------------- 分钟 (0 - 59)
   ```

2. 常用示例

   | 示例                                 | 说明                                           |
   | :----------------------------------- | :--------------------------------------------- |
   | `0 3 * * * /path/to/backup.sh`       | 每天凌晨 3 点执行备份脚本。                    |
   | `*/15 * * * * /usr/bin/check_status` | 每 15 分钟执行一次状态检查。                   |
   | `0 0 1 * * /path/to/bill.sh`         | 每月 1 日 0 点执行账单脚本。                   |
   | `30 16 * * 1-5 /path/to/report.sh`   | 每周一至周五下午 4:30 生成报告。               |
   | `@reboot /path/to/start_service.sh`  | 系统启动时执行一次（注意：非标准 cron 语法）。 |

3. 特殊字符串（简化写法）

   - `@yearly` 或 `@annually`：每年 1 月 1 日 0 点。
   - `@monthly`：每月 1 日 0 点。
   - `@weekly`：每周日 0 点。
   - `@daily` 或 `@midnight`：每天 0 点。
   - `@hourly`：每小时的 0 分。

##### 3.关于执行日志

1. CentOS/RHEL

   ```sh
   /var/log/cron
   ```

2. Ubuntu/Debian

   ```sh
   /var/log/syslog
   ```

3. 通过 `journalctl`（systemd 系统）

   ```sh 
   journalctl -u cron.service  # 查看 cron 服务日志
   journalctl --since "2025-01-01" --until "2025-01-02"  # 按时间过滤
   ```

   
