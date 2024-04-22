## maven打包命令

### 1.配置环境变量

##### 1. 配置`MAVEN_HOME`。在系统变量中新建，变量名`MAVEN_HOME`，变量值，maven文件夹路径

##### 2. 配置`path`，找到`path`系统变量，点开，新建，输入`%MAVEN_HOME%\bin`

##### 3. 验证是否安装完成，运行cmd，输入mvn -v，显示maven版本则成功

### 2.配置Maven

##### 1. 修改配置文件

   > 修改解压目录下conf/settings.xml文件

##### 2. 本地仓库位置修改

   > 在<localRepository>标签内添加自己的本地位置路径

   ```xml
     <!-- localRepository
      | The path to the local repository maven will use to store artifacts.
      |
      | Default: ${user.home}/.m2/repository
     <localRepository>/path/to/local/repo</localRepository>
     -->
   	<localRepository>D:\tools\repository</localRepository>
   ```

##### 3. 修改maven默认的JDK版本

   > 在<profiles>标签下添加一个<profile>标签，修改maven默认的JDK版本

   ```xml
   <profile>     
       <id>JDK-1.8</id>       
       <activation>       
           <activeByDefault>true</activeByDefault>       
           <jdk>1.8</jdk>       
       </activation>       
       <properties>       
           <maven.compiler.source>1.8</maven.compiler.source>       
           <maven.compiler.target>1.8</maven.compiler.target>       
           <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>       
       </properties>       
   </profile>
   ```

##### 4. 添加国内镜像源

   > 添加<mirrors>标签下<mirror>，添加国内镜像源，这样下载jar包速度很快。默认的中央仓库有时候甚至连接不通。一般使用阿里云镜像库即可

   ```xml
   <!-- 阿里云仓库 -->
   <mirror>
       <id>alimaven</id>
       <mirrorOf>central</mirrorOf>
       <name>aliyun maven</name>
       <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>
   </mirror>
   
   <!-- 中央仓库1 -->
   <mirror>
       <id>repo1</id>
       <mirrorOf>central</mirrorOf>
       <name>Human Readable Name for this Mirror.</name>
       <url>http://repo1.maven.org/maven2/</url>
   </mirror>
   
   <!-- 中央仓库2 -->
   <mirror>
       <id>repo2</id>
       <mirrorOf>central</mirrorOf>
       <name>Human Readable Name for this Mirror.</name>
       <url>http://repo2.maven.org/maven2/</url>
   </mirror>
   ```

### 3.常用命令

> 依次执行clean、resources、compile、testResources、testCompile、test、jar(打包)等７个阶段。

```shell
mvn clean package
```



> 依次执行clean、resources、compile、testResources、testCompile、test、jar(打包)、install等8个阶段。

```shell
mvn clean install
```



> 依次执行clean、resources、compile、testResources、testCompile、test、jar(打包)、install、deploy等９个阶段。

```shell
mvn clean deploy
```

> package 命令完成了项目编译、单元测试、打包功能，但没有把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库
>
> install 命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库，但没有布署到远程maven私服仓库
>
> deploy 命令完成了项目编译、单元测试、打包功能，同时把打好的可执行jar包（war包或其它形式的包）布署到本地maven仓库和远程maven私服仓库



> 指定settings.xml文件打包

```sh
mvn clean package -Dmaven.test.skip=true --settings /mvn/settings.xml
```

