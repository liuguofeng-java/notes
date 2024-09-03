## dayjs时间库

##### 1.安装

```sh
npm install dayjs 
```

##### 2.引入day.js

```js
import dayjs from 'dayjs';
```

##### 3.常用的方法

```js
// 获取dayjs实例
let now = dayjs()

// 输出时间并格式化
now.format('YYYY-MM-DD HH:mm:ss') // 2024-09-03 09:13:47

let year = now.year(); // 输出年 2024
let month = now.month() +1; // 输出月 9, 注意:month()是从0开始计算的
let day = now.date(); // 输出天 3
let hour = now.hour(); // 输出时 9
let minute = now.minute(); //输出分钟 13
let second = now.second(); // 输出秒 47

let day = now.day(); //输出星期2

// 时间相减
now.subtract(1, 'year').format('YYYY-MM-DD');             //2023-01-16
now.subtract(1, 'months').format('YYYY-MM-DD');           //2023-12-16
now.subtract(1, 'days').format('YYYY-MM-DD');             //2024-01-15 
now.subtract(1, 'hours').format('HH:mm:ss');              //09:48:39  
now.subtract(1, 'minute').format('HH:mm:ss');             //10:47:39
now.subtract(1, 'seconds').format('HH:mm:ss');            //10:48:38
 
dayjs('2023-12-12').subtract(1, 'year').format('YYYY-MM-DD');             //2022-12-12 
dayjs('2023-12-12').subtract(1, 'months').format('YYYY-MM-DD');           //2023-11-12
dayjs('2023-12-12').subtract(1, 'days').format('YYYY-MM-DD');             //2023-12-11
dayjs('2023-12-12').subtract(1, 'hours').format('YYY-MM-DD HH:mm:ss');    //2023-12-11 23:00:00 
dayjs('2023-12-12').subtract(1, 'minute').format('YYY-MM-DD HH:mm:ss');   //2023-12-11 23:59:00
dayjs('2023-12-12').subtract(1, 'seconds').format('HH:mm:ss');            //23:59:59

// 时间相加
dayjs('2023-12-12').add(1, 'year').format('YYYY-MM-DD');             //2024-12-12 
dayjs('2023-12-12').add(1, 'months').format('YYYY-MM-DD');           //2024-01-12
dayjs('2023-12-12').add(1, 'days').format('YYYY-MM-DD');             //2023-12-13
dayjs('2023-12-12').add(1, 'hours').format('YYY-MM-DD HH:mm:ss');    //2023-12-12 01:00:00
dayjs('2023-12-12').add(1, 'minute').format('YYY-MM-DD HH:mm:ss');   //2023-12-12 00:01:00
dayjs('2023-12-12').add(1, 'seconds').format('HH:mm:ss');            //00:00:01
```

