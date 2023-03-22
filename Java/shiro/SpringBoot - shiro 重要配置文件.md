## SpringBoot - shiro 重要配置文件

#### 1.授权和身份验证

```java
import com.simple.entity.SysMenu;
import com.simple.entity.SysUser;
import com.simple.service.SysUserService;
import com.simple.service.impl.SysMenuServiceImpl;
import com.simple.service.impl.SysUserServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 描述：shiro验证权限和登录
 *
 * @author liuguofeng
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private SysUserServiceImpl sysUserServiceImpl;
    @Autowired
    private SysMenuServiceImpl sysMenuServiceImpl;

    /**
     * 验证权限配置
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        //获取权限给shiro
        SysUser model = sysUserServiceImpl.getUserInfoByName(username);
        //找出这个人的权限
        List<SysMenu> menus = sysMenuServiceImpl.getPermission(model.getUserId());
        Set<String> strPermissions = new HashSet<>();
        for(SysMenu menu : menus){
            String permission = menu.getPermission();
            if(StringUtils.isEmpty(permission)) continue;
            strPermissions.add(permission);
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(strPermissions);
        return info;
    }

    /**
     * 身份认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String userName = (String) authenticationToken.getPrincipal();
        //String userPwd = new String((char[]) authenticationToken.getCredentials());
        SysUser model = sysUserServiceImpl.getUserInfoByName(userName);
        if (model == null) {
            throw new AccountException("用户名不正确");
        }
        return new SimpleAuthenticationInfo(userName, model.getPassword(),
                ByteSource.Util.bytes(userName + model.getSalt()), getName());
    }
}
```

#### 2. shiro配置文件

```java
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 描述：shiro配置类
 *
 * @author liuguofeng
 */
@Configuration
public class ShiroConfig {

    @Bean(name = "shiroFilter")
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        shiroFilterFactoryBean.setLoginUrl("/login/index");
        //shiroFilterFactoryBean.setUnauthorizedUrl("/notPermission");//暂时没有，使用异常拦截器
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();

        //主要这行代码必须放在所有权限设置的最后，不然会导致所有 url 都被拦截 剩余的都需要认证
        filterChainDefinitionMap.put("/login/**", "anon");
        filterChainDefinitionMap.put("/app/**", "anon");
        filterChainDefinitionMap.put("/js/**", "anon");
        filterChainDefinitionMap.put("/images/**", "anon");
        filterChainDefinitionMap.put("/lib/**", "anon");
        filterChainDefinitionMap.put("/css/**", "anon");

        // authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问
        //filterChainDefinitionMap.put("/**", "authc");

        //使用记住我的功能是要把 authc 改为 user
        filterChainDefinitionMap.put("/**", "user");

        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;

    }

    @Bean
    public SecurityManager securityManager() {
        DefaultWebSecurityManager defaultSecurityManager = new DefaultWebSecurityManager();
        defaultSecurityManager.setRealm(customRealm());
        defaultSecurityManager.setRememberMeManager(rememberMeManager());//记住我
        return defaultSecurityManager;
    }

    @Bean
    public UserRealm customRealm() {

        UserRealm customRealm = new UserRealm();
        // 告诉realm,使用credentialsMatcher加密算法类来验证密文
        customRealm.setCredentialsMatcher(hashedCredentialsMatcher());
        customRealm.setCachingEnabled(false);
        return customRealm;
    }


    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    /**
     * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions),需借助SpringAOP扫描使用Shiro注解的类,并在必要时进行安全逻辑验证
     * 配置以下两个bean(DefaultAdvisorAutoProxyCreator(可选)和AuthorizationAttributeSourceAdvisor)即可实现此功能
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

    /**
     * shiro提供md5加密
     * @return
     */
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

    /**
     * cookie管理对象
     * @return
     */
    @Bean
    public CookieRememberMeManager rememberMeManager(){
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(rememberMeCookie());
        //rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
        cookieRememberMeManager.setCipherKey(Base64.decode("4AvVhmFLUs0KTA3Kprsdag=="));
        return cookieRememberMeManager;
    }

    @Bean
    public SimpleCookie rememberMeCookie(){
        //这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
        SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
        //防止xss读取cookie
        simpleCookie.setHttpOnly(true);
        simpleCookie.setPath("/");
        //记住我cookie生效时间 ,单位秒
        simpleCookie.setMaxAge(60*60*24*7);
        return simpleCookie;
    }
}
```

#### 3. 登录文件

```java
// 从SecurityUtils里边创建一个 subject
Subject subject = SecurityUtils.getSubject();
// 在认证提交前准备 token（令牌）
UsernamePasswordToken token = new UsernamePasswordToken(username, password,remembered);
// 执行认证登陆
try {
    subject.login(token);
} catch (UnknownAccountException uae) {
    return Result.error("未知账户");
} catch (IncorrectCredentialsException ice) {
    return Result.error("密码不正确");
} catch (LockedAccountException lae) {
    return Result.error("账户已锁定");
} catch (ExcessiveAttemptsException eae) {
    return Result.error("用户名或密码错误次数过多");
} catch (AuthenticationException ae) {
    return Result.error("用户名或密码不正确！");
}
if (subject.isAuthenticated()) {
    return Result.ok("登录成功");
} else {
    token.clear();
    return Result.error("登录失败");
}
```

