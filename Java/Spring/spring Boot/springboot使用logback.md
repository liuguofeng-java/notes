## springboot使用logback

> Logback是一个可靠、通用且快速的Java日志框架，作为Log4j的继承者，由Log4j创始人设计。它由三个模块组成：
>
> logback-core：基础模块
> logback-classic：实现了SLF4J API
> logback-access：与Servlet容器集成提供HTTP访问日志功能

##### 1.Spring Boot默认日志框架
>  Spring Boot默认使用Logback作为日志框架，当你使用spring-boot-starter或spring-boot-starter-web时，已经自动引入了Logback依赖。

```xml
<!-- 在Spring Boot项目中，你不需要显式添加Logback依赖 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>
```

##### 2.使用示例

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
public class DemoController {
    // 获取Logger实例，通常以当前类作为参数
    private static final Logger logger = LoggerFactory.getLogger(DemoController.class);
    
    @GetMapping("/demo")
    public String demo() {
        logger.trace("This is a TRACE level message");
        logger.debug("This is a DEBUG level message");
        logger.info("This is an INFO level message");
        logger.warn("This is a WARN level message");
        logger.error("This is an ERROR level message");
        
        return "Check your console or log file!";
    }
}
```

##### 3.logback日志级别（从低到高）

- **TRACE**：最详细的日志级别，通常用于追踪程序执行流程

- **DEBUG**：用于开发和调试阶段的详细信息

- **INFO**：确认程序按预期运行的关键信息

- **WARN**：潜在问题或不影响功能的异常情况

- **ERROR**：导致功能失效的错误事件

- **OFF**：关闭所有日志输出

##### 4.logback配置文件加载顺序

> Spring Boot会按以下顺序查找Logback配置文件：

1. `logback-spring.xml` (推荐使用)
2. `logback.xml`
3. 如果以上都不存在，使用默认配置

##### 5.生产环境`logback-spring.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration debug="false" scan="false">
	<springProperty scop="context" name="spring.application.name" source="spring.application.name" defaultValue=""/>
	<property name="log.path" value="./logs/${spring.application.name}"/>
	<property name="FILE_LOG_PATTERN" value=":%d{yyyy-MM-dd HH:mm:ss.SSS} %5p %t %c{1}: %m%n"/>

	<!-- Console log output -->
	<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
		<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
			<pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %highlight(%-5level) %logger{50}:%L - %msg%n</pattern>
		</encoder>
	</appender>


	<!-- Log file debug output -->
	<appender name="debug" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>${log.path}/debug.log</file>
		<rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
			<fileNamePattern>${log.path}/%d{yyyy-MM, aux}/debug.%d{yyyy-MM-dd}.%i.log.gz</fileNamePattern>
			<maxFileSize>100MB</maxFileSize>
			<maxHistory>30</maxHistory>
		</rollingPolicy>
		<encoder>
			<pattern>${FILE_LOG_PATTERN}</pattern>
		</encoder>
	</appender>

	<!-- Log file error output -->
	<appender name="error" class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>${log.path}/error.log</file>
		<rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
			<fileNamePattern>${log.path}/%d{yyyy-MM}/error.%d{yyyy-MM-dd}.%i.log.gz</fileNamePattern>
			<maxFileSize>50MB</maxFileSize>
			<maxHistory>30</maxHistory>
		</rollingPolicy>
		<encoder>
			<pattern>${FILE_LOG_PATTERN}</pattern>
		</encoder>
		<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
			<level>ERROR</level>
		</filter>
	</appender>

	<!-- Level: FATAL 0  ERROR 3  WARN 4  INFO 6  DEBUG 7 -->
	<root level="INFO">
		<appender-ref ref="console"/>
		<appender-ref ref="debug"/>
		<appender-ref ref="error"/>
	</root>
</configuration>
```

##### 6.打印mybatis日志

```yml
logging:
  level:
    xxx.xxx.xxx.xxx.mapper: debug
```



