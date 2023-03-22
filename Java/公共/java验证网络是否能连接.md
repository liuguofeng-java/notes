## java验证网络是否能连接

```csharp
public String isConnect() throws Exception {
    BufferedReader br = null;
    try{
        Runtime runtime = Runtime.getRuntime();
        Process process = runtime.exec("ping " + "www.baidu.com");
        InputStreamReader inputStreamReader = new InputStreamReader(process.getInputStream(), "GB2312");
        br = new BufferedReader(inputStreamReader);
        String line = null;
        StringBuffer sb = new StringBuffer();
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        if(!sb.toString().contains("平均")){
            return "无网络";
        }
        else{
            return sb.toString().substring(sb.toString().lastIndexOf("平均")+5,sb.length());
        }
    }catch (Exception e){
        throw new Exception();
    }finally {
        if (br != null){
            br.close();
        }
    }
}
```

