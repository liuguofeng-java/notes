## MySQL笔记

#### 1.管理MySQL的命令

```csharp
show databases //查看数据库
use  接库名 //进入数据库
show tables //查看表名
not start mysql //开启mysql
not stop mysql //关闭mysql
create database 库名 //创建数据库
drop database 库名 //删除数据库
drop table 表名 //删除表
alter table db add (name varchar(11))//添加列
alter table db modify (name int(11))//修改列类型
alter table db change name mx char(11)//修改列类型和列名
alter table db drop name//删除列
alter table db  rename to user//重命名表名
alter table db modify id int//删除auto_increment属性
```

#### 2.创建表

```csharp
CREATE TABLE `runoob_tbl`(
   `runoob_id` primary key AUTO_INCREMENT,//设置主键，自增
   `runoob_title` VARCHAR(100) NOT NULL,
   `runoob_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

#### 3.添删改查

```csharp
insert into db(id,name,age) values(1,’tom’,12)//添加
delete from db where id=1//删除
select * from db where id=1//查询
update db set name=’张三’,age=12 where id=1//修改
truncate db//删除表结构
create table db1 select * from db//复制表的结构和数据
create table db1 like db//复制表的结构
```

#### 4.约束

```csharp
not null//非空
unique//不能重复
check(sex=’男’or sex=’女’)//检查约束
default’没有’//默认约束
```

#### 5.查询

##### 1.在查询时给出WHERE子句，在WHERE子句中可以使用如下运算符及关键字：

```csharp
=、!=、<>、<、<=、>、>=；
BETWEEN…AND..；
IN(set)；
IS NULL；
AND；
OR；
NOT；
```

##### 2.模糊查询:

使用关键字like

_:匹配一个字符

%:匹配0-n个字符

```sql
如：select * from user where name like ’%a%’
```

##### 3.distinct:去除重复记录distinct

```csharp
如：select distinct name from user;
```

##### 4. ifnull:判断是否为null,如果为null,可以给默认值

```csharp
如：select ifnull(name,’没有’) from user
```

##### 3.列名添加别名 使用关键字as，as也可以省略不写。

```csharp
select name as ’姓名’ from user as u
```

##### 3.排序

就是对查询的结果进行排序

   使用关键字 order by 排序的列 [asc:升序  desc:降序],默认不写为ASC

```csharp
select * from user order by id asc
select * from user order by id desc
```

##### 4.聚合函数（统计函数）

```csharp
count()//：统计指定列不为NULL的记录行数
max()//：计算指定列的最大值
min()//：计算指定列的最小值
sum()//：计算指定列的数值和
avg()//：计算指定列的平均值计算结果为0
```

##### 5.limit是mysql的方言

查询5行记录，起始行从0开始

```csharp
select * from user limit 0,5
```

##### 6.内连接

```csharp
select * from user as u inner join class as c where u.uid = c.id
```

##### 7.外连接

1.左外连接:

```csharp
select * from user as u left join class as c on u.uid = c.id
```

2.右外连接:

```csharp
select * from user as u right join class as c on u.uid = c.id
```

3.全外连接(mysql不支持):

```csharp
select * fro, user as u full join class as c on u,uid = c.id
```

##### 8.判断数据库字段不为null也不为空

```csharp
select * from users
where name is not null and length(trim(name)) > 0
```

