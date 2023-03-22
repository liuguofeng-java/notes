## jQuery 完整 ajax示例

```javascript
$(function(){
    //请求参数
    var list = {};
    //
    $.ajax({
        //请求方式
        type : "POST",
        //请求的媒体类型
        contentType: "application/json;charset=UTF-8",
        //请求地址
        url : "http://127.0.0.1/admin/list/",
        //数据，json字符串
        data : JSON.stringify(list),
        //请求成功
        success : function(result) {
            console.log(result);
        },
        //请求失败，包含具体的错误信息
        error : function(e){
            console.log(e.status);
            console.log(e.responseText);
        }
    });
});

```



```javascript
$.ajax({
    url: "http://api.carhere.net/Ch_manage_controller/location/find",
    data: JSON.stringify(['869515000898574']),
    type: "post",
    contentType: "application/json",
    error: function () {
        console.log("失败");
    },
    success: function (data) {
        console.log(data);
    }
});
```

