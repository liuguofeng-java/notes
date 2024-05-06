## springBoot访问不到静态资源

> 背景：初始搭建好springboot平台后，发现static目录下的js.css等静态资源无法访问，于是乎，做如下修改：

第一种方案：

   直接修改yml配置文件：

```java
#thymeleaf
  thymeleaf:
    cache: false
    prefix:  classpath:/templates/
    check-template-location: true
    suffix: .html
    encoding: utf-8
    mode: HTML
#这个是关键，放开springboot对静态资源的拦截
  mvc:
    static-path-pattern: /static/**
```

第二种方案：

​	增加java类，告诉springboot对静态资源的加载路

```java
/**
 * 配置静态资源映射
 **/
@Component
public class WebMvcConfig implements WebMvcConfigurer {
 
 
 
 
    /**
     * 添加静态资源文件，外部可以直接访问地址
     *
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
       //此处还可继续增加目录。。。。
    }
 
}
```

​    