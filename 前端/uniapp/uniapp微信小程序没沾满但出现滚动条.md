## uniapp 微信小程序没沾满但出现滚动条

##### 1.问题描述:
> 在循环列表的时候明明数据还没沾满整个屏幕，但是出现了竖行滚动条

##### 2.解决方案

margin-top 垂直方向塌陷导致的，建议开发者自行规避。

解决方案:在第一个元素前增加空元素。

`<view style="content: ''; overflow: hidden;"></view>`

```html
<scroll-view scroll-y="true" style='height:{{winHeight - 100}}px' class='scrollcolumn'>
    <view style="content: ''; overflow: hidden;"></view>
    //由margin-top 垂直方向塌陷导致的，加一个空元素就好了
    <view wx:for="{{datalist}}" :key='item.code' class='data-view' data-code="{{item.CODE}}" bindtap="bindtappp">
            <view class='data-view-one'>
                <view class='data-name'>姓名：</view>
                <view class='data-text'>{{item.NAME}}</view>
            </view>
            <view class='data-view-one'>
                <view class='data-name'>公司：</view>
                <view class='data-text'>{{item.POSE}}</view>
            </view>
            <view class='data-view-one'>
                <view class='data-name'>号码：</view>
                <view class='data-text'>{{item.PHONE}}</view>
            </view>
        </view>
</scroll-view>

```

