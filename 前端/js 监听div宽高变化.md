## js 监听div宽高变化

要监听 `div` 元素的宽度和高度变化，可以使用 **ResizeObserver**，它是一个原生 JavaScript API，用于监视元素尺寸的变化，包括高度和宽度。

如：

```js
// 选择要监听的div元素
const divElement = document.getElementById('myDiv');

// 创建一个ResizeObserver实例
const resizeObserver = new ResizeObserver(entries => {
  // 监听到div尺寸变化时触发
  entries.forEach(entry => {
    const { height, width } = entry.contentRect;
    console.log(`Div height changed: ${height}px`);
    console.log(`Div width changed: ${width}px`);
  });
});

// 启动对div元素的监听
resizeObserver.observe(divElement);
```

### 解释：

- **`ResizeObserver`**：监听元素的尺寸变化。
- **`entries`**：是一个数组，包含所有变化的目标元素。可以通过 `entry.contentRect` 获取该元素的高度和宽度。
- **`observe`**：用来启动对目标元素的监听。