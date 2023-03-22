# js 将图片转换为base64编

> 前端向后端传输图片等文件数据，经常会将图片或者文章转换成base64字符串，再由后端解密base64字符串存储，或直接存储base64字符串。



- 首先获取input 选择框对象

- 然后使用 FileReader对象转base64

- 如果转成功会调用 reader.onloadend回调函数

```javascript
<input type="file" class="custom-file-input">
```

```javascript
var file = document.querySelector('input[type=file]').files[0];
var reader = new FileReader();
reader.readAsDataURL(file);
reader.onloadend = function () {
    var base64 = reader.result;
    console.log(base64);
}
```

