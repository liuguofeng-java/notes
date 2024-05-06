## java爬虫Jsoup

##### 1.引入依赖

```xml
<dependency>
    <groupId>org.jsoup</groupId>
    <artifactId>jsoup</artifactId>
    <version>1.14.3</version> <!-- or latest version -->
</dependency>
```

##### 2.一行代码返回页面

只需要一行代码即可对一个链接发起请求，返回页面数据。

```java
Document document = Jsoup.connect(url).get();
```

##### 3.常见类与api

1. 根据标签获取`<p></p>`

   ```java
   document.getElementsByTag("p")
   ```

2. 根据class获取`<p class="item"></p>`

   ```java
   document.getElementsByClass("item")
   ```

3. 根据属性名称获取`<a href="baid.com"></a>`

   ```java
   document.getElementsByAttribute("href")
   ```

4. 获取标签属性的值`<a href="baid.com" id="link"></a>`

   ```java
   Element elements = document.getElementById("link");
   // 值=baid.com
   String attr = elements.attr("href");
   ```

5. 获取标签所有属性`<a href="baid.com" id="link"></a>`

   ```java
   Element elementById = document.getElementById("link");
   // 值:key=href value=baid.com,key=id value=link
   Attributes attributes = elementById.attributes();
   for (Attribute attribute : attributes) {
       String key = attribute.getKey();
       String value = attribute.getValue();
   }
   ```

6. 获取标签的文本内容`<a href="baid.com" id="link">跳转百度</a>`

   ```java
   Element elementById = document.getElementById("link");
   // 值=跳转百度
   String text = elementById.text();
   ```

   