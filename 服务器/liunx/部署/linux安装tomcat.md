## linux安装tomcat.md

> 安装前提：系统必须已配置安装jdk1.8.0(Java环境)

##### 1. 下载tomcat

   http://tomcat.apache.org/

##### 2. 将apache-tomcat-7.0.92.tar.gz文件上传至/usr/local/src

   ```shell
   cd /usr/local/src
   wget  http://mirrors.hust.edu.cn/apache/tomcat/tomcat-7/v7.0.92/bin/apache-tomcat-7.0.92.tar.gz
   ```

##### 3. 解压源码包

   ```shell
   tar xvzf apache-tomcat-7.0.92.tar.gz
   ```

##### 4. 源码路径重命名

   ```shell
   mv apache-tomcat-7.0.92 /usr/local/tomcat
   ```

##### 5. 启动Tomcat

   ```shell
   /usr/local/tomcat/bin/startup.sh
   ```

##### 6. 停止tomcat

   ```shell
   /usr/local/tomcat/bin/shutdown.sh
   ```

   





