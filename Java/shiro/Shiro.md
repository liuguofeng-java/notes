## Shiro

#### 1.导入Mave依赖包

```xml
<dependencies>  
    <dependency>  
        <groupId>junit</groupId>  
        <artifactId>junit</artifactId>  
        <version>4.9</version>  
    </dependency>  
    <dependency>  
        <groupId>commons-logging</groupId>  
        <artifactId>commons-logging</artifactId>  
        <version>1.1.3</version>  
    </dependency>  
    <dependency>  
        <groupId>org.apache.shiro</groupId>  
        <artifactId>shiro-core</artifactId>  
        <version>1.2.2</version>  
    </dependency>  
</dependencies>   
```

#### 2.新建shiro.ini文件

```xml
[users]  
zhang=123  
wang=123  
```

#### 3.测试

```java
@Test
public void testHelloworld() {
    //1、获取SecurityManager工厂，此处使用Ini配置文件初始化SecurityManager
    Factory<SecurityManager> factory =
            new IniSecurityManagerFactory("classpath:shiro.ini");
    //2、得到SecurityManager实例 并绑定给SecurityUtils
    org.apache.shiro.mgt.SecurityManager securityManager = factory.getInstance();
    SecurityUtils.setSecurityManager(securityManager);
    //3、得到Subject及创建用户名/密码身份验证Token（即用户身份/凭证）
    Subject subject = SecurityUtils.getSubject();
    UsernamePasswordToken token = new UsernamePasswordToken("zhang", "123");
    try {
        //4、登录，即身份验证
        subject.login(token);
        System.out.println("登录成功");
    } catch (AuthenticationException e) {
        System.out.println("登录失败了   " + e.getMessage());
    }catch (Exception e){
        System.out.println("登录失败了   " + e.getMessage());
    }
    Assert.assertEquals(true, subject.isAuthenticated()); //断言用户已经登录
    //6、退出
    subject.logout();
}
```

