## @Valid介绍及相关注解

```xml
<dependency>
      <groupId>javax.validation</groupId>
      <artifactId>validation-api</artifactId>
      <version>2.0.1.Final</version>
 </dependency>

或者

<dependency>
    <groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

@Valid注解用于校验，所属包为：javax.validation.Valid。

加入maven依赖

#### 1. 首先需要在实体类的相应字段上添加用于充当校验条件的注解，如：@Min,如下代码（age属于Girl类中的属性）：

    @Min(value = 18,message = "成年人")
    
    private Integer age;

#### 2.其次在controller层的方法的要校验的参数上添加@Valid注解，并且需要传入BindingResult对象，用于获取校验失败情况下的反馈信息，如下代码：

```javascript
@PostMapping("/save/user")
public Girl addGirl(@Valid User user, BindingResult bindingResult) {
    if(bindingResult.hasErrors()){
        System.out.println(bindingResult.getFieldError().getDefaultMessage());
        return null;
    }
    return girlResposity.save(uer);
}
```

bindingResult.getFieldError.getDefaultMessage()用于获取相应字段上添加的message中的内容，如：@Min注解中message属性的内容

限制  说明

```javascript
@Null   限制只能为null
@NotNull    限制必须不为null
@AssertFalse    限制必须为false
@AssertTrue 限制必须为true
@DecimalMax(value)  限制必须为一个不大于指定值的数字
@DecimalMin(value)  限制必须为一个不小于指定值的数字
@Digits(integer,fraction)   限制必须为一个小数，且整数部分的位数不能超过integer，小数部分的位数不能超过fraction
@Future 限制必须是一个将来的日期
@Max(value) 限制必须为一个不大于指定值的数字
@Min(value) 限制必须为一个不小于指定值的数字
@Past   限制必须是一个过去的日期
@Pattern(regexp="^1$|^0$",message = "xxxx不正确") 限制必须1或0
@Size(max,min)  限制字符长度必须在min到max之间
@Past   验证注解的元素值（日期类型）比当前时间早
@NotEmpty   验证注解的元素值不为null且不为空（字符串长度不为0、集合大小不为0）
@NotBlank   验证注解的元素值不为空（不为null、去除首位空格后长度为0），不同于@NotEmpty，@NotBlank只应用于字符串且在比较时会去除字符串的空格
@Email  验证注解的元素值是Email，也可以通过正则表达式和flag指定自定义的email格式


如果验证list
 @Valid
@NotNull(message="item不能为空")
@ApiModelProperty("item")
private List<MapAppItemDto> items;
```



#### SpringBoot拦截@Valid抛出的错误

```java
/**
 * 全局异常处理器
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 自定义验证异常
     */
    @ExceptionHandler(BindException.class)
    public AjaxResult handleBindException(BindException e) {
        String message = e.getAllErrors().get(0).getDefaultMessage();
        return AjaxResult.error(message);
    }

    /**
     * 自定义验证异常
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Object handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getFieldError().getDefaultMessage();
        return AjaxResult.error(message);
    }
}
```



