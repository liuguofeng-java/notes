## Ubuntu 新系统第一次使用SSH root

1. 执行以下命令，设置 root 密码

   ```sh
   sudo passwd root

​		输入 root 的密码，按回车。

2. 执行以下命令，打开 sshd_config 配置文件

3. `PermitRootLogin`和`PasswordAuthentication`改成yes

   ```shell
   PermitRootLogin yes
   PasswordAuthentication yes
   ```

4. 重启服务

   ```shell
   sudo service ssh restart
   ```

   

