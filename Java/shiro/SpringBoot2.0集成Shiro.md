## SpringBoot2.0集成Shiro

最近搞了下shiro安全框架，网上找了好多篇博客，感觉要么都是复制粘贴，要么就是错误百出。至于稍微讲解一下为什么要这么做，就更别说了。这篇文章就教大家如何将 Shiro 整合到 SpringBoot 中，并且避开一些小坑，由浅入深，从最基本的配置开始，一步一步加入新的功能。这样理解起来也稍微简单

项目版本：

```java
springboot2.x
shiro：1.3.2
```



Maven配置：

```java
<dependency>
    <groupId>org.apache.shiro</groupId>
    <artifactId>shiro-spring</artifactId>
    <version>1.3.2</version>
```



写在前面的话：

springboot中集成shiro相对简单，只需要两个类：一个是shiroConfig类，一个是CustonRealm类。



ShiroConfig类：

顾名思义就是对shiro的一些配置，相对于之前的xml配置。包括：过滤的文件和权限，密码加密的算法，其用注解等相关功能。



CustomRealm类：

自定义的CustomRealm继承AuthorizingRealm。并且重写父类中的doGetAuthorizationInfo（权限相关）、doGetAuthenticationInfo（身份认证）这两个方法。



最基本的配置：

shiroConfig配置：

```java
package com.cj.shirodemo.config;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 描述：
 *
 * @author caojing
 * @create 2019-01-27-13:38
 */
@Configuration
public class ShiroConfig {

    @Bean(name = "shiroFilter")
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        shiroFilterFactoryBean.setLoginUrl("/login");
        shiroFilterFactoryBean.setUnauthorizedUrl("/notRole");
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
        // <!-- authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问-->
        filterChainDefinitionMap.put("/webjars/**", "anon");
        filterChainDefinitionMap.put("/login", "anon");
        filterChainDefinitionMap.put("/", "anon");
        filterChainDefinitionMap.put("/front/**", "anon");
        filterChainDefinitionMap.put("/api/**", "anon");

        filterChainDefinitionMap.put("/admin/**", "authc");
        filterChainDefinitionMap.put("/user/**", "authc");
        //主要这行代码必须放在所有权限设置的最后，不然会导致所有 url 都被拦截 剩余的都需要认证
        filterChainDefinitionMap.put("/**", "authc");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;

    }

    @Bean
    public SecurityManager securityManager() {
        DefaultWebSecurityManager defaultSecurityManager = new DefaultWebSecurityManager();
        defaultSecurityManager.setRealm(customRealm());
        return defaultSecurityManager;
    }

    @Bean
    public CustomRealm customRealm() {
        CustomRealm customRealm = new CustomRealm();
        return customRealm;
    }
}
```





shiroConfig 也不复杂，基本就三个方法。再说这三个方法之前，我想给大家说一下shiro的三个核心概念：



Subject： 代表当前正在执行操作的用户，但Subject代表的可以是人，也可以是任何第三方系统帐号。当然每个subject实例都会被绑定到SercurityManger上。

SecurityManger:SecurityManager是Shiro核心，主要协调Shiro内部的各种安全组件，这个我们不需要太关注，只需要知道可以设置自定的Realm。

Realm:用户数据和Shiro数据交互的桥梁。比如需要用户身份认证、权限认证。都是需要通过Realm来读取数据。

shiroFilter方法：

这个方法看名字就知道了：shiro的过滤器，可以设置登录页面（setLoginUrl）、权限不足跳转页面（setUnauthorizedUrl）、具体某些页面的权限控制或者身份认证。

注意：这里是需要设置SecurityManager（setSecurityManager）。

默认的过滤器还有：anno、authc、authcBasic、logout、noSessionCreation、perms、port、rest、roles、ssl、user过滤器。

具体的大家可以查看package org.apache.shiro.web.filter.mgt.DefaultFilter。这个类，常用的也就authc、anno。

