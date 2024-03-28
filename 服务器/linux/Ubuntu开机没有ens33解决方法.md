## Ubuntu开启端口

最近重新安装了VMware，使用之前的ubuntu镜像，发现只有一个lo网卡，没有ens33，虚拟机无法获取ip地址，samba服务器也无法正常使用。

```sh
root@ubuntu:/var/lib/NetworkManager# ifconfig
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 1267  bytes 92802 (92.8 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1267  bytes 92802 (92.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```


遇到这种情况，可以使用以下命令解决：

```sh
sudo dhclient ens33
```


当我们遇到更换网关，比如笔记本更换连接的路由器，或者更改路由器网段，也可以使用这条命令重新获取ip地址。这样就可以避免因为更换路由器网段而连接不上samba服务器的问题。