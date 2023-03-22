## Java请求Http

```csharp
<dependency>
    <groupId>commons-httpclient</groupId>
    <artifactId>commons-httpclient</artifactId>
    <version>3.1</version>
</dependency>
```



```csharp
public static String post(String url,String data) throws Exception {
    String result = null;
    try{
        // 创建httpClient实例对象
        HttpClient httpClient = new HttpClient();
        // 设置httpClient连接主机服务器超时时间：15000毫秒
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(15000);
        // 创建post请求方法实例对象
        PostMethod postMethod = new PostMethod(url);
        RequestEntity requestEntity = new StringRequestEntity(data,"application/json", "UTF-8");
        postMethod.setRequestEntity(requestEntity);
        // 设置post请求超时时间
        postMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 60000);
        postMethod.addRequestHeader("Content-Type", "application/json");
        httpClient.executeMethod(postMethod);
        result = postMethod.getResponseBodyAsString();
        postMethod.releaseConnection();
    }catch (Exception e){
        throw new Exception(e);
    }
    return result;
}
public static String get(String url) throws HttpException, Exception {
    String result = null;
    try {
        // 创建httpClient实例对象
        HttpClient httpClient = new HttpClient();
        // 设置httpClient连接主机服务器超时时间：15000毫秒
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(15000);
        // 创建GET请求方法实例对象
        GetMethod getMethod = new GetMethod(url);
        // 设置post请求超时时间
        getMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 60000);
        getMethod.addRequestHeader("Content-Type", "application/json");
        httpClient.executeMethod(getMethod);
        result = getMethod.getResponseBodyAsString();
        getMethod.releaseConnection();
    }catch (Exception e){
        throw new Exception(e);
    }
    return result;
}
```
