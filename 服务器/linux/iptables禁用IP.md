## iptables禁用IP

```sh
#封单个IP的命令：
iptables -I INPUT -s 124.115.0.199 -j DROP

#封IP段的命令：
iptables -I INPUT -s 124.115.0.0/16 -j DROP

#封整个段的命令：
iptables -I INPUT -s 194.42.0.0/8 -j DROP

#封几个段的命令：
iptables -I INPUT -s 61.37.80.0/24 -j DROP

#禁止服务器访问此IP
iptables -A OUTPUT -d 1.2.3.4 -j DROP

#只封80端口：
iptables -I INPUT -p tcp –dport 80 -s 124.115.0.0/24 -j DROP

#禁止指定的端口：
iptables -A INPUT -p tcp --dport 80 -j DROP

#拒绝所有的端口：
iptables -A INPUT -j DROP

#开放指定的端口：
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

#放行某个ip
iptables -A INPUT -p tcp -s 192.168.1.2 -j DROP

#开放端口
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 8000 -j ACCEPT

#开放 udp
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#防止同步包洪水(Sync Flood)
# iptables -A FORWARD -p tcp –syn -m limit –limit 1/s -j ACCEPT

#防止各种端口扫描
# iptables -A FORWARD -p tcp –tcp-flags SYN,ACK,FIN,RST RST -m limit –limit 1/s -j ACCEPT

#Ping 洪水攻击(Ping of Death)
# iptables -A FORWARD -p icmp –icmp-type echo-request -m limit –limit 1/s -j ACCEPT


#一键清空所有规则
iptables -F

#清空：
iptables -D INPUT 数字


#清空屏蔽IP
iptables -t filter -D INPUT -s 1.2.3.4 -j DROP
iptables -t filter -D OUTPUT -d 1.2.3.4 -j DROP

#查看：
iptables -L -n
```

