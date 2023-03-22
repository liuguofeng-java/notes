## java文件上传

#### 1.文件上传必须满足条件

1. 普通表单提交默认enctype="application/x-www-form-urlencoded"；但是当表单中存在文件类型时，需要设置enctype="multipart/form-data"，它不对字符进行编码，用于发送二进制的文件（即所有文件类型，如视频、图片、音乐、文档都可以用此类型entype）；还有一种enctype="text/plain"用于发送纯文本内容。

2. 表单请求方式必须为post。

3. 接收时不能再用request.getParameter()，而是request.getInputStream()解析二进制流，得到ServletInputStream对象。

 

### 2.FileUpload组件

> fileUpload是apache的commons组件提供的上传组件，它最主要的工作就是帮我们解析request.getInpustream()

使用fileUpload组件首先需要引入两个jar包：

- commons-fileUpload.jar

- commons-io.jar

fileUpload的核心类有DiskFileItemFactory、ServletFileUpload、FileItem。

使用fileUpload固定步骤：

1. 创建工厂类：DiskFileItemFactory factory=new DiskFileItemFactory();

1. 创建解析器：ServletFileUpload upload=new ServletFileUpload(factory);

1. 使用解析器解析request对象：List<FileItem> list=upload.parseRequest(request);

一个FileItem对象对应一个表单项。FileItem类有如下方法：

- String getFieldName()：获取表单项的name的属性值。

- String getName()：获取文件字段的文件名。如果是普通字段，则返回null

- String getString()：获取字段的内容。如果是普通字段，则是它的value值；如果是文件字段，则是文件内容。

- String getContentType()：获取上传的文件类型，例如text/plain、image。如果是普通字段，则返回null。

- long getSize()：获取字段内容的大小，单位是字节。

- boolean isFormField()：判断是否是普通表单字段，若是，返回true，否则返回false。

- InputStream getInputStream()：获得文件内容的输入流。如果是普通字段，则返回value值的输入流。

 

1. 表单提交页面

```java
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
 
<head>
    <title>练习</title>
</head>
<body>
<form action="/UploadServlet" enctype="multipart/form-data" method="post">
    <input type="text" name="username">
    <input type="password" name="pwd">
    <input type="file" name="pic">
    <input type="submit">
</form>
 
</body>
</html>
```



2.UploadServlet代码

```java
 
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import sun.misc.IOUtils;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;
 
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DiskFileItemFactory factory=new DiskFileItemFactory();
        ServletFileUpload upload=new ServletFileUpload(factory);
 
        request.setCharacterEncoding("utf-8");
        //文件名中文乱码处理也可以如此写
//        upload.setHeaderEncoding("utf-8");
 
        //设置缓冲区大小与临时文件目录
        factory.setSizeThreshold(1024*1024*10);
        File uploadTemp=new File("e:\\uploadTemp");
        uploadTemp.mkdirs();
        factory.setRepository(uploadTemp);
 
        //设置单个文件大小限制
        upload.setFileSizeMax(1024*1024*10);
        //设置所有文件总和大小限制
        upload.setSizeMax(1024*1024*30);
 
        try {
            List<FileItem> list=upload.parseRequest(request);
            System.out.println(list);
            for (FileItem fileItem:list){
                if (!fileItem.isFormField()&&fileItem.getName()!=null&&!"".equals(fileItem.getName())){
                    String filName=fileItem.getName();
                    //利用UUID生成伪随机字符串，作为文件名避免重复
                    String uuid= UUID.randomUUID().toString();
                    //获取文件后缀名
                    String suffix=filName.substring(filName.lastIndexOf("."));
 
                    //获取文件上传目录路径，在项目部署路径下的upload目录里。若想让浏览器不能直接访问到图片，可以放在WEB-INF下
                    String uploadPath=request.getSession().getServletContext().getRealPath("/upload");
 
                    File file=new File(uploadPath);
                    file.mkdirs();
                    //写入文件到磁盘，该行执行完毕后，若有该临时文件，将会自动删除
                    fileItem.write(new File(uploadPath,uuid+suffix));
                    
                }
            }
        }  catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
```

3.ajax上传

```java
<html>

<head>
    <title>练习</title>
</head>
<body>
<form action="/index" enctype="multipart/form-data" method="post">
    <input type="text" name="username">
    <input type="password" name="pwd">
    <input type="file" name="pic">
    <input type="submit">
</form>
<input name="file" type="file" id="fileCont" value="">

<script src="${pageContext.request.contextPath}/status/jquery.min.js"></script>
<script>
    $('#fileCont').on('change', function () {
        console.log($(this))
        var fileObj = document.querySelector("#fileCont").files[0];
        if (typeof (fileObj) == "undefined" || fileObj.size <= 0) {
            //这里是我自己定义的弹框方法
            popup({ type: 'tip', bg: false, msg: "请选择件", delay: 1000, clickDomCancel: true });
            return;
        }
        var formFile = new FormData();
        //加入文件对象,向接口传入两个参数file,id
        formFile.append("file", fileObj);
        var data = formFile;
        $.ajax({
            url:"${pageContext.request.contextPath}/index",
            data: data,
            type: "POST",
            dataType: "json",
            //上传文件无需缓存
            cache: false,
            //用于对data参数进行序列化处理 这里必须false
            processData: false,
            //必须
            contentType: false,
            success: function (res) {
                if (res.code === 200) {
                    popup({ type: 'success', bg: false, msg: "上传成功", delay: 1000, clickDomCancel: true });
                } else {
                    popup({ type: 'error', bg: false, msg: res.msg, delay: 1000, clickDomCancel: true });
                }
            },
        })
    })
</script>
</body>
</html>
```

