## linux使用systemd开机启动sh

##### 1.新建文件 > vim /etc/systemd/system/media.service

```ini
[Unit]
Description=用于启动java项目
After=network.target

[Service]
WorkingDirectory=/home/media
ExecStart=nohup java -Dspring.profiles.active=prod -Xms512m -Xmx512m -server -jar media-admin.jar --server.port=8080  > /dev/null 2>&1 &

[Install]
WantedBy=multi-user.target
```

或者

> 新增一个`start.sh`
>
> 执行 `chmod u+x start.sh`

```ini
[Unit]
Description=用于启动java项目
After=network.target

[Service]
WorkingDirectory=/home/srt
ExecStart=/home/srt/start.sh

[Install]
WantedBy=multi-user.target
```

```sh
#!/usr/bin/sh

# 由于在service启动的sh环境变量不生效,所以要提前导出
export JAVA_HOME=/home/srt/jdk1.8.0_202
export CLASSPATH=$:CLASSPATH:$JAVA_HOME/lib/
export PATH=$PATH:$JAVA_HOME/bin
export nacos_host=127.0.0.1

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

##### 2.启动并设置开机自启

```sh
systemctl start media.service
systemctl enable media.service
```

