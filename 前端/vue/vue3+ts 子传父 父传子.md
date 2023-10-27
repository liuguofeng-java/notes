## vue3+ts 子传父 父传子

#### 1.父传子

```html
// 父组件
<template>
    <div>
        <buttom @click="onOpen"></buttom>
        <!-- 需要注册组件 -->
    	<Form ref="formRef" @ok="getList" />
    </div>
 	
</template>
<script setup lang="ts">
import { ref } from "vue";
import Form from "./form.vue";

// 组件实例
const formRef = ref<any>();
// 新增按钮操作
function onOpen() {
  formRef.value.open('123');
}
</script>


// 子组件
<template>

</template>

<script setup lang="ts">
// 初始化表单
const open = (formId: string) => {
  // 获取到来自父组件的值formId
};
// 需要注册父组件才能调用
defineExpose({
  open
});
</script>
```

#### 2.子传父

```html
//子组件
<template>
    <div>
        <div>子组件{{ num }}</div>
        <div>{{ n }}</div>
        <button @click="hdClick">按钮</button>
    </div>
</template>
<script setup lang="ts">
import { ref } from 'vue';
let props = defineProps({
    num: {
        type: Number,
        default: 100
    }
})
const emit = defineEmits<{
    // update:固定写法，后面的变量是父组件中v-model：后面的这个变量
    (event: 'ok', n: number): void
}>()
let n = ref(props.num)
const hdClick = () => {
    emit('ok', n.value+=10)
}
</script>

// 父组件
<template>
    <div>
        <div>
            <div> 父组件 {{ num1 }}</div>
            <button @click="add">父按钮</button>
        </div>
        <!-- v-model的传值 -->
        <Child v-model:num="num1"></Child>
    </div>
</template>
<script setup lang="ts">
import Child from './02-AppChild.vue'
import { ref } from 'vue'
let num1 = ref(20)
const add = () => {
    num1.value++
}
</script>
```

