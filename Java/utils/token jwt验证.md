## token jwt验证

```java
<!--jwt验证-->
<dependency>
    <groupId>com.auth0</groupId>
    <artifactId>java-jwt</artifactId>
    <version>3.8.2</version>
</dependency>
```



```java
package com.workorder.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import java.util.*;

/**
 * @desc   使用token验证用户是否登录
 * @author
 **/
public class TokenUtils {
    //设置过期时间
    private static final long EXPIRE_DATE=60000 * 60 * 24;//一天
    //token秘钥
    private static final String TOKEN_SECRET = "ZCfasfhuaUUHufguGuwu2020BQWE";

    public static String token (String username,String password,String ip){

        String token = "";
        try {
            //过期时间
            Date date = new Date(new Date().getTime() + EXPIRE_DATE);
            //秘钥及加密算法
            Algorithm algorithm = Algorithm.HMAC256(TOKEN_SECRET);
            //设置头部信息
            Map<String,Object> header = new HashMap<>();
            header.put("typ","JWT");
            header.put("alg","HS256");
            //携带username，password信息，生成签名
            token = JWT.create()
                    .withHeader(header)
                    .withClaim("username",username)
                    .withClaim("password",password).withExpiresAt(date)
                    .withClaim("ip",ip)
                    .sign(algorithm);
        }catch (Exception e){
            e.printStackTrace();
            return  null;
        }
        return token;
    }

    /**
     * @desc   验证token，通过返回true
     * @params [token]需要校验的串
     **/
    public static boolean verify(String token){
        try {
            Algorithm algorithm = Algorithm.HMAC256(TOKEN_SECRET);
            JWTVerifier verifier = JWT.require(algorithm).build();
            DecodedJWT jwt = verifier.verify(token);
            System.out.println(jwt.toString());
            return true;
        }catch (Exception e){
            return  false;
        }
    }
    public static void main(String[] args) {
        String username ="zhangsan";
        String password = "123";
        String token = token(username,password,"192.168.10");
        System.out.println(token);
        boolean b = verify("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IjEyMyIsImlwIjoiMTkyLjE2OC4xMCIsImV4cCI6MTYxMTU3NzYxNywidXNlcm5hbWUiOiJ6aGFuZ3NhbiJ9.VWAQ3RfqFqPVAB4UHTOyNvs5w0M0fo7tj8-Nz6KpfDk");
        System.out.println(b);
    }
}
```

