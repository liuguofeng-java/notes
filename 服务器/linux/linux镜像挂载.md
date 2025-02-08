## linux镜像挂载

##### 1. 上传镜像

> 如：上传路径为 /home/Kylin-Server-V10-SP3-2403-Release-20240426-x86_64.ios

##### 2.挂载镜像

1. 新建文件夹

   ```sh
   mkdir /mnt/sys_mirror
   ```

2. 挂载

   ```sh
   mount -o loop /home/Kylin-Server-V10-SP3-2403-Release-20240426-x86_64.ios /mnt/sys_mirror
   ```

   - `mount`：用于挂载文件系统
   - `-o loop`:通过回环设备来挂载文件，也就是说把要挂载的文件当成块设备（硬盘or光盘）来进行访问
   - `/mnt/sys_mirror`：要挂载的路径



##### 3.修改yum源配置

1. 修改yum配置文件

   ```sh
   cd /etc/yum.repos.d
   
   #备份原来的.repo文件
   cp kylin_x86_64.repo kylin_x86_64.repo_back
   
   # 打开.repo文件添加
   [kylin_64.repo]
   name=kylin_64.repo
   baseurl=file:///mnt/sys_mirror
   enable=1
   gpgcheck=0
   ```

2. 使yum源仓库生效

   ```sh
   # 清除源仓库的缓存（包含头文件、软件包缓存等）
   yum clean all
   
   # 重建缓存，链接到新配的仓库
   yum makecache
   
   # 列出配置的仓库
   yum repolist
   ```

