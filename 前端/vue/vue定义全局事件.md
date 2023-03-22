## vue定义全局事件
1. 定义Vue全局点击函数

   ```js
   // 定义全局点击函数
   Vue.prototype.globalClick = function (callback) {
       console.log(callback)
   };
   ```

2. 定义Vue全局点击函数 直接在.vue使用

   ```js
   this.globalClick(callback)
   ```

   

