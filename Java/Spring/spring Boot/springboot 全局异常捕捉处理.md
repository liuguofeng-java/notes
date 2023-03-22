## springboot 全局异常捕捉处理
```csharp
@ControllerAdvice
public class MyControllerAdvice {
    /**
     * 全局异常捕捉处理
     * @param ex
     * @return
     */
    @ResponseBody
    @ExceptionHandler(value = Exception.class)
    public void errorHandler(Exception ex) {
        System.out.println(ex);
    }
}
```

