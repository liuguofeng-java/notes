## linux修改固定IP地

### 一.ConstOS修改固定IP

##### 1. 直接编辑网卡文件

```shell
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

##### 2. 在文件中添加这几行，如果有就修改

```shell
ONBOOT=yes
IPADDR=192.168.1.201
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=114.114.114.114
```

##### 3. 重启网络服务

```shell
service network restart
```

### 二.Ubuntu修改固定IP

##### 1.编辑对应的配置文件

```bash
sudo vim /etc/netplan/01-netcfg.yaml
```

##### 2.修改配置文件，以下是一个示例配置，设置固定IP：

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.10/24
      gateway4: 192.168.1.1
      nameservers:
          addresses: [8.8.8.8, 8.8.4.4]
```

##### 5.应用配置

```bash
sudo netplan apply
```



