## springboot-thymeleaf  页面配置

1.引入依赖包

```java
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```



2.application.properties配置

```java
#开发时关闭缓存,不然没法看到实时页面
spring.thymeleaf.cache=false
# 用非严格的 HTML
spring.thymeleaf.mode= LEGALITY5
spring.thymeleaf.encoding=utf-8
spring.thymeleaf.servlet.content-type=text/html
```