securityManager 方法：

查看源码可以知道 securityManager是一个接口类，我们可以看下它的实现类：



具体怎么实现的，感兴趣的同学可以看下。由于项目是一个web项目，所以我们使用的是DefaultWebSecurityManager ，然后设置自己的Realm。

CustomRealm 方法：

将 customRealm的实例化交给spring去管理，当然这里也可以利用注解的方式去注入。



customRealm配置：

```java
package com.cj.shirodemo.config;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

/**
 * 描述：
 *
 * @author caojing
 * @create 2019-01-27-13:57
 */
public class CustomRealm extends AuthorizingRealm {

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Set<String> stringSet = new HashSet<>();
        stringSet.add("user:show");
        stringSet.add("user:admin");
        info.setStringPermissions(stringSet);
        return info;
    }

    /**
     * 这里可以注入userService,为了方便演示，我就写死了帐号了密码
     * private UserService userService;
     * <p>
     * 获取即将需要认证的信息
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("-------身份认证方法--------");
        String userName = (String) authenticationToken.getPrincipal();
        String userPwd = new String((char[]) authenticationToken.getCredentials());
        //根据用户名从数据库获取密码
        String password = "123";
        if (userName == null) {
            throw new AccountException("用户名不正确");
        } else if (!userPwd.equals(password )) {
            throw new AccountException("密码不正确");
        }
        return new SimpleAuthenticationInfo(userName, password,getName());
    }
}
```



说明：

自定义的Realm类继承AuthorizingRealm类，并且重载doGetAuthorizationInfo和doGetAuthenticationInfo两个方法。

doGetAuthorizationInfo： 权限认证，即登录过后，每个身份不一定，对应的所能看的页面也不一样。

doGetAuthenticationInfo：身份认证。即登录通过账号和密码验证登陆人的身份信息。



controller类：

新建一个HomeIndexController类，加入如下代码：



```java
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    @ResponseBody
    public String defaultLogin() {
        return "首页";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public String login(@RequestParam("username") String username, @RequestParam("password") String password) {
        // 从SecurityUtils里边创建一个 subject
        Subject subject = SecurityUtils.getSubject();
        // 在认证提交前准备 token（令牌）
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        // 执行认证登陆
        try {
            subject.login(token);
        } catch (UnknownAccountException uae) {
            return "未知账户";
        } catch (IncorrectCredentialsException ice) {
            return "密码不正确";
        } catch (LockedAccountException lae) {
            return "账户已锁定";
        } catch (ExcessiveAttemptsException eae) {
            return "用户名或密码错误次数过多";
        } catch (AuthenticationException ae) {
            return "用户名或密码不正确！";
        }
        if (subject.isAuthenticated()) {
            return "登录成功";
        } else {
            token.clear();
            return "登录失败";
        }
    }
```



测试：

我们可以使用postman进行测试：



ok 身份认证是没问题了，我们再来考虑如何加入权限。



利用注解配置权限：

其实，我们完全可以不用注解的形式去配置权限，因为在之前已经加过了：DefaultFilter类中有perms（类似于perms[user:add]）这种形式的。但是试想一下，这种控制的粒度可能会很细，具体到某一个类中的方法，那么如果是配置文件配，是不是每个方法都要加一个perms？但是注解就不一样了，直接写在方法上面，简单快捷。

很简单，主需要在config类中加入如下代码，就能开启注解：



```java
	@Bean
public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
    return new LifecycleBeanPostProcessor();
}

/**
 * *
 * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions),需借助SpringAOP扫描使用Shiro注解的类,并在必要时进行安全逻辑验证
 * *
 * 配置以下两个bean(DefaultAdvisorAutoProxyCreator(可选)和AuthorizationAttributeSourceAdvisor)即可实现此功能
 * * @return
 */
@Bean
@DependsOn({"lifecycleBeanPostProcessor"})
public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator() {
    DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
    advisorAutoProxyCreator.setProxyTargetClass(true);
    return advisorAutoProxyCreator;
}

@Bean
public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor() {
    AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
    authorizationAttributeSourceAdvisor.setSecurityManager(securityManager());
    return authorizationAttributeSourceAdvisor;
}
```

