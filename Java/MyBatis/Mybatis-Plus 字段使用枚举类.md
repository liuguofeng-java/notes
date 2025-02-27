## Mybatis-Plus 字段使用枚举类

##### 1.配置 MyBatis-Plus 枚举处理器

在 `application.yml` 中启用 MyBatis-Plus 的枚举自动转换：

```yaml
mybatis-plus:
  configuration:
    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler
```

##### 2.为字段 `status` 字段创建一个枚举类：

```java
/**
 * 任务状态
 *
 * @author liuguofeng
 * @date 2025/02/27 09:14
 **/
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum TaskStatus {
    NEW(0, "新增"),
    INITIALIZED(1, "初始化"),
    RUNNING(2, "执行中"),
    COMPLETED(3, "任务完成"),
    FAILED(4, "执行失败");

    @Getter
    @EnumValue
    private final int code;

//  @JsonValue
    @Getter
    private final String description;


    TaskStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public static TaskStatus fromCode(int code) {
        for (TaskStatus status : TaskStatus.values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("无效状态码: " + code);
    }
}
```

##### 3.在实体类中使用

```java
@Data
@TableName(value = "cases_info", autoResultMap = true)
public class CasesInfo {
    private Long id;
    
    // 使用枚举类
    private TaskStatus status;
}
```

##### 4.说明

1. 上述描述的**TaskStatus**返回给前端的数据为:

   ```json
   {
     "id": 1,
     "status": {
       "code": 2,
       "description": "执行中"
     }
   }
   ```

2. 如果想只返回**code**或**description**，要在枚举字段中添加**@JsonValue**，如在**description**中添加**@JsonValue**则返回：

   ```json
   {
     "id": 1,
     "status": "执行中"
   }
   ```

   

