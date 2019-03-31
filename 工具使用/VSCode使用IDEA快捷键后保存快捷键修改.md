### VSCode使用设置

***

##### 1.使用了IDEA快捷键, 保存快捷键失效的修改
修改ctrl+s的方法如下所述: 点击设置按钮, 键盘快捷方式, 然后打开keybindings.json, 将关于save的几个命令搜索到, 然后在用户的配置之中覆盖, 修改保存的方法即可,  在使用了idea的keymap时, 没有ctrl+s, 现在覆盖为如下的内容即可: 

> // 将密钥绑定放在此文件中以覆盖默认值
> [
> { "key": "ctrl+s", "command": "workbench.action.files.save" },
> { "key": "ctrl+alt+s", "command": "workbench.action.files.saveAll" },
> { "key": "ctrl+shift+s", "command": "workbench.action.files.saveAs" },
> { "key": "ctrl+k ctrl+shift+s", "command": "workbench.action.files.saveWithoutFormatting" },
> ]
> 然后就会在文件之中出现单独保存一个文件的快捷键.



##### 2.VSCode输出栏中文乱码设置
方法1: 全局修改
step1. 增加系统全局变量
以 windows 系统为例, 添加系统变量`PYTHONIOENCODING`: 

> key:PYTHONIOENCODING
> value:UTF8

step2. 修改 VSC 配置文件
F1 键调出控制台, 输入task,选择任务: 配置任务运行程序,打开tasks.json文件, 增加以下信息: 

```shell
    "options": {
    "env":{
    "PYTHONIOENCODING": "UTF-8"
  }
}
```
方法2: 在代码里更改编码
在每个需要中文的 python 文件中添加如下代码: 

```python
import io
import sys
# 改变标准输出的默认编码
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='utf8')
```
使用方法1和方法2需要重启 VSCode.方法1可以一劳永逸.





---
ref:
1.[VSCode print打印中文时控制台出现乱码](https://www.jianshu.com/p/e634bff989f2)

