## Java Web

#### 1. JSP有9个内置对象：

request：封装客户端的请求，其中包含来自GET或POST请求的参数；

response：封装服务器对客户端的响应；

pageContext：通过该对象可以获取其他对象；

session：封装用户会话的对象；

application：封装服务器运行环境的对象；

out：输出服务器响应的输出流对象；

config：Web应用的配置对象；

page：JSP页面本身（相当于Java程序中的this）；

exception：封装页面抛出异常的对象。

#### 2. session 和 cookie 有什么区别？

1.数据存储位置：cookie数据存放在客户的浏览器上，session数据放在服务器上。

2.安全性：cookie不是很安全，别人可以分析存放在本地的cookie并进行cookie欺骗，考虑到安全应当使用session。

3.作用域：session：关闭浏览器消失,cookie:想存多久就存多久

