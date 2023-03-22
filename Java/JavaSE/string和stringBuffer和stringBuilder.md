## string和stringBuffer和stringBuilder

#### 1.string和stringBuffer和stringBuilder区别

1. 可变与不可变：string 使用final 修饰的char[]所以不可变，stringBuffer和stringBuilder使用char[]保存所以可变

2. 线程是否安全：string使用 final修饰所以安全，stringBuffer使用synchronize修饰所以安全，stringBuilder即没有使用同步锁也没有使用final修饰所以不安全

#### 2.string常用方法

charAt(int) 返回char指定的索引的值

compareTo(String) 比较两个值的大小

concat(String) 在尾部拼接字符串

 (String) 是否包含指定的字符串

indexOf(int) 返回第一次出现字符串内的索引

isEmpty() 字符串的长度是否为0

lastIndexOf(String) 返回最后一次出现字符串

length() 返回字符串长度

replace(String,String) 替换字符串

split(string regex) 分割字符串，返回stringp[]

substring(int,int) 返回一个新的字符串，从开始位置到结束位置

toCharArray() 将字符串转为char[]

toLowerCase() 将字符串转小写

toUpperCase() 将字符串转大写

trim() 去掉字符串前后空格

#### 3.stringBuffer和stringBuilder 常用方法

append(String) 把字符串添加到新的序列中

delete(int,int) 删除序列的字符串

insert(int,String) 插入新的字符串