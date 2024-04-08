## k8s集成NFS

##### 1.安装

```sh
# Constos----------------
# 所有机器执行
yum install -y nfs-utils

# ubuntu-----------------
# 服务端
apt install nfs-kernel-server
# 客户端
apt install nfs-common
```

##### 2.配置nfs

```sh
# 全部节点执行
mkdir -p /nfs/data

# 只在 mster 机器执行：nfs主节点，rw 读写
echo "/nfs/data/ *(insecure,rw,sync,no_root_squash)" > /etc/exports
systemctl enable rpcbind --now
systemctl enable nfs-server --now
# 配置生效
exportfs -r
# 查看是否生效
exportfs
```

##### 3.其他客户端节点加入

```sh
# 在 2 个从服务器执行，将远程 和本地的 文件夹 挂载
mount -t nfs 192.168.0.112:/nfs/data /nfs/data

# 在 master 服务器，写入一个测试文件
echo "hello nfs server" > /nfs/data/test.txt

# 在 2 个从服务器查看
cd /nfs/data
ls
```

