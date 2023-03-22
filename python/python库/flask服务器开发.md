## flask服务器开发

> *Flask*是一个使用 Python 编写的轻量级 Web 应用框架

#### 1.安装

```shell
pip install flask
```

#### 2.引入包

```python
from flask import Flask,jsonify,request
app = Flask(__name__)
```

#### 3.编写入口文件

```python
if __name__ == '__main__':
    app.config['JSON_AS_ASCII'] = False
    app.run(host="0.0.0.0", port=8080)
```

#### 4.编写hello请求

```py
@app.route("/hello")
def hello():
    #request参数
    startDate = request.values.get("startDate")
    endDate = request.values.get("endDate")

    #返回
    data={}
    data['success'] = 'ok'
    data['data'] = {}
    return jsonify(data)
```

#### 5.完整文件

```python
#!/usr/bin/env python
# encoding: utf-8

"""
@version: v1.0
@author: liuguofeng
@file: http_server.py
@time: 2022/9/7 18:13
@description:http服务
"""

import resuest_model
from flask import Flask,jsonify,request
import time
from datetime import datetime, timedelta

app = Flask(__name__)


@app.route("/getData")
def getData():
    #request参数
    startDate = request.values.get("startDate")
    endDate = request.values.get("endDate")

    #返回
    data={}
    data['success'] = 'ok'
    data['data'] = {}
    return jsonify(data)


if __name__ == '__main__':
    app.config['JSON_AS_ASCII'] = False
    app.run(host="0.0.0.0", port=8080)
```

