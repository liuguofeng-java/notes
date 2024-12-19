## vue监听值变化

##### 1.vue2监听值发生变化

```js
export default {
  data() {
    return {
      user: {
        name: 'John',
        age: 25,
      },
    };
  },
  watch: {
    user: {
      handler(newValue, oldValue) {
          console.log('user变化了', newValue);
      },
      deep: true,
      immediate: true
    },
  },
};
```

##### 2.vue3监听值发生变化

```js

import { ref,watch } from 'vue';

const user = {
    name: 'John',
	age: 25,
},

 watch(person, (newValue, oldValue) => {
    console.log('user变化了', newValue);
  }, {
    deep: true, 
    immediate: true
  })
```

##### 3.watch中属性

| 配置选项          | 功能                                                         |
| ----------------- | ------------------------------------------------------------ |
| `deep: true`      | 深度监听,适用于对象或数组中的嵌套属性                        |
| `immediate: true` | 立即执行监听函数，即在监听器初次绑定时会立即触发一次回调，而不等待值变化。 |