## MyBatis-Plus中json类型转换

#### 1.当数据库中设置的字段是json类型时，可以只有类型转换成自己想要的类型

![image-20231220161629587](../../assets/image-20231220161629587.png)

##### 2.在实体类中添加如下注解

> `@TableName(value = "sys_deploy_node", autoResultMap = true)`
>
> 1.转成map类型:`@TableField(typeHandler = JacksonTypeHandler.class)`
>
> 2.要转成特别类型:`@TableField(typeHandler = NodeColumnTypeHandler.class)`

![image-20231220161811647](../../assets/image-20231220161811647.png)

#### 3.自定义转换器

```java
/**
 * 数据转换
 *
 * @author liuguofeng
 * @date 2023/12/15 22:06
 **/
@MappedTypes({List.class})
@MappedJdbcTypes(JdbcType.VARCHAR)
public class NodeColumnTypeHandler extends BaseTypeHandler<List<NodeColumnItem>> {


    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, List<NodeColumnItem> nodeColumnItems, JdbcType jdbcType) throws SQLException {
        preparedStatement.setString(i, JSON.toJSONString(nodeColumnItems));
    }

    @Override
    public List<NodeColumnItem> getNullableResult(ResultSet resultSet, String s) throws SQLException {
        String str = resultSet.getString(s);
        return JSON.parseArray(str, NodeColumnItem.class);
    }

    @Override
    public List<NodeColumnItem> getNullableResult(ResultSet resultSet, int i) throws SQLException {
        String str = resultSet.getString(i);
        return JSON.parseArray(str, NodeColumnItem.class);
    }

    @Override
    public List<NodeColumnItem> getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        String str = callableStatement.getString(i);
        return JSON.parseArray(str, NodeColumnItem.class);
    }
}
```

