## 基于xml配置spring

## 1.利用工厂模式和反射创建实例

1.引入maven坐标

```java
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.3.8</version>
</dependency>
```



## 2.基于xml配置

### 1.<bean ></bean> :在ioc 容器实例化对象

```java
<bean id="userModel" class="com.demo.entity.UserModel" scope="prototype" factory-bean="" factory-method=""></bean>
```

1.id:唯一标识

2. class : 类的路径

3.scope : scope ="prototype" 创建多利对象 ,scope = "single" 创建单例对象

3.factory-bean : 工厂模式创建bean

4.factory-model ： 指定工厂初始化方法

### 2.实例化对象

```java
// 创建和配置bean
ApplicationContext context = new ClassPathXmlApplicationContext("bean.xml");
// 创建实例
UserModel userModel= context.getBean("userModel", UserModel.class);
```

### 3.<import/> :导入其他 xml

```java
<beans>
    <import resource="services.xml"/>
    <import resource="resources/messageSource.xml"/>
    <import resource="/resources/themeSource.xml"/>

    <bean id="bean1" class="..."/>
    <bean id="bean2" class="..."/>
</beans>
```

### 4.实例化bean的方法

1.通过空参构造器创建

```java
<bean id="userModel" class="com.demo.entity.UserModel"></bean>
```

2.通过静态工厂创建

```java
public class UserFactory {
    private UserFactory(){};
    public static UserModel createInstance() {
        return new UserModel();
    }
}

<bean id="userModel"
      class="com.demo.entity.UserFactory"
      factory-method="createInstance"/>
```

3.通过工厂实例创建

```java
public class DefaultServiceLocator {
    private static ClientService clientService = new ClientServiceImpl();
    private static AccountService accountService = new AccountServiceImpl();
    public ClientService createClientServiceInstance() {
        return clientService;
    }
    public AccountService createAccountServiceInstance() {
        return accountService;
    }
}
<bean id="serviceLocator" class="examples.DefaultServiceLocator">
    <!-- inject any dependencies required by this locator bean -->
</bean>

<bean id="clientService"
    factory-bean="serviceLocator"
    factory-method="createClientServiceInstance"/>

<bean id="accountService"
    factory-bean="serviceLocator"
    factory-method="createAccountServiceInstance"/>
```

### 5.依赖注入

1.通过构造器注入

```java
public class UserModel {
    private Date createTime;
    public UserModel(Date createTime){
        this.createTime = createTime;
    }
}

<bean id="userModel" class="com.demo.entity.UserModel">
    <constructor-arg name="createTime" value="now" />
</bean>
<bean id="now" class="java.util.Date"/>
```

2.通过setter属性注入

```java
public class UserModel {
    private String name;
    
    public void setName(String name) {
        this.name = name;
    }
}
<bean id="userModel2" class="com.demo.UserModel">
    <property name="name" value="张三"/>
</bean>
```



## 3.基于注解配置

1.如果使用注解方式，必须在xml中开启注解

```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd">

   <context:component-scan base-package="com.demo"/>

</beans>
```





