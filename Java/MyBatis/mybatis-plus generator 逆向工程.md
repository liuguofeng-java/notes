## mybatis-plus generator 逆向工程

#### 1.maven坐标

```java
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.example</groupId>
    <artifactId>mybatisplus-dome</artifactId>
    <version>1.0-SNAPSHOT</version>
    <modules>
        <module>web</module>
        <module>common</module>
    </modules>
    <packaging>pom</packaging>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.2.1.RELEASE</version>
        <relativePath/> <!-- 继承SpringBoot父工程 -->
    </parent>


    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
        <java.version>1.8</java.version>
        <mybatis.version>3.4.1</mybatis.version>
        <mysql-version>8.0.20</mysql-version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency><!--集成web开发环境-->

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope><!--springboot测试工具包-->
        </dependency>

        <!--mybatis-plus-->
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>${mybatis.version}</version>
        </dependency>


        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-generator</artifactId>
            <version>${mybatis.version}</version>
        </dependency>
        
        <!-- 模板引擎 -->
        <dependency>
            <groupId>org.apache.velocity</groupId>
            <artifactId>velocity-engine-core</artifactId>
            <version>2.0</version>
        </dependency>

        <!-- mysql 驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>${mysql-version}</version>
        </dependency>


        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.16.18</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

</project>
```

#### 2.生成工具类

```java
package com.mybatisplus.generator;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.BeetlTemplateEngine;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.mybatisplus.WebApp;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@SpringBootTest(classes = WebApp.class)//表示使用用springboot,classes:指定启动类
@RunWith(SpringJUnit4ClassRunner.class)//让测试运行于Spring测试环境
public class MybatisGenerator {


    @Test
    public void generatorHelper(){
        //1、全局配置
        GlobalConfig globalConfig = new GlobalConfig();
        globalConfig
                .setActiveRecord(false)
                .setEnableCache(false)
                //这个位置的位置是自己项目的路径到java文件夹下
                .setOutputDir("D:\\project\\IdeaProjects\\web\\src\\main\\java")
                .setFileOverride(true)//覆盖生成的文件
                .setIdType(IdType.INPUT)
                .setServiceName("%sService")
                .setBaseResultMap(true)
                .setBaseColumnList(true)
                //这个参数是生成人(如：张三、李四)
                .setAuthor("xxx")
                .setOpen(false);
        //2、数据源配置
        DataSourceConfig dataSourceConfig = new DataSourceConfig();
        /*//这套配置是Oracle的配置
        dataSourceConfig.setUrl("jdbc:oracle:thin:@ip:端口:库名")
                .setDriverName("oracle.jdbc.driver.OracleDriver")
                //数据库登录名
                .setUsername("xxx")
                //数据库密码
                .setPassword("xxx")
                .setDbType(DbType.ORACLE);*/

        //这套配置是MySql的配置
        //这个是做的SSH的连接（useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8&useSSL=false）
        dataSourceConfig.setUrl("jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8&useSSL=false")
                .setDriverName("com.mysql.cj.jdbc.Driver")
                //数据库登录名
                .setUsername("root")
                //数据库密码
                .setPassword("lbf123")
                .setDbType(DbType.MYSQL);
        //3、策略配置
        StrategyConfig strategyConfig = new StrategyConfig();
        strategyConfig
                .setNaming(NamingStrategy.underline_to_camel)
                .setColumnNaming(NamingStrategy.underline_to_camel)
                .setNaming(NamingStrategy.underline_to_camel)
//                TODO
                //需要导入的表的名称
                .setInclude("user")
                //需要导入表删除前缀（如：xxx_xx,删除完前缀是xx,只剩下表名）
                .setTablePrefix("");

        //4、包名策略配置
        PackageConfig packageConfig = new PackageConfig();
        //这个需要改成自己项目的位置
        packageConfig.setParent("com.mybatisplus")
                //Dao层的文件
                .setMapper("dao")
                //service层的文件
                .setService("service")
                //controller层的文件
                .setController("controller")
                //实体类的文件
                .setEntity("entity")
                //xml的文件
                .setXml("dao");

        //5、整合配置
        AutoGenerator autoGenerator = new AutoGenerator();
        autoGenerator.setGlobalConfig(globalConfig)
                .setDataSource(dataSourceConfig)
                .setStrategy(strategyConfig)
                .setPackageInfo(packageConfig);
        //6、执行
        autoGenerator.execute();
    }

}
```

