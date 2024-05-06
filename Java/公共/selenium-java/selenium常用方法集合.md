## selenium常用方法集合

##### 1.引入maven

```xml
<dependency>
    <groupId>org.seleniumhq.selenium</groupId>
    <artifactId>selenium-java</artifactId>
    <version>4.20.0</version>
</dependency>
```

##### 2.基本环境配置

> `chromedriver` [安装参考](../../../服务器/linux/selenium自动化执行浏览器.md)

```java
// 设置chromedriver路径
System.getProperties().setProperty("webdriver.chrome.driver", "xxxx/chromedriver.exe");
ChromeOptions chromeOptions = new ChromeOptions();
ChromeDriver driver = new ChromeDriver(chromeOptions);
// 跳转到指定网站
driver.get("https://member.bilibili.com/");
```

##### 2.关于`Cookie`操作

1. 添加Cookie

   ```java
   ChromeOptions chromeOptions = new ChromeOptions();
   ChromeDriver driver = new ChromeDriver(chromeOptions);
   driver.get("https://member.bilibili.com/");
   //设置cookie
   driver.manage().addCookie(new Cookie("sid", "hkhe9nm4", ".bilibili.com", "/", null));
   ```

2. 清空所有Cookie

   ```java
   driver.manage().deleteAllCookies();
   ```

3. 获取Cookie

   ```java
   Set<Cookie> cookies = driver.manage().getCookies();
   ```

##### 3.关于跳转页面时等待页面加载完成

```java
driver.get("https://member.bilibili.com/");
// 与浏览器同步非常重要，必须等待浏览器加载完毕
driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
```

##### 4.关于操作页面元素

1. 获取页面元素

   ```java
   // By.cssSelector 可根据id和class获取元素
   // 如: 根据class获取 <a class="link"></a>
   List<WebElement> list = driver.findElements(By.cssSelector(".link"));
   // 如: 根据id获取 <a id="link"></a>
   WebElement like = driver.findElements(By.cssSelector("#link"));
   
   // 根据class获取元素 如: <a class="link"></a>
   WebElement link = driver.findElement(By.className("link"));
   
   // 根据id获取元素 如: <a id="link"></a>
   WebElement link = driver.findElement(By.id("link"));
   
   // 根据元素文本获取内容 <button>登陆</button>
   WebElement loginBut = driver.findElement(By.linkText("登陆"));
   
   // 根据元素标签获取 <button></button>
   List<WebElement> buttons = driver.findElements(By.tagName("button"));
   
   // 根据颜色属性name获取 <input name="username"></input>
   driver.findElement(By.name("username"))
   ```

2. 事件

   ```java
   // 使用执行js方法触发
   WebElement playbtn = driver.findElement(By.id("playbtn"));
   driver.executeScript("arguments[0].click();", playbtn);
   ```

3. 输入框

   ```java
   // 获取输入框
   WebElement input = tagInputInstance.findElement(By.xpath("input"));
   // 清空输入框值
   input.clear();
   // 输入框设置值
   input.sendKeys("xxx");
   // 按下键盘
   input.sendKeys(Keys.ENTER);
   ```

4. 执行js

   ```java
   driver.executeScript("let a = 1");
   ```

   