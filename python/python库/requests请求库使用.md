## requests请求库使用

> *requests*是用python语言基于urllib编写的,采用的是Apache2 Licensed开源协议的HTTP库

#### 1.安装

```shell
pip install requests
```

#### 2.引入包

```python
import requests
```

#### 3.请求方式

```python
requests.get()#对应HTTP的GET

requests.head()#对应HTTP的HEAD

requests.post()#对应HTTP的POST

requests.put()#对应HTTP的PUT

requests.patch()#对应HTTP的PATCH

requests.delete()#对应HTTP的DELETE
```

#### 4.请求参数

```python
response = response = requests.post(url="http://www.baibu.com", headers={}, data={})
```

