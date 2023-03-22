## js 网络图片转base64的方式(两种)



方法一，Blob和FileReader 对象

实现原理：

使用xhr请求图片,并设置返回的文件类型为Blob对象[xhr.responseType = "blob"]

使用FileReader 对象接收blob。

```csharp
getBase64("https://fastmarket.oss-cn-shenzhen.aliyuncs.com/oss/static/other/1/images/baseMap_index.jpg")//链接是你的网络图片

function getBase64(imgUrl) {
  window.URL = window.URL || window.webkitURL;
  var xhr = new XMLHttpRequest();
  xhr.open("get", imgUrl, true);
  // 至关重要
  xhr.responseType = "blob";
  xhr.onload = function () {
    if (this.status == 200) {
      //得到一个blob对象
      var blob = this.response;
      console.log("blob", blob)
      // 至关重要
      let oFileReader = new FileReader();
      oFileReader.onloadend = function (e) {
        // 此处拿到的已经是 base64的图片了
        let base64 = e.target.result;
        console.log("方式一》》》》》》》》》", base64)
      };
      oFileReader.readAsDataURL(blob);
      //====为了在页面显示图片，可以删除====
      var img = document.createElement("img");
      img.onload = function (e) {
        window.URL.revokeObjectURL(img.src); // 清除释放
      };
      let src = window.URL.createObjectURL(blob);
      img.src = src
      //document.getElementById("container1").appendChild(img);
      //====为了在页面显示图片，可以删除====

    }
  }
  xhr.send();
}
```

方法二：canvas.toDataURL()方法

实现原理：

使用canvas.toDataURL()方法

需要解决图片跨域问题 image.crossOrigin = '';

使用了Jquery库的$.Deferred()方法

```csharp
let imgSrc = "https://fastmarket.oss-cn-shenzhen.aliyuncs.com/oss/static/other/1/images/baseMap_index.jpg";

//width、height调用时传入具体像素值，控制大小 ,不传则默认图像大小
function getBase64Image(img, width, height) {
  var canvas = document.createElement("canvas");
  canvas.width = width ? width : img.width;
  canvas.height = height ? height : img.height;
  var ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
  var dataURL = canvas.toDataURL();
  return dataURL;
}
function getCanvasBase64(img) {
  var image = new Image();
  //至关重要
  image.crossOrigin = '';
  image.src = img;
  //至关重要
  var deferred = $.Deferred();
  if (img) {
    image.onload = function () {
      deferred.resolve(getBase64Image(image));//将base64传给done上传处理
      //document.getElementById("container2").appendChild(image);
    }
    return deferred.promise();//问题要让onload完成后再return sessionStorage['imgTest']
  }
}
getCanvasBase64(imgSrc)
  .then(function (base64) {
    // 这里拿到的是转换后的base64地址，可以做其他操作
    console.log("方式二》》》》》》》》》",base64);
  }, function (err) {
    console.log(err);
  });
```

