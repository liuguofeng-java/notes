## sql优化之explain

> 使用EXPLAIN关键字可以模拟优化器执行SQL查询语句，从而知道MySQL是如何处理SQL语句。不展开讲解，大家可自行百度这块知识点。

使用格式如:

```sql
explain select * from xxx
```

`explain` 查询结果包含的字段（v5.7）

```javascript
mysql> explain select * from student;
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------+
|  1 | SIMPLE      | student | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    2 |   100.00 | NULL  |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------+
```

`id`:选择标识符

`select_type`:表示查询的类型。

`table`:输出结果集的表

`partitions`:匹配的分区

`type`:表示表的连接类型

`possible_keys`:表示查询时，可能使用的索引

`key`:表示实际使用的索引

`key_len`:索引字段的长度

`ref`:列与索引的比较

`rows`:扫描出的行数(估算的行数)

`filtered`:按表条件过滤的行百分比

`Extra`:执行情况的描述和说明