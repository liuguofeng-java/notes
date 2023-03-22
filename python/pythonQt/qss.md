## QSS



> Qt定义界面显示样式的方法，称之为 `Qt Style Sheet` ，简称 `QSS`
>
> 它的 语法和用途 和 CSS 特别的相似

## selector 选择器

花括号前面的 部分称之为 selector（中文可以叫 选择器），用来 告诉Qt `哪些特征的元素` 是你要设定显示效果的。

比如：`QPushButton` 选择所有类型为 QPushButton （包括其子类） 的界面元素 。

QSS selector语法 几乎 和 Web CSS 的 selector语法没有什么区别，了解CSS的朋友可以轻松掌握。

### selector常见语法

| Selector            | 示例                        | 说明                                              |
| ------------------- | --------------------------- | ------------------------------------------------- |
| Universal Selector  | `*`                         | 星号匹配所有的界面元素                            |
| Type Selector       | `QPushButton`               | 选择所有 QPushButton类型 （包括其子类）           |
| Class Selector      | `.QPushButton`              | 选择所有 QPushButton类型 ，但是不包括其子类       |
| ID Selector         | `QPushButton#okButton`      | 选择所有 `对象名为 okButton` 的QPushButton类型    |
| Property Selector   | `QPushButton[flat="false"]` | 选择所有 flat 属性值为 false 的 QPushButton类型。 |
| Descendant Selector | `QDialog QPushButton`       | 选择所有 QDialog `内部` QPushButton类型           |
| Child Selector      | `QDialog > QPushButton`     | 选择所有 QDialog `直接子节点` QPushButton类型     |

### Pseudo-States 伪状态

我们可以这样指定当鼠标移动到一个元素上方的时候，元素的显示样式

```css
QPushButton:hover { color: red }
```

再比如，指定一个元素是disable状态的显示样式

```css
QPushButton:disabled { color: red }
```

再比如，指定一个元素是鼠标悬浮，并且处于勾选（checked）状态的显示样式

```css
QCheckBox:hover:checked { color: white }
```

### 优先级

如果一个元素的显示样式被多层指定了， `越靠近元素本身` 的选择指定，优先级越高

## 样式属性

QSS的样式属性和网页CSS非常相似。

QSS支持的具体样式，可以[点击这里，查看Qt官方文档](https://doc.qt.io/qt-5/stylesheet-reference.html#list-of-properties)

我们这里介绍一些常见的样式属性

### 背景

可以指定某些元素的背景色，像这样

```css
QTextEdit { background-color: yellow }
```

颜色可以使用红绿蓝数字，像这样

```css
QTextEdit { background-color: #e7d8d8 }
```



也可以像这样指定背景图片

```css
QTextEdit {
    background-image: url(gg03.png);
}
```

### 边框

可以像这样指定边框 `border:1px solid #1d649c;`

其中

`1px` 是边框宽度

`solid` 是边框线为实线， 也可以是 `dashed`(虚线) 和 `dotted`（点）

比如

```css
*[myclass=bar2btn]:hover{
	border:1px solid #1d649c;
}
```



边框可以指定为无边框 `border:none`

### 字体、大小、颜色

可以这样指定元素的 文字字体、大小、颜色

```css
*{	
	font-family:微软雅黑;
	font-size:15px;
	color: #1d649c;
}
```

### 宽度、高度

可以这样指定元素的 宽度、高度

```css
QPushButton {	
	width:50px;
	height:20px;
}
```

### margin、padding

可以这样指定元素的 元素的 margin

```css
QTextEdit {
	margin:10px 11px 12px 13px
}
```

分别指定了元素的上右下左margin。

也可以使用 margin-top, margin-right, margin-bottom, margin-left 单独指定 元素的上右下左margin

比如

```css
QTextEdit {
	margin:10px 50px;
	padding:10px 50px;
}
```