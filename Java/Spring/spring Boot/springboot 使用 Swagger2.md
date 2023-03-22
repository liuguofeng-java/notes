## springboot 使用 Swagger2

#### 1.导包

```java
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.9.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.9.2</version>
</dependency>

//好看ui
<dependency>
    <groupId>com.github.xiaoymin</groupId>
    <artifactId>knife4j-spring-boot-starter</artifactId>
    <version>2.0.2</version>
</dependency>
```

#### 2.配置 swagger 

```java
package com.ruoyi.web.core.config;

import java.util.ArrayList;
import java.util.List;

import com.google.common.base.Predicates;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.ruoyi.common.config.RuoYiConfig;
import io.swagger.annotations.ApiOperation;
import io.swagger.models.auth.In;
import org.springframework.web.bind.annotation.RequestMethod;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.ApiSelectorBuilder;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger2的接口配置
 * 
 * @author ruoyi
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig
{
    /** 系统基础配置 */
    @Autowired
    private RuoYiConfig ruoyiConfig;

    /** 是否开启swagger */
    @Value("${swagger.enabled}")
    private boolean enabled;

    /** 设置请求的统一前缀 */
    @Value("${swagger.pathMapping}")
    private String pathMapping;

    /**
     * 创建API
     */
    @Bean
    public Docket createRestApi()
    {
        return new Docket(DocumentationType.SWAGGER_2)
                // 是否启用Swagger
                .enable(enabled)
                // 用来创建该API的基本信息，展示在文档的页面中（自定义展示的信息）
                //.apiInfo(apiInfo())
                // 设置哪些接口暴露给Swagger展示
                .select()
                // 扫描所有有注解的api，用这种方式更灵活
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                // 扫描指定包中的swagger注解
                // .apis(RequestHandlerSelectors.basePackage("com.ruoyi.project.tool.swagger"))
                // 扫描所有 .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build()
                /* 设置安全模式，swagger可以设置访问token */
                .securitySchemes(securitySchemes())
                .securityContexts(securityContexts())
                .pathMapping(pathMapping);
    }

    /**
     * 安全模式，这里指定token通过Authorization头请求头传递
     */
    private List<ApiKey> securitySchemes()
    {
        List<ApiKey> apiKeyList = new ArrayList<ApiKey>();
        apiKeyList.add(new ApiKey("Authorization", "Authorization", "header"));
        return apiKeyList;
    }

    /**
     * 安全上下文
     */
    private List<SecurityContext> securityContexts()
    {
        List<SecurityContext> securityContexts = new ArrayList<>();
        securityContexts.add(
                SecurityContext.builder()
                        .securityReferences(defaultAuth())
                        .forPaths(PathSelectors.regex("^(?!auth).*$"))
                        .build());
        return securityContexts;
    }

    /**
     * 默认的安全上引用
     */
    private List<SecurityReference> defaultAuth()
    {
        AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
        AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
        authorizationScopes[0] = authorizationScope;
        List<SecurityReference> securityReferences = new ArrayList<>();
        securityReferences.add(new SecurityReference("Authorization", authorizationScopes));
        return securityReferences;
    }




    /**
     *
     * @param groupName 组名
     * @param basePackage 扫描包路径
     * @param apiName apiName
     * @param apiDesc apiDesc
     * @param paths 正则路径匹配
     * @return
     */
    private Docket getDocket(String groupName, String basePackage, String apiName, String apiDesc, String[] paths){
        ApiSelectorBuilder apiSelectorBuilder = new Docket(DocumentationType.SWAGGER_2).apiInfo(apiInfo(apiName, apiDesc))
                .groupName(groupName)
                .securitySchemes(securitySchemes())
                .securityContexts(securityContexts())
                .select()
                .apis(RequestHandlerSelectors.basePackage(basePackage));
        if(paths==null){
            apiSelectorBuilder.paths(PathSelectors.any());
        }else{
            StringBuilder pathRegex = new StringBuilder();
            for (String path : paths){
                pathRegex.append("(").append(path).append(")|");
            }
            apiSelectorBuilder.paths(PathSelectors.regex(pathRegex.substring(0, pathRegex.length()-1)));
        }

        return apiSelectorBuilder.build()
//                .globalOperationParameters(getPubParam())
                .globalResponseMessage(RequestMethod.GET, getResponseMessage())
                .globalResponseMessage(RequestMethod.POST, getResponseMessage())
                ;
    }

    private ApiInfo apiInfo(String title, String description) {
        return new ApiInfoBuilder()
                .title(title)
                .description(description)
                .version("1.0").build();
    }

    private List<ResponseMessage> getResponseMessage(){
        List<ResponseMessage> responseMessageList = new ArrayList<>();
        responseMessageList.add(new ResponseMessageBuilder().code(200).message("请求成功!").build());
        responseMessageList.add(new ResponseMessageBuilder().code(400).message("访问方式错误!").build());
        responseMessageList.add(new ResponseMessageBuilder().code(3002).message("权限不足!").build());
        return responseMessageList;
    }


    @Bean
    public Docket repairOrderDocket() {
        return getDocket("测试", "com.ruoyi.web.controller.tool", "测试", "测试",
                new String[]{
                        "/test/user/.*",
                }
        );
    }

}
```

#### 3.文档地址

```java
http://localhost:8888/swagger-ui.html
http://localhost:8080/doc.html
```

#### 4.测试

```java
@RestController
@Api(tags = "测试")
public class TestController {
    @GetMapping("/test")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "名称", paramType = "query", required = true, dataType = "String"),
            @ApiImplicitParam(name = "age", value = "年龄", paramType = "query", required = true, dataType = "int")
    })
    @ApiOperation(value="这是个测试方法",notes="描述")
    public String index(String name,Integer age) {
        return "获取成功 "+ name + age;
    }
}
```



