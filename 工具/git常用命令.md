## git 常用命令

##### 1. 指定用户名和邮箱

   ```shell
   git config --global user.name "liuguofeng" #基本信息
   git config --global user.email "liuguofeng@qq.com"#邮箱
   ```

##### 2. 基本操作

   ```shell
   git init #创建仓库
   git clone "https://github.com/liuguofeng-java/install.git"#克隆仓库到本地
   git status #获取本地状态
   git add index.html #添加文件
   git add -A #添加所有文件
   git commit -m "创建一个HTML" #提交
   git push #提交到远程仓库
   ```

##### 3. 查看分支\合并分支\切换分支

   ```shell
   git branch -r  #查看远端分支
   git checkout master #切换分支
   git merge master #合并master分支
   ```

##### 4. 查看历史记录

   ```shell
   git log ## 历史记录
   ```

##### 5. 回退版本

   ```shell
   git reset  #回退版本(一般配合git log命令使用)
   ```

##### 6. 标签管理

   ```shell
   git tag <标签名>
   git tag <标签名> <commit id>
   git tag -a <标签名> -m "备注"
   ```

##### 7.代码提交规则

- **fix:**：用于标记修复 bug 的提交，例如 `fix: 修复登录验证失败的问题`。
- **feat:**：表示新增了功能，比如 `feat: 添加用户注册功能`。
- **docs:**：代表对文档进行了修改，像 `docs: 更新 API 文档`。
- **style:**：意味着代码格式有调整，例如 `style: 统一使用 2 个空格缩进`。
- **refactor:**：指的是代码重构，例如 `refactor: 重构用户管理模块`。
- **test:**：表示添加或者修改了测试代码，比如 `test: 为登录功能添加单元测试`。
- **chore:**：代表一些杂项修改，例如 `chore: 更新依赖版本`。
