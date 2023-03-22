## JavaWEB

#### 1.url-pattern的路径配置 *

```java
<url-pattern>/hello</url-pattern>
<url-pattern>*.html</url-pattern>
<url-pattern>/*</url-pattern>
```

#### 2.Servlet的生命周期,以下的方法都是Servlet容器调用的*

1. 第一次请求的时候，构造器被调用，会创建Servlet的对象,且只创建一次.  Servlet是单实例的

2. 创建Servlet对象后，会马上调用init方法.  init的方法可以为Servlet做初始化工作.

3. 当每一次请求的时候，service会被调用.    可以处理客户端请求和响应

4. 当服务器停止的时候，或当前应用被卸载的时候，会被调用。可以销毁Servlet,为Servlet销毁之前做工作，比如资源的释放

#### 3.load-on-startup

```java
<!-- 当启动容器就加载Serlvet，需要配置 load-on-startup-->
<load-on-startup>1</load-on-startup>
```

   值越小，越先加载。当为负数的时候，启动容器后 不会加载.

#### 4.ServletConfig 接口:

```java
在web.xml的Servlet中配置
<init-param>
<param-name>username</param-name>
<param-value>tom</param-value>
</init-param>
方法:
getInitParameter(String name) :通过参数的名字获取参数的值
getServletContext() :获取ServletContext
```

#### 5.ServletContext接口：

可以通过ServletConfig的getServletContext()获取

由于一个WEB应用程序中的所有Servlet都共享同一个ServletContext对象，所以，ServletContext对象被称之为 application 对象

方法:

```java
getInitParameter(String name):获取web应用程序的初始化参数
在web.xml中进行配置web应用程序的初始化参数:
<context-param>
   <param-name>jdbcUrl</param-name>
   <param-value>jdbc:mysql:///test</param-value>
   </context-param>
getContextPath() :获取当前应用的路径
getRealPath(String path):用于返回某个虚拟路径所映射的本地文件系统路径。
setAttribute(String name, Object object)
getAttribute(String name)
removeAttribute(String name)
```

#### 7.service方法,

请求的url如：http://localhost:8080/javaweb_day02/aServlet?username=tom&password=123&like=1&like=2

```java
ServletRequest:封装了请求相关的信息
HttpServletRequest:是ServletRequest子接口,是专用于HTTP协议的
获取参数的相关方法:
getParameter(String name)  :通过参数名获取参数值
getParameterNames() :获取所有的参数名组成的 Enumeration
getParameterValues(String name) :通过参数名获取参数的多个值
getParameterMap() :获取所有的参数，以参数名为key，以参数值为value，返回的Map<String,String[]>
getMethod():返回HTTP请求消息中的请求方式
getRequestURI() :返回请求行中的资源名部分
getQueryString():返回请求行中的参数
getContextPath():返回请求资源所属于的WEB应用程序的路径
getServletPath():Servlet的名称或Servlet所映射的路径
getRequestURL():返回客户端发出请求时的完整URL
ServletResponse:封装了响应的相关的信息
HttpServletResponse：是ServletResponse的子接口。是专用于HTTP协议的
方法:
getWriter():得到打印流
setContentType(String type) :设置响应类型
```

#### 8.HttpServlet *

通常重写doGet和doPost的方法即可

```java
public class UsserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
```



#### 9.Servlet的配置方式

一．可以通过在web.xml配置

```java
<servlet>
  <servlet-name>Hello</servlet-name>
  <servlet-class>com.kyjk.conreoll.UserConreoller</servlet-class>
</servlet>
<servlet-mapping>
  <servlet-name>Hello</servlet-name>
  <url-pattern>*do</url-pattern>
</servlet-mapping>
```

 

二．通过注解进行配置

```java
@WebServlet("*do")
public class UsserServlet implements Servlet {
}
```

#### 10.JSP的九大内置对象(隐含对象)

request:就是HttpServletRequest的对象*

response:就是HttpServletResponse对象,开发中几乎不用

pageContext:是PageContext的类型的对象，代表着当前jsp的上下文，可以通过它获取其他的隐含对象*

session:是HttpSession的类型,代表着当前的一次会话*

