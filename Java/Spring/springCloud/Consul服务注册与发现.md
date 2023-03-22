

## Consul服务注册与发现

一、Consul简介

Consul官网 

1、Consul是什么

Consul是一套开源的分布式服务发现和配置管理系统，有HashiCorp公司使用GO语言开发。



提供了微服务系统中的服务治理，配置中心，控制总线等功能，这些功能中的每一个都可以根据需要单独使用，也可以一起使用以架构全方位的服务网格，总之Consul提供了一种完整的服务网个解决方案。



它具有很多优点，包括：基于raft协议，比较简介；支持健康检查，同时支持Http和DNS协议 支持跨数据中心的WAN集群提供图形界面 跨平台，支持Linux，mac windows



2、Consul能干吗

- 服务发现

- 健康检测

- KV存储

- 多数据中心

- 可视化WEB界面



3、下载

下载地址 

学习地址 



二、安装并运行Consul

下载windows后，解压后就一个文件 consul.exe 文件



在该目录下打开 cmd  输入   consul --version 就可以查看consul的版本

![](../../../assets/1659272790776.png)

Consul 路径： D:\Program Files\Consul

启动consul：consul agent -dev

访问控制界面：http://localhost:8500





1、服务提供者

创建 cloud-providerconsul-payment8006 模块

1.1 添加依赖

```java
<dependencies>
  <dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-consul-discovery</artifactId>
  </dependency>

  <dependency>
    <groupId>com.yixuexi.springcloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>${project.version}</version>
  </dependency>


  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
  </dependency>

  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
  </dependency>
</dependencies>
```

1.2 写yaml

```java
server:
  port: 8006
spring:
  application:
    name: cloud-payment-service
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
```

1.3 主启动类

```java
@EnableDiscoveryClient
@SpringBootApplication
public class ConsulMain8006 {
    public static void main(String[] args) {
        SpringApplication.run(ConsulMain8006.class,args);
    }
}
```

1.4 业务类

```java
@RestController
public class PaymentController {
    @Value("${server.port}")
    private String port;

    @RequestMapping("/get/Payment/{id}")
    public CommonResult get(@PathVariable Long id){

        return new CommonResult(200,"",port);
    }
}
```

1.4 测试

![](../../../assets/1659272790791.png)

---

2、服务消费者

创建 cloud-consumerconsul-order80 模块

2.1 添加依赖

```java
<dependencies>
  <dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-consul-discovery</artifactId>
  </dependency>

  <dependency>
    <groupId>com.yixuexi.springcloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>1.0-SNAPSHOT</version>
  </dependency>


  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
  </dependency>

  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
  </dependency>

  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
  </dependency>
</dependencies>
```

2.2 yaml

```java
server:
  port: 80


spring:
  application:
    name: consul-consumer-order
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
```

2.3 主启动类

```java
@SpringBootApplication
@EnableDiscoveryClient
public class OrderConsulMain80 {
    public static void main(String[] args) {
        SpringApplication.run(OrderConsulMain80.class,args);
    }
}
```

2.4 配置类

添加 RestTemplate 组件

```java
@Configuration
public class MyConfig {

    @LoadBalanced
    @Bean
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }
}
```

2.5 业务类

远程调用的业务类

```java
@RestController
public class PaymentController {

    @Autowired
    private RestTemplate restTemplate;

    @RequestMapping("/consumer/get/payment/{id}")
    public CommonResult<Payment> get(@PathVariable("id") Long id){
        String url = "http://cloud-payment-service/get/payment/" + id;

        return restTemplate.getForObject(url,CommonResult.class);
    }

}
```

2.6 测试

![](../../../assets/1659272790807.png)

