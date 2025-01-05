## liunx基本命令

#####  1.关机命令

```shell
#关机指令
shutdown -h now

#一分钟关闭
shutdown -h 1

#重启指令
shutdown -r now

#重启指令(常用)
reboot

#关闭计算机前保存计算机内存指令
sync
```

#####  2. 用户命令

```shell
useradd tom #创建tom用户
passwd  tom #给tom指定密码
userdel tom #删除tom用户并保留Home目录
userdel -r tom #删除tom用户不保留Home目录
id tom #查看用户信息
su root #切换到root用户
groupadd a #创建a组
groupdel a #删除a组
useradd -g a tom #把tom放进a组
usermod -g b tom #把tom修改到b组

chown tom a.txt #把a.txt的所有者改为tom用户
chown -R tom /a #把a和a下的文件夹所有者递归改为tom用户
chgrp a a.txt #把a.txt改为a组
chgrp -R a /a #把a目录和a下的目录的所在组改为a组
usermod -g a tom #把tom用户改为a组
chmod u=rwx g=rw o=r #给所有者读写执行，给所在组读写，其他组读（u所有者，g所在组，o其他组）
```

#####  3.文件命令

```shell
#查看在哪个目录
pwd

#显示目录文件
ls
	-a#显示隐藏文件
    -l#显示详细文件
    -d#查看当前目录属性
    -h#正常磁盘容量显示

#递归创建文件
mkdir   -p  文件名

#删除命令
rm
	-r#删除目录
    -f#强制删除

#创建文件命令
touch   文件名

#复制命令
cp
	-r#复制文件夹
    -p#保留原文件信息

#剪贴命令
mv    原文件名  新文件名

#分页查看文件信息,'q'建退出
less  文件名

#动态查看文件尾部用于查看日志
tail
	-f#动态查看文件
    -n#指定行号
tail -f -n 99 a.txt



#查看系统磁盘空间
df   -h

#删除命令
rm
	-r#删除目录
    -f#强制删除
            
cat       #查看较短的文件内容

#查询根下的'*.*' 并且文件内容包含'Hello'字符串的文件(-type f代表文件)
find / -type f -name "*.txt" | xargs grep "Hello"

#查看文件结构(需要使用'yum install -y tree'命令安装)
tree 文件夹
```

#####  4.压缩解压命令

```shell
#压缩.gz命令 (只能对文件)
gzip  文件名
#解压命令
gunzip 文件名

#压缩或解压
tar
	-f#指定文件名
    -v#打印信息
    -z#打包
    -x#解压
    -c#压缩
tar –zxvf file.tar #解压 tar包
tar -zxvf file.tar.gz #解压tar.gz
tar -zcvf file.tar.gz file #file把压缩file.tar.gz
tar -zcvf file.tar file #file把压缩file.tar

#压缩.zip命令 
zip -r mysql.zip /home/mysql
#解压命令
unzip 文件名
```

#####  5.rpm包命令

```shell
#查看是否安装MySQl
rpm -pa | grep mysql

#分页查看所有安装应用
rpm -pa | more

#查看MySQL详细信息
rpm - pi mysql

#查看MySQL安装路径
rpm -pl mysql

#卸载MySQL
rpm -e mysql

#安装msql
rpm -ivh mysql

```

#####  6.网络

```shell
wget url #下载命令
netstat -tunlp | grep 3306 #查看端口是否被占用
netstat
	-t : #指明显示TCP端口
    -u : #指明显示UDP端口
    -l : #仅显示监听套接字(所谓套接字就是使应用程序能够读写与收发通讯协议(protocol)与资料的程序)
    -p : #显示进程标识符和程序名称，每一个套接字/端口都属于一个程序。
    -n : #不进行DNS轮询，显示IP(可以加速操作)
    
lsof -i :8080 #查看8080端口被占用情况

#查询指定端口是否已开(提示 yes，表示开启；no表示未开启)
firewall-cmd --query-port=666/tcp
#添加指定需要开放的端口
firewall-cmd --add-port=123/tcp --permanent
#重载入添加的端口
firewall-cmd --reload
#查询指定端口是否开启成功：
firewall-cmd --query-port=123/tcp
#移除指定端口
firewall-cmd --permanent --remove-port=123/tcp
```

#####  7.系统

```shell
#查看服务列表
systemctl list-unit-files
#查看防火墙状态
systemctl status firewalld
#禁用
systemctl disable firewalld
#开启防火墙
systemctl start firewalld  
#关闭防火墙
systemctl stop firewalld
#开启防火墙 
service firewalld start 
若遇到无法开启
先用：systemctl unmask firewalld.service 
然后：systemctl start firewalld.service


init 012356 #切换运行级别

echo $PATH 输出环境变量
```

##### 8.进程

```sh
# 查看任务管理器

top 
	#q：退出top。
	#r：修改进程的nice值（优先级）。
	#k：向进程发送信号，用于终止进程。
	#P：按CPU使用率排序进程。
 	#M：按内存使用率排序进程。


#ll /proc/PID 查看进程信息
ll /proc/476911 


# 查看进程(新)
htop

# 查看运行内存使用情况
free -h
```

