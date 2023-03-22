## springboot 部署war包

继承SpringBootServletInitializer 重写 configure 方法

```java
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class RuoYiApplication extends SpringBootServletInitializer
{
    public static void main(String[] args)
    {
        SpringApplication.run(RuoYiApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(RuoYiApplication.class);
    }
}
```



```java
<!--打包方式-->
<packaging>war</packaging>
<!-- 如需打成war包 确保嵌入的servlet容器不会干扰部署war文件的servlet容器 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <scope>provided</scope>
</dependency>
```

