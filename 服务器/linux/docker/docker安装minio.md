## docker安装minio

##### 1. 拉取镜像

```sh
docker pull minio/minio
```

##### 2.创建容器

```sh
docker run -p 9000:9000 -p 9090:9090 \
     --name minio \
     -d --restart=always \
     -e "MINIO_ROOT_USER=minioAdmin" \
     -e "MINIO_ROOT_PASSWORD=lbf123lbf" \
     -v /home/minio/data:/data \
     -v /home/minio/config:/root/.minio \
     minio/minio:RELEASE.2022-06-20T23-13-45Z.fips server \
     /data --console-address ":9090" -address ":9000"
```

- 9090端口指的是minio的客户端端口
- 9000端口指的是minio api接口端口
- MINIO_ACCESS_KEY ：账号
- MINIO_SECRET_KEY ：密码（账号长度必须大于等于5，密码长度必须大于等于8位）