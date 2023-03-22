## 原生js触发oninput事件
```javascript
var evt = document.createEvent('HTMLEvents')
 evt.initEvent('input', true, true)
 $("#tipinput").get(0).dispatchEvent(evt)
```

