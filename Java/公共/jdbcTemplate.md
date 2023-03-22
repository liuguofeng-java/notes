## jdbcTemplate

#### 1.bean.xml配置

```xml
<!--JdbcTemplate-->
<bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
    <property name="dataSource" ref="dataSource"></property>
</bean>
<!--数据源-->
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource" scope="prototype">
    <property name="driverClassName" value="com.mysql.jdbc.Driver"></property>
    <property name="url" value="jdbc:mysql://localhost:3306/peis"></property>
    <property name="username" value="root"></property>
    <property name="password" value="KunYujk1!"></property>
</bean>

```

或者

```java
@Configuration //加载类
@ComponentScan(basePackages = {"com.dome"})// =<context:component-scan base-package="com.dome"></context:component-scan>
public class SpringConfiguration {
    @Bean(name = "jdbcTemplate")
    public JdbcTemplate createJdbcTemplate(DriverManagerDataSource driverManagerDataSource){
        return new JdbcTemplate(driverManagerDataSource);
    }
    @Bean(name = "driverManagerDataSource")
    public DriverManagerDataSource createSource(){
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("com.mysql.jdbc.Driver");
        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/peis");
        driverManagerDataSource.setUsername("root");
        driverManagerDataSource.setPassword("KunYujk1!");
        return driverManagerDataSource;
    }

}
```

#### 2.测试

```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:bean.xml"})
public class UserServiceTest {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Test
    public void dome1(){
        List<PeisUserinfo> userinfoList = jdbcTemplate.query("select * from peis_userinfo", new BeanPropertyRowMapper<PeisUserinfo>(PeisUserinfo.class));
        for (PeisUserinfo peisUserinfo : userinfoList){
            System.out.println(peisUserinfo);
        }
    }
    @Test
    public void dome2(){
        int i = jdbcTemplate.update("delete from peis_userinfo where id = ?" ,"12344");
        System.out.println(i);
    }
    @Test
    public void dome3(){
        int i = jdbcTemplate.update("insert into peis_userinfo(id,user_name) values(?,?)" ,"123456789","tom");
        System.out.println(i);
    }
    @Test
    public void dome4(){
        int i = jdbcTemplate.update("update peis_userinfo set id = ? where user_name=?" ,"0","tom");
        System.out.println(i);
    }
}
```

