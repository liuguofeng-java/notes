## springboot HandlerMethodArgumentResolver **注解控制器参数**

### 1.1定义一个注解

```java
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.PARAMETER)
public @interface Dome {
    String value() default "";
}
```

### 1.2在控制器使用

```java
@GetMapping("/index02")
@ResponseBody
public String index02(String param1,@Dome("value") String param2){
    return "index01";
}
```

### 1.3定义一个类实现 HandlerMethodArgumentResolver

```java
@Component
public class DomeMethodArgumentResolver implements HandlerMethodArgumentResolver {
    //判断参数是否存在注解返回true：执行resolveArgument() 否则结束
    @Override
    public boolean supportsParameter(MethodParameter methodParameter) {
        if(methodParameter.hasParameterAnnotation(Dome.class)){
            return true;
        }
        return false;
    }

    @Override
    public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer modelAndViewContainer, NativeWebRequest nativeWebRequest, WebDataBinderFactory webDataBinderFactory) throws Exception {
        Dome methodAnnotation = methodParameter.getParameterAnnotation(Dome.class);
        Parameter parameter = methodParameter.getParameter();
        String name = parameter.getName();
        HttpServletRequest nativeRequest = nativeWebRequest.getNativeRequest(HttpServletRequest.class);
        String parameter1 = nativeRequest.getParameter(name);
        return "123";
    }
}
```

### 1.4在springboot 注册

```java
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private DomeMethodArgumentResolver domeMethodArgumentResolver;
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        resolvers.add(domeMethodArgumentResolver);
    }
}
```

