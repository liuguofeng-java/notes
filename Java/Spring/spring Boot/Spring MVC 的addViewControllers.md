## Spring MVC 的addViewControllers

```java
@Configuration
public class MvcConfig implements WebMvcConfigurer {

    	public void addViewControllers(ViewControllerRegistry registry) {
    		registry.addViewController("/home").setViewName("home");
    	}
}
```

其中 addViewController("/home")，是URL路径，就是http://localhost:8080/home

setViewName("/home")是你HTML或JSP页面名称   home.html或home.jsp。