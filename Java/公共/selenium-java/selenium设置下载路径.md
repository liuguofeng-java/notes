## selenium设置下载路径

##### 1.相关代码

```java
System.getProperties().setProperty("webdriver.chrome.driver", "/xxx/chromedriver.exe");

// 下载路径
String downloadFilePath = "C:\\Users\\liuguofeng\\Desktop\\";

Map<String, Object> chromePrefs = new HashMap<String, Object>();
chromePrefs.put("profile.default_content_settings.popups", 0);
chromePrefs.put("download.default_directory", downloadFilePath);

// ChromeOptions 中设置下载路径信息，传入保存有下载路径的 HashMap
ChromeOptions chromeOptions = new ChromeOptions();
chromeOptions.setExperimentalOption("prefs", chromePrefs);
chromeOptions.addArguments("--test-type");
chromeOptions.addArguments("--disable-extensions");
DesiredCapabilities desiredCapabilities = new DesiredCapabilities();
desiredCapabilities.setCapability(ChromeOptions.CAPABILITY, chromeOptions);

ChromeDriver driver = new ChromeDriver(chromeOptions);
driver.get("https://azure.microsoft.com/zh-cn/products/cognitive-services/text-to-speech/#features");
```

