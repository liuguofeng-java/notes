## 复制插件 clipboard.js

从npm 安装

```javascript
npm install clipboard --save
```

或者，如果您不喜欢包管理，只需下载一个ZIP文件

- script 引入

```javascript
<script src="dist/clipboard.min.js"></script>
```

- 三方 CDN引入

现在需要通过传递一个DOM选择器、一个HTML标签或者一组HTML标签来实例化它

```javascript
new ClipboardJS('.btn');  //通过类名.btn的元素实例化
```



复制

相当普遍的使用场景是从其他元素复制文本。在触发元素上添加 data-clipboard-target 属性，该属性值用来匹配另一个元素选择器。

```javascript
<!-- Target -->
<!-- <input
  id="bar"
  value="无敌大帅哥"
> -->
<p id="bar">无敌大帅哥</p>
<!-- Trigger -->
<button class="btn" data-clipboard-target="#bar" > 复制 </button>
```

剪切

另外，也可以定义 data-clipboard-action 属性为 copy/cut 来，明确操作是 复制 / 剪切

如果忽略了这个属性，便默认 复制

```javascript
<!-- Target -->
<textarea id="bar">Mussum ipsum cacilds...</textarea>

<!-- Trigger -->
<button class="btn" data-clipboard-action="cut" data-clipboard-target="#bar">
    Cut to clipboard
</button>
```

正如上例，剪切 cut 的操作只能在 <input> 和 <textarea> 标签中起作用，在其他标签中会出现事件正常调用，但是操作是失败的，粘贴板是没有改变的。

通过属性复制文本

我们甚至不必需要其他承载文本的元素，仅通过 在触发元素中 添加 data-clipboard-text 属性 来完成复制

```javascript
<!-- Trigger -->
<button class="btn" data-clipboard-text="Just because you can doesn't mean you should — clipboard.js">
    Copy to clipboard
</button>
```

注意：

- data-clipboard-text “级别最高”，在 data-clipboard-target 等属性存在时，复制内容及相关参数以 data-clipboard-text 为准

事件

回调函数： success / error

| 事件名 | 参数 |
| - | - |
| success | event.action copy/cut 操作 |
|  | event.text copy/cut 操作文本内容 |
|  | event.triger 触发操作的DOM元素 |
| error | event.action copy/cut 操作 |
|  | event.triger 触发操作的DOM元素 |




```javascript
var clipboard = new ClipboardJS('.btn');

clipboard.on('success', function(e) {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);

    e.clearSelection();
});

clipboard.on('error', function(e) {
    console.error('Action:', e.action);
    console.error('Trigger:', e.trigger);
});
```

工具提示

每个应用程序有不同的设计需求，这就是为什么clipboard.js不包括任何CSS或内置的工具提示解决方案。

您在这个演示站点上看到的工具提示是使用GitHub的Primer构建的。如果你正在寻找相似的外观和感觉，你可能想看看。

高级用法

如果你不想修改你的HTML，有一个非常方便的命令式API供你使用。您所需要做的就是声明一个函数，执行您的操作，然后返回一个值。

例如 如果想动态的设置一个目标元素target，则需要返回一个节点,即 动态设置点击复制的目标元素

```javascript
new ClipboardJS('.btn', {
    target: function(trigger) {
        return trigger.nextElementSibling  ||  document.getElementById('name');
    }
});
```

如果想动态设置内容文本text，则返回一个字符串String

```javascript
new ClipboardJS('.btn', {
    text: function(trigger) {
        return trigger.getAttribute('aria-label') || 'default text ';
    }
});
```

在Bootstrap Modals 中或与任何其他更改焦点的库一起使用时，将希望将焦点元素设置为 container 值。

```javascript
new ClipboardJS('.btn', {
    container: document.getElementById('modal')
});
```

并且，如果在单页应用中使用时，要更精确地管理DOM的生命周期，可以使用以下方法清除创建的事件对象

```javascript
var clipboard = new ClipboardJS('.btn');
clipboard.destroy();
```

