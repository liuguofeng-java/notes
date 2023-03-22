# java爬虫Jsoup

### 1.引入依赖

```xml
<dependency>
    <groupId>org.jsoup</groupId>
    <artifactId>jsoup</artifactId>
    <version>1.14.3</version> <!-- or latest version -->
</dependency>
```

### 2.一行代码返回页面

只需要一行代码即可对一个链接发起请求，返回页面数据。

```java
Document document = Jsoup.connect(url).get();
```

## 常见类与api

### 1.常见的类

Jsoup 常见的几个类，都是对应 HTML DOM 中的概念。通过对以下几个类的操作，就可以从一个 HTML 页面获取自己想要的数据啦。

1. Document 类，对应 HTML DOM Document 对象
2. Element 类，对应 HTML 的 DOM 元素，比如 、
   、 等
3. Attribute，对应 HTML 中的属性，比如一个 div 元素里的 class、id 等

### 2.常用api

首先，介绍一下获取 DOM 元素的 api，都是属于 Element 类中定义的方法。

1. getElementById(String id)：通过 id 获取元素，非常精准。
2. getElementsByTag(String tag)：根据标签名获取元素的集合，比如：

```text
document.getElementsByTag("p")
```

会获取到所有

标签的元素，方便我们进一步从中抓取想要的文本。

1. getElementsByClass(String className)：根据 class 名称获取元素的集合，比如：

```text
document.getElementsByClass("item")
```

会获取所有 class 为 item 的元素。一般页面的列表项会指定相同的 class，所以这个方法方便我们直接获取指定的列表内容。

1. getElementsByAttribute(String key)：根据属性名称获取元素的集合，比如：

```text
document.getElementsByAttribute("href")
```

这样我们就可以获取全部有链接属性的元素，方便去跳转爬取该页面涉及到的其他页面。

获取到 DOM 元素，接下来我们还需要获取这个元素的属性、文本等数据。

1. attr(String key)：获取元素中某属性的值。比如：element.attr("class")，可以获取当前元素 class 属性的值。
2. attributes()：获取元素的所有属性。我们可以对全部属性进行遍历或者其他处理。
3. id()、className() 、classNames()：获取元素的 id 值、class 值以及全部 class 值的集合。这几个方法的底层都是 attr(String key) 方法，实际上是方便我们使用的快速实现。
4. text()：获取元素的全部文本内容。我们不用手动遍历当前元素的所有子节点去获取文本信息，这个方法会直接把所有文本拼接到一起并返回。