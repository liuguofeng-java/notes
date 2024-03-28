## Jenkins 脚本执行jar包不运行

> 原因：jenkins在构建完成后会kill掉所有子进程，从而导致脚本中运行的java -jar 程序关闭。

解决方法：`BUILD_ID=dontkillme`

```shell
#!/bin/sh

/home/software/apache-maven-3.8.5/bin/mvn package -Dmaven.test.skip=true
cp target/demo-0.0.1-SNAPSHOT.jar /home/jar/demo.jar
cd /home/jar

BUILD_ID=dontkillme
sh exec.sh
```

这里要主要的是如果你用的jenkins是流水线请将BUILD_ID替换为JENKINS_NODE_COOKIE

```she
source /etc/profile
```
