## HttpServlet使用

##### 1.一般 Servlet 程序想实现web服务器功能,一般继承HttpServlet

##### 2.继承 HttpServlet 需要重写 doGet() 和 doPost();

##### 3.Servlet 九大内置对象

request				请求对象

response				响应对象

session				服务器存储客户端信息

out 					输出流 PrintWreiter

application			应用程序对象

config				配置对象

page				页面对象

pageContext			页面上下文

exception				异常对象

##### 4.request常用方法

request.getRequestURI();															获取请求路径如：localhost:8080/app/index

request.getRequestURL();															获取请求全路径如：localhost:8080/app/index

request.getRemoteHost();															获取用户ip

request.getHeader("Context-Type");													获取请求头

request.getParameter("name");														获取参数

request.getRequestDispatcher("/WEB-INF/from.jsp").forward(request,response);				重定向

request.setAttribute(string,value)														设置request域属性

request.setAttribute(string)															获取request域属性

3.response常用方法

response.sendRedirect("/index")														转发到/index页面

response.getWreiter()																获取字符流

response.getOutputStream()															获取字节流

response.setContentType("text/html")													设置响应类型

response.setHreader(String,String)													设置响应头