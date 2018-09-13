### 关于Checkstyle

***

大项目都需要小组中的多人共同完成，但是每个人都有自己的编码习惯，甚至很多都是不正确的。那么如何使小组所有开发人员都遵循某些编码规范，以保证项目代码风格的一致性呢？如果硬性地要求每个开发人员在提交代码之前，都要对照的编码规范将自己的代码检查一遍，将是一个非常枯燥而且耗时的任务。Checkstyle是一个开源代码分析工具，能够帮助开发人员保证他们的代码遵循一定的代码规范。Checkstyle通过不断地检查你的代码，一旦发现有违反定义的代码规范的地方就立马提示，以便开发人员能够及时发现和修改不规范代码。Checkstyle在Eclipse中的插件是[eclipse-cs](http://http//eclipse-cs.sourceforge.net/)。



##### 安装Checkstyle插件

Eclipse菜单栏上选择 Help -> Install New Software...，进入如下安装界面：

![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_ch1.jpg)

点击“Add...”打开Add Repository对话框，如图输入Name和Location，点击“OK”。选择刚刚添加的JAutodoc，一直点击“Next >”直到安装结束。



##### 配置Checkstyle

Eclipse菜单栏上选择 Window -> Preferences -> Checkstyle，进入如下设置界面：

![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_ch2.jpg)

在Global Check Configurations框中，列出可以选择的检查配置（Check Configuration），Default栏标记为对勾的默认配置。

如果想自己配置检查选择，可以点击“New...”按钮新建一个配置，进入如下Check Configuration界面：

![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_ch3.jpg)

检查配置的类型，可以有多种选择。Internal Configuration类型是检查配置存在于Eclipse内部；External Configuration类型相当于导入一个已有的xml配置文件。Checkstyle配置都是xml文件。

如果想修改已有的配置，可以点击“Configure...”按钮，打开Checkstyle Configuration对话框，根据需要进行修改。



#####  使用Checkstyle

Checkstyle会在代码开发过程中，不断地检查代码规范，一般检查的内容包括：

- Javadoc注释
- 命名约定
- 标题
- Import
- 大小
- 空白
- 修饰符
- 代码
- 类设计

下面这段代码经过Checkstyle检查之后，不符合规范的代码，底色都会被标记为浅黄色进行提示。点击行头的提示标记，就会显示具体不符合规范的地方。示例如下图所示：

![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_ch4.jpg)



##### Checkstyle常见的输出结果

1.Type is missing a javadoc commentClass   缺少类型说明
2.“{” should be on the previous line   “{” 应该位于前一行
3.Methods is missing a javadoc comment   方法前面缺少javadoc注释
4.Expected @throws tag for “Exception   在注释中希望有@throws的说明
5.“.” Is preceeded with whitespace    “.”前面不能有空格
6.“.” Is followed by whitespace“.”   后面不能有空格
7.“=” is not preceeded with whitespace   “=” 前面缺少空格
8．“=” is not followed with whitespace   “=” 后面缺少空格
9.“}” should be on the same line   “}” 应该与下条语句位于同一行
10．Unused @param tag for “unused”   没有参数“unused”，不需注释
11．Variable “CA” missing javadoc   变量“CA”缺少javadoc注释
12．Line longer than 80characters   行长度超过80
13．Line contains a tab character   行含有”tab” 字符
14．Redundant “Public” modifier   冗余的“public” modifier
15．Final modifier out of order with the JSL   suggestionFinal modifier的顺序错误
16．Avoid using the “.\*” form of import   Import格式避免使用“.\*”
17．Redundant import from the same package   从同一个包中Import内容
18．Unused import-java.util.list   Import进来的java.util.list没有被使用
19．Duplicate import to line 13   重复Import同一个内容
20．Import from illegal package   从非法包中 Import内容
21．“while” construct must use “{}”   “while” 语句缺少“{}”
22．Variable “sTest1” must be private and have accessor method   变量“sTest1”应该是private的，并且有调用它的方法
23．Variable “ABC” must match pattern “^[a-z][a-zA-Z0-9]\*$”   变量“ABC”不符合命名规则“^[a-z][a-zA-Z0-9]\*$”
24．“(” is followed by whitespace   “(” 后面不能有空格
25．“)” is proceeded by whitespace   “)” 前面不能有空格


ref:
1.[Checkstyle, FindBugs, PMD, VisualVM四种代码检测工具的比较与相关心得](https://blog.csdn.net/fanyang_1996/article/details/53792524),   2.[玩转Eclipse — 自动代码规范检查工具Checkstyle](https://blog.csdn.net/hotdust/article/details/52205861)