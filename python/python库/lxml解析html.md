## lxml解析html

> lxml是XML和HTML的解析器，其主要功能是解析和提取XML和HTML中的数据

#### 1.安装

```shell
pip install lxml
```

#### 2.引入包

```python
from lxml import etree
```

#### 3.将文本转换lxml对象

```python
html_element = etree.HTML(text)
```

#### 4.解析html

```python
"""
//　　从任意节点中选取
/　　 从当前节点中选取
..　　当前节点的父节点
.　　 当前节点
"""
html_element.xpath('//a')    # 所有a标签(子孙后代)

html_element.xpath('//a[@id]')    # 所有a标签，并且含有id属性
html_element.xpath('//a[@id="i1"]')        # 所有a标签，并且属性id='i1'
html_element.xpath('//a[@href="link.html"][@id="i1"]')    # 所有a标签，属性href="link.html" 而且 id="i1"

html_element.xpath('//a[contains(@href, "link")]')    # 所有a标签，属性href的值包含"link"
html_element.xpath('//a[starts-with(@href, "link")]')    # 所有a标签，属性href的值以"link"开头
html_element.xpath('//a[re:test(@id, "i\d+")]')        # 所有a标签 属性id的值 符合正则表达式"i\d+"的规则

html_element.xpath('//a[re:test(@id, "i\d+")]/text()')        # 所有a标签，取text的值
html_element.xpath('//a[re:test(@id, "i\d+")]/@href')        # 所有a标签，取href的属性值
```

