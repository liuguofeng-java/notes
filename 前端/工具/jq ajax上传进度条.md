## jq ajax上传进度条

```javascript
var obj = objt[0].files[0];
if (obj == undefined) {
    layer.msg("请选择上传图片!", { icon: 2 });
    return;
}
var formData = new FormData();
formData.append("img", obj);
$.ajax({
    type: "post",
    url: "/Home/UploadImage",
    data: formData,
    processData: false, // 使数据不做处理
    contentType: false, // 不要设置Content-Type请求头
    xhr: function () { //获取ajaxSettings中的xhr对象，为它的upload属性绑定progress事件的处理函数
        myXhr = $.ajaxSettings.xhr();
        if (myXhr.upload) { //检查upload属性是否存在
            //绑定progress事件的回调函数
            myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
        }
        return myXhr; //xhr对象返回给jQuery使用
    },
    success: function (data) {
        console.log(data);
        if (data.msg != "") {
            $("#v").html("<video <video width=750 controls=''><source src='/files/" + data.filepath +"' type='video/mp4'></video>");
        } else {
            alert(data.msg);
        }
    }
})

function progressHandlingFunction(e) {
var curr = e.loaded;
var total = e.total;
process = curr / total * 100;
process = process.toFixed(2);
var str = '<div class="main">\
    <div class="progress">\
        <div class="progress-bar progress-bar-striped active" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: '+ process+'%" role="progressbar">\
        </div>\
    </div>\
    完成进度:<span id="progressNum">'+ process+'% </span>\
</div>';
$("#process").html('').html(str);
if (process >= 100) {
    setTimeout(function () { $("#process").html(''); }, 2300)
}
}
```

