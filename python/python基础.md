## Python基础

#### 1.print()函数概述

```py
#数值类型可以直接输出
print(1)

#字符串类型可以直接输出
print("Hello World")
 
#可以一次输出多个对象，对象之间用逗号分隔
a="Hello"
b=" World"
print(a, b)
 
#如果直接输出字符串，而不是用对象表示的话，可以不使用逗号
print("Duan""Yixuan")
print("Duan","Yixuan")

# 设置间隔符
print("www", "baidu", "com", sep=".") 

#把字符输出到文件内
f = open("C:/Users/liuguofeng/Desktop/a.log","a+")
print("你好",file=f)
f.close();
```

#### 2.变量

```py
name = "张三"
print(id(name))
print(type(name))
print(name)
```

```py
#结果
2188329885616 #相当于内存地址值
<class 'str'> #变量类型
张三           #值
```

#### 3.数据类型

- 整数类型         int
- 浮点型             float
- 布尔类型          bool
- 字符串              str

1. 浮点数计算出现小数不确定问题

   ```py
   from decimal import Decimal
   print(2.2+1.2)
   print(Decimal('2.2')+Decimal('1.2'))
   
   #结果
   3.4000000000000004
   3.4
   ```

2. 字符串引号和三引号
   - 区别：单引号不能换行，三引号可以换号

#### 4.int float str 转换

- 使用`int()`将其他类型转换成`int`类型
- 使用`float ()`将其他类型转换成`float`类型 
- 使用`str()`将其他类型转换成`str`类型

#### 5.input()函数cmd输入

```py
str = input()
print(str)
```

#### 6.is 、is not

- `is`判断两个地址值是否相等，是则`True`否则`False`
- `is not` 正好和`is`的结果相反 

#### 7.in 、not in

- `in`在一个字符串中是否包含另一个字符，是则`True`否则`False`

- `not in`正好和`is`的结果相反

  ```py
  #如：
  s1 = "www.baid.com"
  print('a' in s1) #True
  print('zzz' in s1) #False
  print('zzz' not in s1) #True
  ```

#### 8.内置函数range()

参数说明：

- start: 计数从 start 开始。默认是从 0 开始。例如range（5）等价于range（0， 5）;
- stop: 计数到 stop 结束，**但不包括 stop**。例如：range（0， 5） 是[0, 1, 2, 3, 4]没有5
- step：步长，默认为1。例如：range（0， 5） 等价于 range(0, 5, 1)