新建一个UserController类。如下：



```java
@RequestMapping("/user")
@Controller
public class UserController {
    @RequiresPermissions("user:list")
    @ResponseBody
    @RequestMapping("/show")
    public String showUser() {
        return "这是学生信息";
    }
}
```



重复刚才的登录步骤，登录成功后，postman 输入localhost:8080/user/show



确实是没有权限。方法上是 @RequiresPermissions("user:list")，而customRealm中是 user:show、user:admin。我们可以调整下方法上的权限改为user:show。调试一下，发现成功了。

这里有一个问题：当没有权限时，系统会报错，而没有跳转到对应的没有权限的页面，也就是setUnauthorizedUrl这个方法没起作用，这个问题，下一篇会给出解决方案-。-



密码采用加密方式进行验证：

其实上面的功能已经基本满足我们的需求了，但是唯一一点美中不足的是，密码都是采用的明文方式进行比对的。那么shiro是否提供给我们一种密码加密的方式呢？答案是肯定。

shiroConfig中加入加密配置：



```java
	@Bean(name = "credentialsMatcher")
public HashedCredentialsMatcher hashedCredentialsMatcher() {
    HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
    // 散列算法:这里使用MD5算法;
    hashedCredentialsMatcher.setHashAlgorithmName("md5");
    // 散列的次数，比如散列两次，相当于 md5(md5(""));
    hashedCredentialsMatcher.setHashIterations(2);
    // storedCredentialsHexEncoded默认是true，此时用的是密码加密用的是Hex编码；false时用Base64编码
    hashedCredentialsMatcher.setStoredCredentialsHexEncoded(true);
    return hashedCredentialsMatcher;
}
```



customRealm初始化的时候耶需要做一些改变：



```java
@Bean
public CustomRealm customRealm() {
    CustomRealm customRealm = new CustomRealm();
    // 告诉realm,使用credentialsMatcher加密算法类来验证密文
    customRealm.setCredentialsMatcher(hashedCredentialsMatcher());
    customRealm.setCachingEnabled(false);
    return customRealm;
}
```



流程是这样的，用户注册的时候，程序将明文通过加密方式加密，存到数据库的是密文，登录时将密文取出来，再通过shiro将用户输入的密码进行加密对比，一样则成功，不一样则失败。

shiro提供了SimpleHash类帮助我们快速加密：



```java
public static String MD5Pwd(String username, String pwd) {
    // 加密算法MD5
    // salt盐 username + salt
    // 迭代次数
    String md5Pwd = new SimpleHash("MD5", pwd,
            ByteSource.Util.bytes(username + "salt"), 2).toHex();
    return md5Pwd;
}
```



也就是说注册的时候调用一下上面的方法得到密文之后，再存入数据库。

在CustomRealm进行身份认证的时候我们也需要作出改变：



```java
System.out.println("-------身份认证方法--------");
String userName = (String) authenticationToken.getPrincipal();
String userPwd = new String((char[]) authenticationToken.getCredentials());
//根据用户名从数据库获取密码
String password = "2415b95d3203ac901e287b76fcef640b";
if (userName == null) {
    throw new AccountException("用户名不正确");
} else if (!userPwd.equals(userPwd)) {
    throw new AccountException("密码不正确");
}
//交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配
return new SimpleAuthenticationInfo(userName, password,
        ByteSource.Util.bytes(userName + "salt"), getName());
```



这里唯一需要注意的是：你注册的加密方式和设置的加密方式还有Realm中身份认证的方式都是要一模一样的。

本文中的加密 ：MD5两次、salt=username+salt加密。