application  就是ServletContext类型对象,当前web应用程序上下文*

config    就是ServletConfig的对象

out      就是JspWriter的对象，可以向客户端打印内容

page   就是当前jsp的引用

exception:代表着异常，在特殊的情况下可以使用

#### 11.pageContext,request,session,application:属性域对象

> 可以设置属性，作用范围不一样

属性相关的方法*:

```java
setAttribute(String name, Object object) :设置属性
getAttribute(String name) ：获取指定属性
removeAttribute(String name) :移除指定属性
```

pageContext的属性作用域对当前JSP有效.

request的属性作用域对当前的一次请求有效

session的属性作用域对当前的一次会话有效

application的属性作用域对当前的web应用程序有效.

#### 12.请求的转发和重定向*****

1.请求的转发:

```java
request.getRequestDispatcher("index.jsp").forward(request,response);
```

2.请求的重定向:

```java
response.sendRedirect("index.jsp");
```

- 区别:

  1.转发的只发有一次请求,而请求的重定向是多次请求  *

  2.对于转发，浏览器的url是第一次请求的url，而重定向的浏览器的地址目标的地址

  3.转发只有一次请求，那么request应是同一个,意味着在request中设置属性值，转发后可以得到属性值，而重定向获取不到.



#### 13.Cookie:

> Cookie是在浏览器访问WEB服务器的某个资源时，由WEB服务器在HTTP响应消息头(set-cookies)
>
> 一旦WEB浏览器保存了某个Cookie，那么它在以后每次访问该WEB服务器时，都会在HTTP请求头(Cookie请求头)将这个Cookie回传给WEB服务器

1.创建Cookie

```java
Cookie cookie = new Cookie("name","tom");
```

2.把cookie传给浏览器

```java
response.addCookie(cookie);
```

3.获取所有Cookie

```java
Cookie[] cookies = request.getCookies();
if(cookies != null){
    for(Cookie cookie:cookies){
        out.println(cookie.getName()+"---"+cookie.getValue());
        out.println("<br />");
    }
}
```

#### 14.session的概述:

> 一类用来在客户端与服务器端之间保持状态的解决方案.

- session的工作机制:

  在第一次请求jsp的时候，创建了session对象，session对象有个标识号(session.getId())

  之后响应的时候，会通过cookie的方式响应消息头(set-cookies)，JSESSIONID=xxxxxxxx;

  之后再次请求，通过请求头Cookie:JSESSIONID=xxxxxxxx,带到服务器 ，那么就能通过标识号(JSESSIONID)找到对用的session对象

  session默认是会话级别的，当浏览器关闭的时候，在打开请求的时候，那么就会创建新的session对象，但是原来的session(当没有失效)还存在.

session的相关方法：

```java
getId() :获取当前session的标识号
setAttribute(String name, Object value):
getAttribute(String name)
removeValue(String name)
setMaxInactiveInterval(int interval)： 设置session的存活时间
getMaxInactiveInterval() ：得到session的存活时间
isNew() :session是新创建的
invalidate() ：销毁session
getLastAccessedTime()：得到上一次访问session时间
getCreationTime() :得到session的创建时间
```

#### 15.Filter过滤器

> 可以对请求进行拦截，从而在进行响应处理的前后实现一些特殊的功能。

1.实现Fielter接口

```java
public class HelloFilter implements Filter{
......
```

2.需要在web.xml中进行配置

```java
   <!-- 配置filter -->
  <filter>
   <filter-name>HelloFilter</filter-name>
   <filter-class>com.javaweb.test.HelloFilter</filter-class>
  </filter>
  <!-- 配置filter的映射 -->
  <filter-mapping>
   <filter-name>HelloFilter</filter-name>
   <!-- 配置需要拦截url -->
   <url-pattern>/test.jsp</url-pattern>
  </filter-mapping>
```

3.Filter的生命周期:

```java
init:当Servlet初始化的时候就创建了Filter对象,之后马上执行init方法,且只执行一次。可以做初始化工作。说明Filter实例是单例的.
doFilter:每次发请求都会执行doFilter的方法，实际上此方法是处理拦截的请求的方法.
destroy:当前应用被卸载的时候，被调用.可以做销毁工作。
```

