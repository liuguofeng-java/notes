## JS方法总结 - 控制浏览器全屏与退出全屏



1. 封装统一的全屏功能，参数为要全屏的元素，默认是 document.documentElement

```javascript
function fullScreen(fullElement = document.documentElement) {
    // 判断是否处在全屏状态
    const isFullScreen = document.isFullScreen || document.mozIsFullScreen || document.webkitIsFullScreen;
    if (isFullScreen) {
         const el = document;
         let cfs = el.cancelFullScreen || el.mozCancelFullScreen || el.msExitFullscreen || el.webkitExitFullscreen || el.exitFullscreen;
          if (cfs) {
               cfs.call(el);
          } 
     } else {
          const el = fullElement;
          let rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullscreen;
          if (rfs) {
               rfs.call(el);
          }
     }
}
```

2. 当使用F11进行全屏操作后，再点击按钮会无效，可以禁掉F11的全屏功能

```javascript
window.addEventListener('keydown', e => {
    // 阻止F11键默认事件，用HTML5全屏API代替
    e = e || window.event;
    if (e.keyCode === 122) {
        e.preventDefault();
        enterFullScreen();
    }
});
```

 