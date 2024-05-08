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
// const emit = defineEmits(['ok'])
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

#### 3.props 父传子

```html
// 父组件
<template>
  // 引入子组件
  <MultipleUser :list="list" ref="multipleUser" @ok="multipleUserOk" />
</template>

<script setup lang="ts">
import { ref } from "vue";
import MultipleUser from "@/components/MultipleUser/index.vue";

// 传入的pops的数据
const list = ref<any[]>([]);
list.push({
    userId: '1',
    userName: 'admin'
})
</script>

// 子组件
<!-- 多选用户组件 -->
<template>
  {{ selectUserList }}
</template>
<script setup lang="ts">
import { ref, watch, reactive } from "vue";

// 接收的值
const props = defineProps({
  list: {
    type: Array,
    default: () => []
  }
});

// 当传入的props.list 的值改变时触发
watch(
  () => props.list,
  async () => {
    selectUserList.value = props.list;
  },
  { deep: true, immediate: true }
);
</script>
```

