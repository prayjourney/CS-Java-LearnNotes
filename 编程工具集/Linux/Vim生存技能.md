### Vim生存技能

***
##### 必备:
&emsp;&emsp;写模式: i,a,o
&emsp;&emsp;退出写模式: ecs



##### 快捷:
&emsp;&emsp;Ctrl+u: 向文件首翻半屏
&emsp;&emsp;Ctrl+d: 向文件尾翻半屏
&emsp;&emsp;Ctrl+f: 向文件尾翻一屏
&emsp;&emsp;Ctrl+b: 向文件首翻一屏



##### 文本操作:
&emsp;&emsp;dd: 删除本行
&emsp;&emsp;yy: 复制本行到剪切板
&emsp;&emsp;p： 在当前位置后粘贴
&emsp;&emsp;P：在当前位置前粘贴
&emsp;&emsp;G: 到文件尾
&emsp;&emsp;gg: 到文件第一行
&emsp;&emsp;$: 跳到行尾
&emsp;&emsp;^: 跳到行首
&emsp;&emsp;:行号: 光标跳转到指定行的行首
&emsp;&emsp;x: 删除光标后的一个字符
&emsp;&emsp;X: 删除光标前的一个字符
&emsp;&emsp;D: 删除从当前光标到光标所在行尾的全部字符；
&emsp;&emsp;dd: 删除光标行正行内容；
&emsp;&emsp;o: 在当前行后面插入一空行；
&emsp;&emsp;O: 在当前行前面插入一空行；
&emsp;&emsp;:set nonumber: 在命令模式下, 用于在最左端不显示行号；



##### 查找:
&emsp;&emsp;/字符串:文本查找操作,用于从当前光标所在位置开始向文件尾部查找指定字符串的内容,查找的字符串会被加亮显示；
&emsp;&emsp;?字符串:文本查找操作,用于从当前光标所在位置开始向文件头部查找指定字符串的内容,查找的字符串会被加亮显示；
&emsp;&emsp;a,bs/F/T:替换文本操作,用于在第a行到第b行之间,将F字符串换成T字符串.其中,"s/"表示进行替换操作；
&emsp;&emsp;:setnumber:在命令模式下,用于在最左端显示行号；常用:ZZ:命令模式下保存当前文件所做的修改后退出vi；:: 光标跳转到最后一行的行首；



---
ref: 
1.http://man.linuxde.net/vi,   2.https://www.cnblogs.com/orez88/articles/1867879.html,   3.https://www.cnblogs.com/prayjourney/p/10949972.html