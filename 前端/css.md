## css

flex布局

```css
display: flex;
justify-content : space-around;
```

字体

```css
font-family:"宋体";//字体
font-size:50px;//文字大小
font-weight:900//字体加粗
font-style:italic;//字体倾斜
```

文字

```css
color:"red";//改变字体颜色
text-ailgn:center://字体居中
line-height:20px//行高
```

伪类和伪元素

```css
a:link{/*未访问*/
    color: brown;
}
a:visited{/*以访问*/
    color: brown;
}
a:hover{/*鼠标移入*/
    color: chartreuse;
}
a:active{/*鼠标点击*/
    color: coral;
}
div:before{/*在前边加内容*/
    content: url(1.jpg);
}
div::after{/*在后边加内容*/
    content: url(1.jpg);
}
input:focus{/*获取焦点*/ 
    background-color: coral;/**/
}
a::-moz-selection{/*选中（火狐）*/
    color: chartreuse;
}
a::selection{/*选中*/
    background-color: darkgreen;
}
display:
    block:按块级元素
    inline:按内联元素
    inline-block:按内块元素
    none:位置不会保留并隐藏
visibility:hidden;位置保留
```

背景

```css
background-color: red;//背景颜色
background-image: url("a.jpg");//背景图片
background-repeat: no-repeat;//背景图片是否重复
background-position: top center;//背景图片位置
background-size: 1000px 1000px;//图片大小
background-attachment: fixed;//图片是否跟随页面内容移动
border-radius: 15px;//圆角
opacity: 0.5;//透明的
```

文本

```css
font-size //字体大小
font-family: 仿宋; //字体
font-style: italic;//倾斜
font-weight: 990;//加粗
line-height: 40px;//行距
letter-spacing: 10px;//间距
text-indent: 2em;//缩进
text-align: center;//文字位
text-shadow: 10px 10px 0px red;//阴影
```

ul li

```css
list-style-image: none;
list-style-type: georgian;
list-style: none;
```

轮廓

```css
outline-color: rebeccapurple;//轮廓的颜色
outline-style: double;//轮廓的样式
outline-width: 20px;//轮廓的宽度
```

盒子模型

```css
margin: auto auto;
padding: 30px;
border: black ;
```

布局

```css
position: relative;//固定布局
position: absolute;//不固定
z-index:1;//覆盖顺序
```

浮动

```css
float: left;
clear:
overflow: auto;//超出自动匹配
```

动画

```css
animation: 名字   执行时间    匀速       延时时间   执行次数    执行顺序;
animation: dome   2s         ease-in    0s        infinite   alternate;
```

```css
div:hover{
    -webkit-animation-name: hover;
    -webkit-animation-duration: 1s;
    -webkit-animation-timing-function: ease-in;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation: hover 1s ease-in infinite;//简写
}
@-webkit-keyframes hover {
    0%{
        width: 100px;
        height: 100px;
        border-radius: 50%;
    }
    50%{
        width: 200px;
        height: 200px;
        border-radius: 50%;
        background-color: darkgreen;
    }
    100%{
        width: 100px;
        height: 100px;
        border-radius: 50%;
    }
```