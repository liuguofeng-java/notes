## js 获取url

#### 1.设置或获取对象指定的文件名或路径。

```js
window.location.pathname
//例 http://localhost:8086/topic/index?topicId=361
alert(window.location.pathname); 
//则输出：/topic/index
```

#### 2.设置或获取整个 URL 为字符串。

```js
window.location.href
//例 http://localhost:8086/topic/index?topicId=361
alert(window.location.href); 
//则输出：http://localhost:8086/topic/index?topicId=361
```

#### 3.设置或获取与 URL 关联的端口号码。

```js
window.location.port

//例：http://localhost:8086/topic/index?topicId=361
alert(window.location.port); 
//则输出：8086
```

#### 4.设置或获取 URL 的协议部分。

```js
window.location.protocol
//例：http://localhost:8086/topic/index?topicId=361
alert(window.location.protocol); 
//则输出：http:
```

#### 5.设置或获取 location 或 URL 的 hostname 和 port 号码。

```js
window.location.host
//例：http://localhost:8086/topic/index?topicId=361
alert(window.location.host); 
//则输出：http:localhost:8086
```

#### 6.设置或获取 href 属性中跟在问号后面的部分。

```js
window.location.search
//例：http://localhost:8086/topic/index?topicId=361
alert(window.location.search); 
//则输出：?topicId=361
```





