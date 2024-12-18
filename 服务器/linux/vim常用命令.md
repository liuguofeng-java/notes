## vim常用命令

#### 1.上下跳转指令

| 命令     | 描述                 |
| -------- | -------------------- |
| k        | 上移                 |
| j        | 下移                 |
| h        | 左移                 |
| l        | 右移                 |
| Ctrl + f | 在文件中前移一页     |
| Ctrl + b | 在文件中后移一页     |
| $        | 移动光标到当前行结尾 |
| 0        | 移动光标到当前行开头 |

#### 2.搜索命令

| 命令       | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| /str1      | 正向搜索字符串 str1                                          |
| n          | 继续搜索，找出 str1 字符串下次出现的位置                     |
| N          | 继续搜索，找出 str1 字符串上一次出现的位置                   |
| ?str2      | 反向搜索字符串 str2                                          |
| shift+8 =* | 当光标停留在一个单词上，* 键会在文件内搜索该单词，并跳转到下一处 |
| shift+3 =# | 当光标停留在一个单词上，# 在文件内搜索该单词，并跳转到上一处 |

#### 3.删除

| 命令    | 描述                                   |
| ------- | -------------------------------------- |
| rc | 用 c 替换光标所指向的当前字符          |
| nrc| 用 c 替换光标所指向的前 n 个字符       |
| x  | 删除光标所指向的当前字符               |
| nx | 删除光标所指向的后 n 个字符            |
| dw | 删除光标右侧的单词                     |
| ndw| 删除光标右侧的 n 个单词                |
| db | 删除光标左侧的单词                     |
| ndb| 删除光标左侧的 n 个字                  |
| dd | 删除光标所在行，并去除空隙             |
| ndd| 删除（剪切） n 行内容，并去除空隙      |
| d$ | 从当前光标起删除字符直到行的结束       |
| d0 | 从当前光标起删除字符直到行的开始       |
| J  | 删除本行的回车符（CR），并和下一行合并 |

#### 4.常用函数

| 命令            | 描述                                 |
| --------------- | ------------------------------------ |
| :%s/pattern//gn | 统计字符串数量(pattern - 查询字符串) |
| :set number     | 来开启行号显示                       |
| :set nonumber   | 关闭行号显示                         |
| :set hls        | 搜索查找高亮显示                     |

