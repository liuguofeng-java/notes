## IDEA下的Mybatis-generator逆向工程

##### 1.在pom.xml加Mybatis-generator插件

```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.mybatis.generator</groupId>
      <artifactId>mybatis-generator-maven-plugin</artifactId>
      <version>1.3.2</version>
      <configuration>
      <!--配置文件的位置-->
      <configurationFile>src/main/resources/generator.xml</configurationFile>
      <verbose>true</verbose>
      <overwrite>true</overwrite>
    </configuration>
      <executions>
      <execution>
      <id>Generate MyBatis Artifacts</id>
      <goals>
        <goal>generate</goal>
      </goals>
      </execution>
      </executions>
      <dependencies>
        <dependency>
          <groupId>org.mybatis.generator</groupId>
          <artifactId>mybatis-generator-core</artifactId>
          <version>1.3.2</version>
        </dependency>
      </dependencies>
    </plugin>
  </plugins>
</build>
```

##### 2.generator.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <!--mysql 连接数据库jar 这里选择自己本地位置-->
    <classPathEntry location="D:\repository\mysql\mysql-connector-java\5.1.38\mysql-connector-java-5.1.38.jar" />
    <context id="testTables" targetRuntime="MyBatis3">
        <commentGenerator>
            <!-- 是否去除自动生成的注释 true：是 ： false:否 -->
            <property name="suppressAllComments" value="true" />
        </commentGenerator>
        <!--数据库连接的信息：驱动类、连接地址、用户名、密码 -->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/peis" userId="root"
                        password="KunYujk1!">
        </jdbcConnection>
        <!-- 默认false，把JDBC DECIMAL 和 NUMERIC 类型解析为 Integer，为 true时把JDBC DECIMAL 和
                NUMERIC 类型解析为java.math.BigDecimal -->
        <javaTypeResolver>
        <property name="forceBigDecimals" value="false" />
        </javaTypeResolver>        <!-- targetProject:生成PO类的位置 -->
        <javaModelGenerator targetPackage="com.dome1.pojo"
                            targetProject="src/main/java">
            <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false" />
            <!-- 从数据库返回的值被清理前后的空格 -->
            <property name="trimStrings" value="true" />
        </javaModelGenerator>
        <!-- targetProject:mapper映射文件生成的位置
                如果maven工程只是单独的一个工程，targetProject="src/main/java"
                若果maven工程是分模块的工程，targetProject="所属模块的名称"，例如：
                        targetProject="ecps-manager-mapper"，下同-->
        <sqlMapGenerator targetPackage="com.dome1.mapper"
                         targetProject="src/main/java">
        <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false" />
    </sqlMapGenerator>        <!-- targetPackage：mapper接口生成的位置 -->
        <javaClientGenerator type="XMLMAPPER"
                             targetPackage="com.dome1.mapper"
                             targetProject="src/main/java">
            <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false" />
        </javaClientGenerator>
        <!-- 指定数据库表 -->
        <table schema="" tableName="peis_userinfo"></table>
    </context>
</generatorConfiguration>
```

