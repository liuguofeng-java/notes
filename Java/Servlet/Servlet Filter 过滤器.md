## Servlet Filter 过滤器

#### 1.编写一个类 实现 Filter 接口，并实现接口的方法

```java
public class LoginFilter implements Filter {
    //启动服务器时初始化
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
    
    //在web.xml配置过滤的路径，每次访问服务器都访问此方法
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {


        filterChain.doFilter(servletRequest,servletResponse);//放行
    }


    //服务器关闭时执行
    @Override
    public void destroy() {

    }
}
```

#### 2.在 WEB-INF/web.xml 下配置

```xml
<filter>
  <filter-name>LoginFiler</filter-name>#与filter-mapping映射
  <filter-class>com.demo.servlet.LoginFilter</filter-class>#filter类，全类名
</filter>

<filter-mapping>
  <filter-name>LoginFiler</filter-name>
  <url-pattern>/*</url-pattern>#过滤的路径
</filter-mapping>
```

