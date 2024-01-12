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

##### 2.启动并设置开机自启

```sh
systemctl start media.service
systemctl enable media.service
```

