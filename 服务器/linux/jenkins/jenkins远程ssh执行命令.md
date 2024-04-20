## jenkins远程ssh执行命令

##### 1.在jenkins中的`~/.ssh`查看

> 如果没有`id_rsa  id_rsa.pub`，执行`ssh-keygen -t rsa`获取

```sh
bash-5.1# pwd
/root/.ssh
bash-5.1# ls
id_rsa  id_rsa.pub
```

##### 2.复制`id_rsa.pub`

> 在要控制的服务器中下`/root/.ssh`新建`authorized_keys`(192.168.0.60)，把`id_rsa.pub`内容复制到`authorized_keys`

```sh
bash-5.1# cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDrZiQz3+DvyC68VAKdrFX8+M3oWGfjFcWpSJrsGOPBjf/7HgDSy24W9z4bjggoVY5zu8HHXKqzFr98sXDads5ZUWGloRR5S+s7n+zgzBoAONiw7fQsatDIsWg5+gZBtQuC1arzv2CVtgVqfcq2yqoO3ZLGbgiiB3OK/wD204iL32hGnRMNSqNaFvDxuOdtFvtCVsi3uGBssgqT37w3HNAWILHjy08FM3Ka+VTaJMTv9mIEsvQEuqDeMYOf9b/YJ1vFnDKkPJ+Bfpf/rG0WXvx98nB04nZj0atXhKNoXTbZ79BAdCPoRoMNqDzUYf6jpmggBf3XZnkjtSHtDT+8b2r3YtNLWWQ8dWKFv2e25xVGcJ7eOp24BniA/LK5N7i2q6f9fnRPKMLyiUF3BMkk1AgPwezeKA0/zYBZ/+0hr0pCCVsKrZ9sS/pX+Esa7/pbFz4DZMlLFVZOHgP0acbCuD3X5eWA4LwZUVzrP0xUqLcXdBlKIH/aY+touR1ylbmlofs= root@109d9195d76c
```

##### 3.执行命令

```sh
ssh root@192.168.0.60 pwd
```



