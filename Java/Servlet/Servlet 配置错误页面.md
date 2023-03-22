## Servlet 配置错误页面



> 在 WEB-INF/web.xml 下

```java
<error-page>
  <error-code>500</error-code>
  <location>/WEB-INF/error500.html</location>
</error-page>

<error-page>
  <error-code>404</error-code>
  <location>/WEB-INF/error404.html</location>
</error-page>
```

