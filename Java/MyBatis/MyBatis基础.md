## MyBatis基础

1使用mybatis mapper.xml方式查询

- 1.新建mybatis全局配置文件

```csharp
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!--环境配置，连接的数据库，这里使用的是MySQL-->
    <environments default="mysql">
        <environment id="mysql">
            <!--指定事务管理的类型，这里简单使用Java的JDBC的提交和回滚设置-->
            <transactionManager type="JDBC"></transactionManager>
            <!--dataSource 指连接源配置，POOLED是JDBC连接对象的数据源连接池的实现-->
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"></property>
                <property name="url" value="jdbc:mysql://127.0.0.1:3306/mybatis"></property>
                <property name="username" value="root"></property>
                <property name="password" value="1234"></property>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <!--这是告诉Mybatis区哪找持久化类的映射文件，对于在src下的文件直接写文件名，
            如果在某包下，则要写明路径,如：com/mybatistest/config/User.xml-->
        <mapper resource="mapper/UserMapper.XML"/>
    </mappers>
</configuration>
```

 

- 2.建立mapper.xml

```csharp
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com">
    <select id="selectAll" resultType="com.gwtj.pojo.User">
        select * from user
    </select>
</mapper>
```

 

- 3.建立mybatis实例

```csharp
//创建sqlsession工厂
SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(new FileInputStream("src/main/resources/config.xml"));
SqlSession sqlSession = factory.openSession();
//查询数据库
List<User> user = sqlSession.selectList("com.selectAll");
for (int i = 0; i < user.size();i++){
    System.out.println(user.get(i));
}
```

 

2使用mybatis 注解方式查询

- 1.新建一个mapper接口

```csharp
public interface UserMapper {
    @Select("select * from user")
    List<User> selectAll();
}
```

- 2.在全局配置文件配置接口位置

```csharp
<mapper class="com.mybatis.mapper.UserMapper"/>
```

- 3.建立mybatis实例

```csharp
//创建sqlsession工厂
SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(new FileInputStream("src/main/resources/config.xml"));
SqlSession sqlSession = factory.openSession();
//返回一个新的Mapper实现对象
UserMapper mapper = connection.getMapper(UserMapper.class);
//查询数据库
List<User> users = mapper.selectAll();
for (int i = 0; i < user.size();i++){
    System.out.println(user.get(i));
}
```

3. mapper.xml标签

- 1.sql语句的映射返回值类型

resultType //sql语句的映射返回值类型

- 2.sql语句的执行条件

parameterType //sql语句的执行条件

- 3.查询语句必须使用resultMap 

<!--id :唯一标识-->

<!--type：映射结果返回值-->

<resultMap id="User" type="com.mybatis.pojo.User">

    <!--id：映射主键-->

    <!-- column：映射数据库字段-->

    <!--property：映射实体类字段-->

    <id column="user_id" property="id" />

    <result column="user_username" property="username"/>

    <result column="user_password" property="password"/>

<!--配置一对一个实体类-->

<!--property：类名--><!--javaType：全类名-->

<association property="" javaType=""></association>

<!--配置一对多个实体类-->

<!--property：类名--><!--ofType：集合类型-->

<collection property="" ofType=""></collection>

</resultMap>

- 4.语句判断；tset：条件，条件如果是基本类型则用_parameter

<if test="">

    

</if>

- 5.智能去除sql语句前面的and或or

<where>

    

</where>

- 6.trim判断

prefix:把内容显示在sql语句前面

prefixOverrides：删除前面的内容

suffix：把内容显示在sql语句后面

suffixOverrides：删除后面的内容

<trim prefix="" prefixOverrides="" suffix="" suffixOverrides=""></trim>

 

- 7. 用于更新，代表set，去除无关的逗号

<set>

    

</set>

 

- 8.超级for循环

collection:循环集合名称

item ：循环元素

open：以内容开始

close：以内容结束

separator:以内容结束

<foreach collection="list" item="id" open="(" close=")" separator=",">

#{id}

</foreach>

- 9.sql片段

<sql id="selectAll">

    select * from user

</sql>

可以用 include引用sql片段

<include refid="selectAll"></include>