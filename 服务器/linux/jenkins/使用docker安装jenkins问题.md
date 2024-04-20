## 使用docker安装jenkins问题

##### 1.执行java出现 `java: not found`

```sh
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
ls /etc/apk/keys/sgerrand.rsa.pub
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk
apk add glibc-2.29-r0.apk
```

