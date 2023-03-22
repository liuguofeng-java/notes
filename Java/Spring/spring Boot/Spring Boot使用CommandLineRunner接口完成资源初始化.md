## Spring Boot使用CommandLineRunner接口完成资源初始化

应用场景

> 在应用服务启动时，需要在所有Bean生成之后，加载一些数据和执行一些应用的初始化。例如：删除临时文件，清楚缓存信息，读取配置文件，数据库连接，这些工作类似开机自启动的概念，CommandLineRunner、ApplicationRunner 接口是在容器启动成功后的最后一步回调（类似开机自启动）

```java
@Component
public class Runner implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        System.out.println("The Runner start to initialize ...");
    }
}
```

