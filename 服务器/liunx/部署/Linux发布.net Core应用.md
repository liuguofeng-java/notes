## Linux发布.net Core应用

#### 1.要开始安装 .NET，您需要注册 Microsoft 签名密钥并添加 Microsoft 产品提要。运行以下命令：

```shell
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl= https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'
```

#### 2.安装 .NET 所需的组件，然后安装 .NET SDK。运行以下命令：

```shell
sudo yum update
sudo yum install libunwind libicu
sudo yum install dotnet-sdk-3.1  #根据项目版本安装
```

#### 3.启动项目执行项目.dll (这样使用是以前台运行的，如果关闭ssh 网站就关闭了，想要在后台运行就要安装守护进程软件)

```shell
dotnet 路径.dll
```

#### 4.安装守护进程软件

```shell
yum install epel-release #按钮依赖
yum install -y supervisor #守护进程软件
```

```shell
systemctl enable supervisord #开机启动
systemctl start supervisord #开启
systemctl stop supervisord #停止
systemctl restart supervisord #重启
systemctl list-unit-files | grep 程序名称   #查看某些服务开机启动状态
systemctl list-unit-files | grep enable #斜体样式查看哪些为开机启动服务
```

#### 5.默认修改supervisord配置文件 /etc/supervisord.conf

```shell
#port=web管理界面的访问端口 * 代表所有ip
#username= 登录用户名
#password= 登录密码
[inet_http_server]         ; inet (TCP) server disabled by default
port=*:9001        ; (ip_address:port specifier, *:port for all iface)
username=user              ; (default is no username (open server))
password=123456               ; (default is no password (open server))

#扫描supervisord.d目录下的所有ini文件
[include]
files = supervisord.d/*.ini
```

#### 6.在supervisord.d下新建一个ini文件配置要启动的项目

```shell
[program:blogs] #名称随便取一个名  
command=dotnet Project.Blog.dll #执行的命令   
directory=/home/blogs #项目存放的目录 Project.Blog.dll 要在这里哦  
autorestart=true #启动  
stderr_logfile=/home/log/blogs.err.log #错误日志存放位置   
environment=ASPNETCORE_ENVIRONMENT=Production #程序环境变量  
user=root  
stopsignal=INT
```
