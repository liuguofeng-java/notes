## flutter 1.22版本@required被替换成了re

新版本将之前的@required替换成了required ， 这是用来标明参数是必需的。

但是编译器可能不认识，于是会报错。



解决方法：

将pubspec.yaml中的

environment改为以下内容：



```java
environment:
  sdk: ">=2.10.3 <3.0.0"
```

并重启ide即可。



原因

这个是最近空安全的修改。

现在，required是dart 2.10中的关键字。

如果flutter版本升级到1.22，dart版本会随之升级上来，所以正常运行没有错误，但是编译器会报错。