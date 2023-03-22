## 普通类中使用@Autowired注解

SpringBoot在普通类中使用@Autowired注解引用ApplicationContext对象报NullPointerException异常



SpringBoot在普通类中使用@Autowired注解引用ApplicationContext对象报NullPointerException异常，解决方法：

普通类(SampleClazz)实现ApplicationContextAware接口的setApplicationContext方法，将ApplicationContext对象传递到普通类：

```java
public class SampleClazz implements ApplicationContextAware {

    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SampleClazz.applicationContext = applicationContext;
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext
    }
}
```

问题原因（不一定准确）：

之所以叫SampleClazz为普通类，是因为它在实例化的时候我们大多采用new SampleClazz()的方式，而不是通过@Autowired注解自动装配的，这样一来就不受Spring容器来管理了，通过实现ApplicationContextAware接口来动态加载Bean，ApplicationContext对象就可以用了。

后记：

如果getApplicationContext()是报空指针异常的话，有可能是依赖SampleClazz的类没有受Spring容器管理，将该类所在的包加到组件扫描注解中：

```java
@SpringBootApplication
@ComponentScan({"service", "util"}) // 组件扫描
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

