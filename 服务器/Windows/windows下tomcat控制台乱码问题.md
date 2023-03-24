## windows下tomcat控制台乱码问题

##### 1.问题Tomcat乱码

> 修改conf下的`logging.properties`的`java.util.logging.ConsoleHandler.encoding=GBK`：

```shell
java.util.logging.ConsoleHandler.level = FINE
java.util.logging.ConsoleHandler.formatter = java.util.logging.SimpleFormatter
java.util.logging.ConsoleHandler.encoding = GBK #重要代码
```

