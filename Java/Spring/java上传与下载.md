## java上传与下载

```xml
<dependency>
  <groupId>commons-io</groupId>
  <artifactId>commons-io</artifactId>
  <version>1.3.2</version>
</dependency>
<dependency>
  <groupId>commons-fileupload</groupId>
  <artifactId>commons-fileupload</artifactId>
  <version>1.3.2</version>
</dependency>
```

#### 上传

```java
@RequestMapping(name = "/upLoadFile")
public String upLoadFile(HttpServletRequest request) throws Exception {
    DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
    ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);
    fileUpload.setHeaderEncoding("UTF-8");
    List<FileItem> list = fileUpload.parseRequest(request);
    for (FileItem item : list) {
        if(!item.isFormField()){
            String fileName = item.getName();
            System.out.println(fileName);
            if(fileName==null||fileName.trim().equals("")){
                continue;
            }
            InputStream is = item.getInputStream();
            FileOutputStream fos = new FileOutputStream("d:/"+fileName);
            byte buffer[] = new byte[1024];
            int length = 0;
            while((length = is.read(buffer))>0){
                fos.write(buffer, 0, length);
            }
            is.close();
            fos.close();
            item.delete();
        }
    }
    return "success";
}
```



```html
<form action="${pageContext.request.contextPath}/upLoadFile" method="post" enctype="multipart/form-data">
    <input type="file" name="files">
    <input type="submit" value="上传">
</form>
```

#### 采用spring上传

```xml
<!-- 多部分文件上传 -->
<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
    <property name="maxUploadSize" value="104857600" />
    <property name="maxInMemorySize" value="4096" />
    <property name="defaultEncoding" value="UTF-8"></property>
</bean>
```



```java
/*
 *采用spring提供的上传文件的方法
 */
@RequestMapping("springUpload")
public String  springUpload(HttpServletRequest request) throws IllegalStateException, IOException
{
    //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
    CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getSession().getServletContext());
    //检查form中是否有enctype="multipart/form-data"
    if(multipartResolver.isMultipart(request))
    {
        //将request变成多部分request
        MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
        //获取multiRequest 中所有的文件名
        Iterator iter=multiRequest.getFileNames();

        while(iter.hasNext())
        {
            //一次遍历所有文件
            MultipartFile file=multiRequest.getFile(iter.next().toString());
            if(file!=null)
            {
                String path="d:/springUpload"+file.getOriginalFilename();
                //上传
                file.transferTo(new File(path));
            }
        }
    }
    return "/success";
}
```



```html
<form action="${pageContext.request.contextPath}/springUpload" method="post"  enctype="multipart/form-data">
    <input type="file" name="file">
    <input type="submit" value="upload"/>
</form>
```

#### 下载文件

```java
@RequestMapping("/download")
public String download(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setCharacterEncoding("utf-8");
    //返回的数据类型
    response.setContentType("application/mshelp");
    //响应头
    response.setHeader("Content-Disposition", "attachment;fileName=" + "jdk api 1.8.CHM");
    InputStream inputStream=null;
    OutputStream outputStream=null;
    //路径
    String path ="D:\\文件\\";
    byte[] bytes = new byte[2048];
    try {
        File file=new File(path,"jdk api 1.8.CHM");
        inputStream = new FileInputStream(file);
        outputStream = response.getOutputStream();
        int length;
        //inputStream.read(bytes)从file中读取数据,-1是读取完的标志
        while ((length = inputStream.read(bytes)) > 0) {
            //写数据
            outputStream.write(bytes, 0, length);
        }
    } catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }finally {
        //关闭输入输出流
        if(outputStream!=null) {
            outputStream.close();
        }
        if(inputStream!=null) {
            inputStream.close();
        }
    }
    return null;
}
```



```java
<form action="${pageContext.request.contextPath}/springUpload" method="post"  enctype="multipart/form-data">
    <input type="file" name="file">
    <input type="submit" value="upload"/>
</form>
```

