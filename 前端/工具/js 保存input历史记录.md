## js 保存input历史记录
```javascript
<!DOCTYPE html>
<html>

    <head lang="en">
        <meta charset="UTF-8">
        <title>历史记录</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <meta name="apple-mobile-web-app-capable" content="no">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="format-detection" content="telephone=no">
        <style>
            .history {
                text-align: center;
            }
            
            #sec {
                width: 50%;
                overflow: hidden;
                text-align: left;
                height: 38px;
                border: 1px solid #ccc;
                border-radius: 10px;
            }
            
            .delete:after {
                clear: both;
                content: '.';
                display: block;
                width: 0;
                height: 0;
                visibility: hidden;
            }
            
            .delete>div {
                border-radius: 50px;
                float: left;
                height: 23px;
                border: 1px solid #ccc;
                background: #E0E0E0;
                margin-top: 14px;
                margin-right: 10px;
                overflow: hidden;
            }
            
            #search {
                width: 141px;
                height: 37px;
                font-size: 14px;
                line-height: 14px;
                color: #959595;
                padding-bottom: 2px;
            }
            
            #his-dele {
                width: 22px;
                height: 22px;
                line-height: 22px;
                display: inline-block;
                background: #E0E0E0;
                color: #fff;
                border-radius: 50%;
                text-align: center;
                margin-left: 10px;
                float: right;
                position: relative;
                top: -26px;
            }
        </style>
    </head>

    <body>
        <input class="" id="sec">
        <!--搜索框-->
        <button id="search">搜索</button>

        <!--历史记录-->
        <div class="current">最近搜索</div>
        <div class="delete history" style="width: 100%;float: left"></div>

        <!--删除按钮-->
        <div class="history" id="his-dele">X</div>

        <!--无存储记录-->
        <div class="Storage" style="width: 100px;height: 100px;margin: 0 auto;">无存储记录</div>

        <script src="C:\Users\13961\Desktop\dome\jquerysjyy\js\jquery.min.js"></script>
        <script>
            /*搜索记录相关*/

            var hisTime; //获取搜索时间数组
            var hisItem; //获取搜索内容数组
            var firstKey; //获取最早的1个搜索时间

            function init() {

                hisTime = []; //时间数组置空
                hisItem = []; //内容数组置空

                for(var i = 0; i < localStorage.length; i++) { //数据去重
                    if(!isNaN(localStorage.key(i))) { //判断数据是否合法
                        hisTime.push(localStorage.key(i));
                    }
                }

                if(hisTime.length > 0) {
                    hisTime.sort(); //排序
                    for(var y = 0; y < hisTime.length; y++) {
                        localStorage.getItem(hisTime[y]).trim() && hisItem.push(localStorage.getItem(hisTime[y]));
                    }
                }
                console.log(hisTime);
                console.log(hisItem);
                $(".delete").html(""); //执行init(),每次清空之前添加的节点
                $(".Storage").show();
                for(var i = 0; i < hisItem.length; i++) {

                    $(".delete").prepend('<div class="word-break">' + hisItem[i] + '</div>');
                    if(hisItem[i] != '') {
                        $(".Storage").hide();
                    }
                }

            }

            init(); //调用

            $("#search").click(function() {
                var value = $("#sec").val();
                var time = (new Date()).getTime();

                if(!value) {
                    alert("你未输入搜索内容");
                    return false;
                }
                //输入的内容localStorage有记录

                if($.inArray(value, hisItem) >= 0) {

                    for(var j = 0; j < localStorage.length; j++) {
                        if(value == localStorage.getItem(localStorage.key(j))) {
                            localStorage.removeItem(localStorage.key(j));
                        }
                    }
                    localStorage.setItem(time, value);

                } else {
                    localStorage.setItem(time, value);
                }
                init();

            });

            //清除记录功能
            $("#his-dele").click(function() {
                var f = 0;
                for(; f < hisTime.length; f++) {
                    localStorage.removeItem(hisTime[f]);
                }
                init();
            });

            //苹果手机不兼容出现input无法取值以下是解决方法

            $(".delete").on("click", ".word-break", function() {
                var div = $(this).text();
                $('#sec').val(div);
            });
        </script>
    </body>
</html>
```

