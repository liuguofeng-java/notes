## 集成wxJava配置公众号



#### 1.导入maven地址

> 项目地址: https://gitee.com/binary/weixin-java-tools

```xml
<properties>
    <weixin.version>4.7.0</weixin.version>
</properties>

<!--微信公众号-->
<dependency>
	<groupId>com.github.binarywang</groupId>
	<artifactId>weixin-java-mp</artifactId>
	<version>${weixin.version}</version>
</dependency>
```

#### 2.配置文件

````java
/**
 * weixin配置
 * @author liuguofeng
 * @date 2023/10/09 16:54
 **/
@Configuration
public class WeChatMpConfig {
    @Value("${wx.mp.appId}")
    private String appId;

    @Value("${wx.mp.secret}")
    private String secret;
    
    @Bean
    public WxMpService wxMpService(){
        WxMpService wxMpService = new WxMpServiceImpl();
        wxMpService.setWxMpConfigStorage(wxMpConfigStorage());
        return wxMpService;
    }
    
    @Bean
    public WxMpConfigStorage wxMpConfigStorage(){
        WxMpDefaultConfigImpl wxMpConfigStorage = new WxMpDefaultConfigImpl();
        wxMpConfigStorage.setAppId(appId);
        wxMpConfigStorage.setSecret(secret);
        return wxMpConfigStorage;
    }
}
````

