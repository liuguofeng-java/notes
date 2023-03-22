## springboot 配置https
```java
server:
  ssl:
    # 证书路径
    key-store: classpath:server.keystore
    key-alias: tomcat
    enabled: true
    key-store-type: JKS
    #与申请时输入一致
    key-store-password: 123456
    # 浏览器默认端口 和 80 类似
  port: 443
```



![](../../../assets/1659272790552.png)



```java
/**
 * <p>
 * HTTPS 配置类
 * </p>
 *
 * @author Chen.Chao
 * @date Created in 2020-01-12 10:31
 */
@Configuration
public class HttpsConfig {
    /**
     * 配置 http(80) -> 强制跳转到 https(443)
     */
    @Bean
    public Connector connector() {
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setScheme("http");
        connector.setPort(80);
        connector.setSecure(false);
        connector.setRedirectPort(443);
        return connector;
    }

    @Bean
    public TomcatServletWebServerFactory tomcatServletWebServerFactory(Connector connector) {
        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory() {
            @Override
            protected void postProcessContext(Context context) {
                SecurityConstraint securityConstraint = new SecurityConstraint();
                securityConstraint.setUserConstraint("CONFIDENTIAL");
                SecurityCollection collection = new SecurityCollection();
                collection.addPattern("/*");
                securityConstraint.addCollection(collection);
                context.addConstraint(securityConstraint);
            }
        };
        tomcat.addAdditionalTomcatConnectors(connector);
        return tomcat;
    }
}
```

