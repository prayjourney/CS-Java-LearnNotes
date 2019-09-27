###  idea mac上快捷键
------

```undefined
如果使用的是 Windows PC 专用键盘，请用 Alt 键代替 Option 键，用 Windows 标志键代替 Command 键。
采用的是原生的Mac OS X快捷键,此处并未完全展示. 
```

#### 键盘符号和修饰键说明

> - Command( Windows ) ⌘
> - Shift ⇧
> - Option( Alt ) ⌥
> - Control ⌃
> - Caps Lock ⇪

#### 编辑快捷键

|                 描述                 | 快捷键                | 备注                                |
| :----------------------------------: | :-------------------- | :---------------------------------- |
|             find in name             | Shift + Commmand + N  | 根据名字查找文件                    |
|             find in path             | Shift + Ctrl + F      | 全局搜索                            |
| Generate(Constructor, getter&setter) | Ctrl + Enter/Ctrl + N | 构造体,get/set方法                  |
|           class to import            | Option + Enter        | 导入类                              |
|            Implementation            | Commmand + Option + B | 具体实现方法                        |
|      Comment with Line Comment       | Command + /           | 注释代码                            |
|           Extend Selection           | Command + W           | 逐步选中代码                        |
|       Move Caret to Line Start       | Command + ←           | 将输入移动到该行的开头              |
|        Move Caret to Line End        | Command + ←           | 将输入移动到该行的末尾              |
|                Basic                 | Ctrl + Space          | 代码自动补全                        |
|            Parameter Info            | Commmand + P          | 显示方法的参数信息                  |
|             Declaration              | Command + 鼠标悬停    | 显示代码简要信息                    |
|            Start New Line            | Shift + Enter         | 开始新的一行                        |
|                Expand                | Command + +           | 展开代码块                          |
|               Collapse               | Command + -           | 折叠代码块                          |
|         Delete to Word Start         | Option + Delete       | ⌥⌫ 删除到单词的开头                 |
|     Duplicate Line or Selection      | Command + D           | 复制行或代码块                      |
|             Delete Line              | Command + Y           | 删除行                              |
|          Move Statement Up           | Shift + Command + ↑   | 上移选中部分                        |
|         Move Statement Down          | Shift + Command + ↓   | 下移选中部分                        |
|           Indent Selection           | Tab/Shift + Tab       | 缩进代码/反缩进代码                 |
|           Optimize Imports           | Command + Option + O  | 优化导入                            |
|            Reformat Code             | Command + Option + L  | 格式化代码                          |
|          Surround With Code          | Command + Option + T  | 包围代码(使用if,else,try,catch的等) |


##### 系统快捷键

|   描述   | 快捷键       | 备注     |
| :------: | :----------- | :------- |
| Settings | Commmand + , | 打开设置 |


#### 不常用编辑快捷键

|                   描述                   | 快捷键               | 备注                   |
| :--------------------------------------: | :------------------- | :--------------------- |
|                Expand All                | Shift + Commmand + + | 展开所有代码块         |
|               Collapse All               | Shift + Commmand + - | 折叠所有代码块         |
| Move Caret to Code Start whith Selection | Shift + Command + [  | 选择直到代码块开始     |
|  Move Caret to Code End whith Selection  | Shift + Command + ]  | 选择直到代码块结束     |
|               Toggle Case                | Shift + Command +U   | 大小写切换             |
|                Join Lines                | Shift + Ctrl + J     | 智能的将代码拼接成一行 |
|            Paste from History            | Shift + Command + V  | 从最近的缓冲区粘贴     |



#### 常用的快捷键
alt+f7查找在哪里使用
command+alt+f7 这个是查找选中的字符在工程中出现的地方，可以不是方法变量类等，这个和上面的有区别的
command＋F7可以查询当前元素在当前文件中的引用，然后按F3可以选择 ，功能基本同上
选中文本，按command+shift+F7 ，高亮显示所有该文本，按Esc高亮消失。
选中文本，按Alt+F3 ，逐个往下查找相同文本，并高亮显示。shift+f3就是往上找
ctrl+enter 出现生成get,set方法的界面
shift+enter 换到下一行
command+N 查找类
command+shift+N 查找文件
command+R 替换
ctrl+shift+R 可以在整个工程或着某个目录下面替换变量
command+Y 删除行
command+D复制一行
ctrl+shift+J 把多行连接成一行，会去掉空格的行
command+J 可以生成一些自动代码，比如for循环
command+B 找变量的来源  同F4   查找变量来源
ctrl+shift+B 找变量所属的类
command+G定位
command+F 在当前文件里查找文本 f3向下看，shift+f3向上看
ctrl+shift+F  可以在整个工程或着某个目录下面查找变量   相当于eclipse里的ctrl+H
alt+shift+C 最近修改的文件
command+E最近打开的文件
alt+enter 导入包，自动修改
command+alt+L 格式化代码
command+alt+I 自动缩进，不用多次使用tab或着backspace键，也是比较方便的
ctrl+shift+space代码补全，这个会判断可能用到的，这个代码补全和代码提示是不一样的
command+P 方法参数提示
command+alt+T 把选中的代码放在 TRY{} IF{} ELSE{} 里
command+X剪切删除行
command+shift+V 可以复制多个文本
command+shift+U 大小写转换
alt+f1查找文件所在目录位置
command+/ 注释一行或着多行 //
ctrl+shift+/ 注释*/\*...\*/*
command+alt+左右箭头 返回上次编辑的位置
shift+f6重命名
command+shift+上下箭头 把代码上移或着下移
command+[或]  可以跳到大括号的开头结尾
command+f12可以显示当前文件的结构
command+alt+B 可以导航到一个抽象方法的实现代码
command+shift+小键盘的*  列编辑
alt+f8 debug时选中查看值
f8相当于eclipse的f6跳到下一步
shift+f8相当于eclipse的f8跳到下一个断点，也相当于eclipse的f7跳出函数
f7相当于eclipse的f5就是进入到代码
alt+shift+f7这个是强制进入代码
ctrl+shift+f9 debug运行java类
ctrl+shift+f10正常运行java类
command+f2停止运行

---
ref:
1.[Idea在Mac上快捷键](https://www.jianshu.com/p/3d0cf615d41a),   2.[Mac下IDEA的使用之常用快捷键篇](https://blog.csdn.net/iguiyi/article/details/51853728)