## css超出隐藏

1.在表格中的td,实现文字溢出省略

- 只对单行文字有效，对多行省略不起作用

```css
table{width:100%;table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */}
td{
    width:100%;
    word-break:keep-all;/* 不换行 */
    white-space:nowrap;/* 不换行 */
    overflow:hidden;
    text-overflow:ellipsis;
}
```

2.单行超出隐藏

- 固定属性

```css
div{
    overflow:hidden; 
    text-overflow:ellipsis;
    white-space:nowrap; 
}
```

3.多行超出省略

- display:-webkit-box; //将对象作为弹性伸缩盒子模型显示。

```css
div{
    display: -webkit-box;
    word-break: break-all;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 4;
    overflow: hidden;
    text-overflow: ellipsis;
}
```

4.脚本控制

- 获取字符串的长度然后做判断

```css
window.onload = function(){
            var text = document.getElementsByClassName('ellipsis');
            for(var i=0;i<text.length;i++){
                str = text[i].innerHTML;
                textLeng = 8;
                if(str.length > textLeng ){
                      text[i] .innerHTML = str.substring(0,textLeng )+"...";
                } 
            }     
        }
```

