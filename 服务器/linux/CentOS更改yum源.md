## CentOS更改yum源

##### 1.备份原有源配置文件：

```sh
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```

##### 2.下载国内源配置文件：

```sh
# 使用ailyun的源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 如果没有wget可以使用curl
curl -O http://mirrors.aliyun.com/repo/Centos-7.repo 
```

##### 3.清理 yum 缓存并生成新缓存：

```sh
yum clean all
yum makecache fast

yum -y update
```

##### 4.验证更改： 检查 YUM 源是否已经更换成功，可以通过列出可用的软件包仓库：

```sh
yum repolist
```

