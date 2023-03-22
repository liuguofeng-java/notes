## 基于注解配置spring

1.@controller 控制器（注入服务）

用于标注控制层，相当于struts中的action层

2.@service 服务（注入dao）



用于标注服务层，主要用来进行业务的逻辑处理

3.@repository（实现dao访问）



用于标注数据访问层，也可以说用于标注数据访问组件，即DAO组件.

4.@component （把普通pojo实例化到spring容器中，相当于配置文件中的<bean id="" class=""/>）



5.@Autowired 自动装配，把ioc容器内的bean匹配到引用内

   @Qulifier 可以指定Autowred自动装配 bean的名称



6.@Resource 也可以自动装配 name 可以指定容器bean名称



7.@scope 注解是springIoc容器中的一个作用域，在 Spring IoC 容器中具有以下几种作用域：基本作用域singleton（单例）、prototype(多例)



8.@Configuration 可在类上添加，标识是spring配置类



9.@ComponentScan 扫描spring注解所在的包路径 替换<context:component-scan base-package="com.demo"/> 标签



10.@Import 导入其他spring配置类



11.@Bean 把方法返回的对象存放到ioc容器



12.@PropertySource(value = {}) 和 @value PropertySource:加载.properties文件，使用@value("${xxx}")读取加载后的文件



13.@RunWith(SpringJunit4ClassRunner.class) 和 @ ContextConfiguration(classes={}) 配置spring测试环境

