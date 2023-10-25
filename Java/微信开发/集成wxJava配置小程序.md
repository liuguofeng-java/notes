## 集成wxJava配置小程序



#### 1.导入maven地址

> 项目地址: https://gitee.com/binary/weixin-java-tools

```xml
<!--微信小程序-->
<dependency>
	<groupId>com.github.binarywang</groupId>
    <artifactId>weixin-java-miniapp</artifactId>
    <version>${weixin.version}</version>
</dependency>

<!--微信小程序sdk引用了commons-lang3模块-->
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.12.0</version>
</dependency>
```

#### 2.配置文件

````java
@Configuration
public class WeChatMiniappConfig {


    // 焊工小程序
    @Value("${wx.device-appid}")
    private String deviceAppId;
    @Value("${wx.device-secret}")
    private String deviceSecret;

    @Bean
    public WxMaService wxMaService() {
        WxMaService maService = new WxMaServiceImpl();
        Map<String, WxMaConfig> configs = new HashMap<>();

        // 焊工小程序
        WxMaDefaultConfigImpl deviceConfig = new WxMaDefaultConfigImpl();
        deviceConfig.setAppid(deviceAppId);
        deviceConfig.setSecret(deviceSecret);
        configs.put(deviceConfig.getAppid(), deviceConfig);

        // 其他小程序配置
        /*WxMaDefaultConfigImpl config = new WxMaDefaultConfigImpl();
        config.setAppid();
        config.setSecret();
        configs.put(config.getAppid(), config);*/

        maService.setMultiConfigs(configs);
        return maService;
    }

}
````

