## 打印print-js

##### 1. 安装插件

```sh
npm install print-js --save
```

##### 2.安装插件

> 注意：宽度一定要控制在1000px内负责打印出来的内容会变形

```vue
<template>
    <a-button type="primary" @click="print()">打印</a-button>
    <div  id="printId">
        要打印的内容
    </div>
</template>

<script lang="ts" setup>
import printJS from "print-js";

function print() {
  printJS({
    printable: "printId",
    type: 'html',
    targetStyles: ['*'],
    style: "@page {margin:2.4cm 2cm ;resolution: 300dpi;}",
    font_size: '',
  });
}
</script>

<style scoped lang="less">
div {
  //webkit 为Google Chrome、Safari等浏览器内核
  -webkit-print-color-adjust: exact;
  //解决火狐浏览器打印
  print-color-adjust: exact;
  color-adjust: exact;
}
</style>
```

