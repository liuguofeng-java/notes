## linux开机启动crontab

##### 1.运行crontab -e 命令；如果出现得是如下,说明第一次运行`crontab`,这里是让选择编译器的意思,3是vim

```sh
    Select an editor.  To change later, run 'select-editor'.
    1. /bin/ed
    2. /bin/nano        <---- easiest
    3. /usr/bin/vim.basic
    4. /usr/bin/vim.tiny
```

>补充两点：
>1、如果选择了2，那个nano编辑器，可以按ctrl+x退出。
>2、如果不小心选择了2，那么又想改回vim怎么办呢？运行这个命令

```sh
select-editor
```

##### 2.使用crontab开机自启

我们可以自己设置计划任务时间，然后编写对应的脚本。但是，有个特殊的任务，叫作 @reboot ，我们其实也可以直接从它的字面意义看出来，这个任务就是在系统重启之后自动运行某个脚本。

那它将运行的是什么脚本呢？我们如何去设置这个脚本呢？我们可以通过 crontab -e 来设置。

```sh
#执行命令
crontab -e
#添加
@reboot /home/ok/auto_run_script.sh
```

