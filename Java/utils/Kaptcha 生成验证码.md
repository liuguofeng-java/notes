## Kaptcha 生成验证码

> kaptcha 是一个非常实用的验证码生成工具。有了它，你可以生成各种dao样式的验证码，因为它是可配置的。kaptcha工作的原理是调用 com.google.code.kaptcha.servlet.KaptchaServlet，生成一个图片。同时将生成的验证码字符串放到 HttpSession中。

#### 1.导入maven

```java
<dependency>
    <groupId>com.github.penggle</groupId>
    <artifactId>kaptcha</artifactId>
    <version>2.3.2</version>
</dependency>
```



#### 2.Kaptcha 详细配置表

| Constant | 描述 | 默认值 |
| - | - | - |
| kaptcha.border | 图片边框，合法值：yes , no | yes |
| kaptcha.border.color | 边框颜色，合法值： r,g,b (and optional alpha) 或者 white,black,blue. | black |
| kaptcha.border.thickness | 边框厚度，合法值：&gt;0 | 1 |
| kaptcha.image.width | 图片宽 | 200 |
| kaptcha.image.height | 图片高 | 50 |
| kaptcha.producer.impl | 图片实现类 | com.google.code.kaptcha.impl.DefaultKaptcha |
| kaptcha.textproducer.impl | 文本实现类 | com.google.code.kaptcha.text.impl.DefaultTextCreator |
| kaptcha.textproducer.char.string | 文本集合，验证码值从此集合中获取 | abcde2345678gfynmnpwx |
| kaptcha.textproducer.char.length | 验证码长度 | 5 |
| kaptcha.textproducer.font.names | 字体 | Arial, Courier |
| kaptcha.textproducer.font.size | 字体大小 | 40px. |
| kaptcha.textproducer.font.color | 字体颜色， | 合法值： r,g,b 或者 white,black,blue. black |
| kaptcha.textproducer.char.space | 文字间隔 | 2 |
| kaptcha.noise.impl | 干扰实现类 | com.google.code.kaptcha.impl.DefaultNoise |
| kaptcha.noise.color | 干扰 颜色， | 合法值： r,g,b 或者 white,black,blue. black |
| kaptcha.obscurificator.impl | 图片样式： | 水纹com.google.code.kaptcha.impl.WaterRipple 鱼眼com.google.code.kaptcha.impl.FishEyeGimpy阴影com.google.code.kaptcha.impl.ShadowGimpy com.google.code.kaptcha.impl.WaterRipple |
| kaptcha.background.impl | 背景实现类 | com.google.code.kaptcha.impl.DefaultBackground |
| kaptcha.background.clear.from | 背景颜色渐变， | 开始颜色 light grey |
| kaptcha.background.clear.to | 背景颜色渐变， | 结束颜色 white |
| kaptcha.word.impl | 文字渲染器 | com.google.code.kaptcha.text.impl.DefaultWordRenderer |
| kaptcha.session.key | session key | KAPTCHA\_SESSION\_KEY |
| kaptcha.session.date | session date | KAPTCHA\_SESSION\_DATE |

#### 3.具体使用

```java
 public static void main(String[] args) throws IOException {
        Producer producer = new Main().newproducer();
        //生成文字验证码
        String text = producer.createText();
        //生成图片验证码
        BufferedImage image = producer.createImage(text);
        //输出，可以是输出本地，也可以输出网络response.getOutputStream();
        ImageIO.write(image, "jpg", new File("C:\\Users\\13961\\Desktop\\a.jpg"));
    }
    private DefaultKaptcha newproducer() {
        Properties properties = new Properties();
        properties.put("kaptcha.border", "no");
        properties.put("kaptcha.textproducer.font.color", "black");
        properties.put("kaptcha.textproducer.char.space", "5");
        properties.put("kaptcha.textproducer.font.names", "Arial,Courier,cmr10,宋体,楷体,微软雅黑");
        Config config = new Config(properties);
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }

```



```java
@RequestMapping("captcha.jpg")
public void captcha(HttpServletResponse response)throws IOException {
       response.setHeader("Cache-Control", "no-store, no-cache");
       response.setContentType("image/jpeg");

       //生成文字验证码
       String text = producer.createText();
       //生成图片验证码
       BufferedImage image = producer.createImage(text);
       //保存到shiro session
       ShiroUtils.setSessionAttribute(Constants.KAPTCHA_SESSION_KEY, text);
       
       ServletOutputStream out = response.getOutputStream();
       ImageIO.write(image, "jpg", out);
}
```

