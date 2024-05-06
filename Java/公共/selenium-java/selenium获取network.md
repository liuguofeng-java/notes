## selenium获取network

##### 1.代码如下

```java
System.getProperties().setProperty("webdriver.chrome.driver", "xxxx/chromedriver.exe");
ChromeOptions chromeOptions = new ChromeOptions();
ChromeDriver driver = new ChromeDriver(chromeOptions);
// 获取DevTools接口
DevTools devTools = driver.getDevTools();
devTools.createSession();
devTools.send(Network.enable(Optional.empty(), Optional.empty(), Optional.empty()));

// 获取Request信息
devTools.addListener(Network.requestWillBeSent(), res -> {
	System.out.println("RequestHeaders:" + res.getRequest().getHeaders());
	System.out.println("RequestHeaders:" + res.getRequest().getUrl());
});

// 获取Response信息
devTools.addListener(Network.responseReceived(), res -> {
    // Headers信息
	System.out.println("ResponseHeaders:" + res.getResponse().getHeaders());
    // url
    String url = res.getResponse().getUrl();
 	Response response = res.getResponse();
    // Body 信息
    String responseBody = devTools.send(Network.getResponseBody(res.getRequestId())).getBody();
});

// 设置 HTTP 请求头
driver.get("https://www.bing.com/");

System.out.println();

Thread.sleep(10000);

// 关闭webdriver
driver.quit();

// 关闭DevTools会话
devTools.close();
```

