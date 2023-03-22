

## MyBatis中xml 转义符

> mybatis框架是java web开发必备的框架，很多mybatis新手写代码的时候，需要在sql中使用到大于等于，这时候如果像sql中一样直接使用了>、<、>=、<=，在运行的时候于是就出现了一些意想不到的错误，为什么会出现这种情况呢？其实，跟sql注入的道理一样，sql中的>、<、>=、<=与mybatis mapper xml里面的标签符号【"<"，"<"】发生了冲突，导致解析过程中出现问题。

MyBatis的转义

mybatis 中 SQL 写在mapper.xml文件中，而xml解析 < 、>、<=、>= 时会出错，这时应该使用转义写法。有两种解决方案：

##### 方案一：

| &lt;     | &lt;=     | &gt;     | &gt;=     | &amp;     | '          | "          |
| -------- | --------- | -------- | --------- | --------- | ---------- | ---------- |
| &amp;lt; | &amp;lt;= | &amp;gt; | &amp;gt;= | &amp;amp; | &amp;apos; | &amp;quot; |

##### 方案二：

<![CDATA[ sql语句 ]]>

示例：

```java
num <![CDATA[ >=  ]]> #{num}
```

