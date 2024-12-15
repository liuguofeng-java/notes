## spring mvc文件上传

模拟表单提交

```java
var form = new FormData();
form.append('file', file)
form.append("name","tom")
$.ajax({
    data:form
})
```

MultipartFile 上传

```java
/**
 * 实现文件上传
 * */
@RequestMapping("/fileUpload" , consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public Map<String,Object> fileUpload(HttpServletRequest request, @RequestParam("file") MultipartFile file,String name){
    System.out.println("name:" + name);
    Map<String,Object> result = new HashMap<>();
    //获取项目访问路径
    String root = request.getRequestURL().toString().replace(request.getRequestURI(),"");
    if(file.isEmpty()){
        return null;
    }
    //获取文件名
    String fileName = file.getOriginalFilename();
    //重命名文件
    String imgName = RandomUtil.randomUUID() + fileName.substring(fileName.lastIndexOf("."));
    logger.debug("上传图片保存在：" + imgPath + imgName);
    File dest = new File(imgPath + imgName);
    img.put(System.currentTimeMillis(),imgPath + imgName);
    //判断文件父目录是否存在
    if(!dest.getParentFile().exists()){
        dest.getParentFile().mkdir();
    }
    try {
        //保存文件
        file.transferTo(dest);
        //返回图片访问路径
        result.put("url",root +"/img/" + imgName);
        logger.debug("图片保存成功，访问路径为："+result.get("url"));
        return result;
    } catch (IllegalStateException e) {
        e.printStackTrace();
        logger.error("图片保存失败！");
    } catch (IOException e) {
        e.printStackTrace();
        logger.error("图片保存失败！");
    }
    return null;
}
```

