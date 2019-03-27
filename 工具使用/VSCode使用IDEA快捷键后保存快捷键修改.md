### VSCode使用IDEA快捷键后保存快捷键修改

***

修改ctrl+s的方法如下所述：点击设置按钮，键盘快捷方式，然后打开keybindings.json, 将关于save的几个命令搜索到，然后在用户的配置之中覆盖，修改保存的方法即可， 在使用了idea的keymap时，没有ctrl+s，现在覆盖为如下的内容即可：

> // 将密钥绑定放在此文件中以覆盖默认值
> [
> { "key": "ctrl+s", "command": "workbench.action.files.save" },
> { "key": "ctrl+alt+s", "command": "workbench.action.files.saveAll" },
> { "key": "ctrl+shift+s", "command": "workbench.action.files.saveAs" },
> { "key": "ctrl+k ctrl+shift+s", "command": "workbench.action.files.saveWithoutFormatting" },
> ]
> 然后就会在文件之中出现单独保存一个文件的快捷键。



***
