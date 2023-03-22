## 普通java类如何取得注入spring Ioc容器的对象

```java
@Component
public class AppContextUtil implements ApplicationContextAware {
    private static ApplicationContext context;
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.context = applicationContext;
    }
    public static Object getBean(String nameBean){
        return context.getBean(nameBean);
    }
}
```

