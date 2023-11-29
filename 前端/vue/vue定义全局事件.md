## vue定义全局事件

#### 1.vue2全局事件

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


#### 2.vue3 vue2 通用

1. 安装

   ```sh
   npm install mitt
   ```

2. 工具类

   ```js
   import mitt from "mitt";
   
   const instance = mitt();
   const eventBus: any = {};
   eventBus.on = instance.on;
   eventBus.off = instance.off;
   eventBus.emit = instance.emit;
   
   export default eventBus;
   
   
   ```

3. 使用

   ```js
   import EventBus from "/xxxx/EventBus";
   
   // 发送消息
   EventBus.emit("show", data);
   
   // 接收消息
   EventBus.on("show", (data) => {
   
   });
   ```

   
