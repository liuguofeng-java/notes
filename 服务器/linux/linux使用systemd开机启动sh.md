## linux使用systemd开机启动sh

##### 1.简单使用

1. 新建文件 > `vim /etc/systemd/system/app.service`

   ```ini
   [Unit]
   Description=用于启动java项目
   After=network.target
   
   [Service]
   # 由于在service启动的sh环境变量不生效,所以要提前导出
   Environment=JAVA_HOME=/opt/srt/jdk1.8.0_202
   Environment=CLASSPATH=$:CLASSPATH:$JAVA_HOME/lib/
   Environment=PATH=$PATH:$JAVA_HOME/bin
   Environment=nacos_host=127.0.0.1
   
   WorkingDirectory=/opt/srt
   ExecStart=/opt/srt/start.sh
   
   [Install]
   WantedBy=multi-user.target
   
   ```

2. 创建脚本文件

   > 新增一个`start.sh`
   >
   > 执行 `chmod u+x start.sh`

   ```sh
   #!/usr/bin/sh
   
   APP_NAME=srt-cloud-gateway-2.0.0.jar
   
   process=`ps -fe|grep ${APP_NAME} |grep -ivE "grep|cron" |awk '{print $2}'`
   if [ !$process ];
   then
   kill -9 $process
   sleep 1
   fi
   
   nohup java  -Xms512m -Xmx512m -server -jar ${APP_NAME}  > /dev/null 2>&1 &
   
   echo "start ${APP_NAME} success!"
   ```
   
3. 启动并设置开机自启

   ```sh
   systemctl daemon-reload
   systemctl start media.service
   systemctl enable media.service
   ```

##### 2.其他

1. 相关命令

   ```sh
   # 启动单元
   systemctl start [UnitName]
   
   # 关闭单元
   systemctl stop [UnitName]
   
   # 重启单元
   systemctl restart [UnitName]
   
   # 杀死单元进程
   systemctl kill [UnitName]
   
   # 查看单元状态
   systemctl status [UnitName]
   
   # 开机自动执行该单元
   systemctl enable [UnitName]
   
   # 关闭开机自动执行
   systemctl disable [UnitName]
   ```

2. Time定时任务

   > 如: 新建 `/usr/lib/systemd/system/mytimer.timer`

   ```ini
   [Unit]
   Description=Runs mytimer every hour
   
   [Timer]
   OnUnitActiveSec=1h
   Unit=mytimer.service
   
   [Install]
   WantedBy=multi-user.target
   ```

   `[Timer]`部分定制定时器。Systemd 提供以下一些字段

   - `OnActiveSec`：定时器生效后，多少时间开始执行任务
   - `OnBootSec`：系统启动后，多少时间开始执行任务
   - `OnStartupSec`：Systemd 进程启动后，多少时间开始执行任务
   - `OnUnitActiveSec`：该单元上次执行后，等多少时间再次执行
   - `OnUnitInactiveSec`： 定时器上次关闭后多少时间，再次执行
   - `OnCalendar`：基于绝对时间，而不是相对时间执行
   - `AccuracySec`：如果因为各种原因，任务必须推迟执行，推迟的最大秒数，默认是60秒
   - `Unit`：真正要执行的任务，默认是同名的带有`.service`后缀的单元
   - `Persistent`：如果设置了该字段，即使定时器到时没有启动，也会自动执行相应的单元
   - `WakeSystem`：如果系统休眠，是否自动唤醒系统

   上面的脚本里面，`OnUnitActiveSec=1h`表示一小时执行一次任务。其他的写法还有`OnUnitActiveSec=*-*-* 02:00:00`表示每天凌晨两点执行，`OnUnitActiveSec=Mon *-*-* 02:00:00`表示每周一凌晨两点执行，具体请参考[官方文档](https://www.freedesktop.org/software/systemd/man/systemd.time.html)。

   
