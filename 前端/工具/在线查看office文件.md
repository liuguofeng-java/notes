## 在线查看office文件

![image-20230818102157749](../../assets/image-20230818102157749.png)

#### 代码:

```js
let url = 'http://localhost/xxx.xlsx'
let type = 'xlsx'
if (type == 'docx' || type == 'doc' || type == 'xlsx' || type == 'xls' || type == 'pptx' || type == 'ppt') {
  window.open('http://view.officeapps.live.com/op/view.aspx?src=' + url)
} else {
  window.open(url)
}
```

