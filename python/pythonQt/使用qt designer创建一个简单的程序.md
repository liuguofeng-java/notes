## 使用qt designer创建一个简单的程序

#### 1.打开qt designer设计师工具

> windows 系统一般在python安装目录下的`Scripts/pyside2-designer.exe`

#### 2.加载ui文件展示简单demo

```python
from PySide2.QtWidgets import QApplication, QMessageBox, QTextEdit
from PySide2.QtUiTools import QUiLoader

#按钮点时
def butClick():
    #获取input框的值
    text = window.textEdit.toPlainText()
    #内容弹窗
    QMessageBox.about(window,"提示",text)

#初始化、程序入口参数的处理，用户事件（对界面的点击、输入、拖拽）分发给各个对应的控件
app = QApplication([])

# 从文件中加载UI定义
# 从 UI 定义中动态 创建一个相应的窗口对象
# 注意：里面的控件对象也成为窗口对象的属性了
window = QUiLoader().load('main.ui')
#按钮点击时
window.button.clicked.connect(butClick)

#弹窗
window.show()
app.exec_()
```

