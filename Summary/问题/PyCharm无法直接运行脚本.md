### PyCharm无法直接运行脚本

***

##### 情况

此处所说的无法直接运行脚本是指

ython和Python tests两个部分，把要运行的文件配置从Python tests删掉加在Python里就可以了。这是因为最开始直接run的时候没选，所以默认按照单元测试run的，这个保存到本地配置里了，所以你下次每次运行都会按照单元测试跑，使用Alt+Shift+F10调出Edit Configurations

![keykeykey](../../images/o_keykeykey.png)

对于一个文件想单独run的时候，在菜单栏Run里选Run...,然后会弹出两个选择一个是xxx.py 另一个是 unittest in xxx.py，模拟效果如下

![deleteshow](../../images/o_deleteshow.gif)



ref:
1.[pycharm,run unittests后为什么__main__:后的代码没执行？](https://www.zhihu.com/question/46675952/answer/130040769),   2.[pyCharm不能直接run的原因](http://www.cnblogs.com/AmarantineBlogs/p/7494081.html)