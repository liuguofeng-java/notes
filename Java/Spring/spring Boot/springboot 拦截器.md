## springboot 拦截器

```java
package com.workorder.interceptor;

import com.workorder.entity.WosUser;
import com.workorder.utils.TokenUtils;
import com.workorder.utils.redis.RedisUtil;
import com.workorder.utils.result.JsonResult;
import com.workorder.utils.result.ResultCode;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminInterceptor implements HandlerInterceptor {

    @Autowired
    private RedisUtil redisUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Type", "application/json");
        response.setContentType("application/json;charset=UTF-8");

        //获取token
        String token = request.getHeader("token");
        if(StringUtils.isEmpty(token)){
            jsonResult(response);
            return false;
        }

        WosUser wosUser = (WosUser) redisUtil.get(token);
        if(wosUser == null){
            jsonResult(response);
            return false;
        }

        //验证token是否过期
        boolean verify = TokenUtils.verify(token);
        if(!verify){
            jsonResult(response);
            return false;
        }
        return true;
    }

    private void jsonResult(HttpServletResponse response) throws IOException {
        try (PrintWriter writer = response.getWriter()) {
            JsonResult res = ResultCode.error(ResultCode.NOT_LOGIN_CODE,"请登录");
            writer.write(JSONObject.fromObject(res).toString());
            writer.flush();
        }
    }

}
```



```java
@Configuration
public class WebConfigurer implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 拦截所有请求，通过判断是否有
        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/login/tokenLogin","/login/getVerifyCode");
    }

    @Bean
    public AdminInterceptor LoginInterceptor() {
        return new AdminInterceptor();
    }


}
```

