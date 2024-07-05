## BigDecimal返回前端保存两位小数

##### 1.编写自定义序列化器：BigDecimalSerializer

```java
/**
 * BigDecimal类型转换
 *
 * @author liuguofeng
 * @date 2024/07/05 16:55
 **/
public class BigDecimalSerializer extends JsonSerializer<BigDecimal> {

    public void serialize(BigDecimal value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (value != null) {
            BigDecimal number = value.setScale(2, RoundingMode.HALF_UP);
            String string = number.toString();
            gen.writeString(string);
        } else {
            gen.writeString(BigDecimal.ZERO.toPlainString());
        }

    }
}
```

##### 2.在需要的对象上添加注解`@JsonSerialize`即可：

```java
@JsonSerialize(using = BigDecimalSerializer.class)
private BigDecimal totalMoney;
```