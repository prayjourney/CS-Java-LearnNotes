### Jenkins和其使用

***

####  Jenkins是什么

##### Jenkins简介
Jenkins是一个可扩展的持续集成引擎。主要作用：
- 持续、自动地构建/测试软件项目。
- 监控一些定时执行的任务。

##### Jenkins特性
- 易于安装-只要把jenkins.war部署到servlet容器，不需要数据库支持。
- 易于配置-所有配置都是通过其提供的web界面实现。
- 集成RSS/E-mail通过RSS发布构建结果或当构建完成时通过e-mail通知。
- 生成JUnit/TestNG测试报告。
- 分布式构建支持Jenkins能够让多台计算机一起构建/测试。
- 文件识别:Jenkins能够跟踪哪次构建生成哪些jar，哪次构建使用哪个版本的jar等。
- 插件支持:支持扩展插件，你可以开发适合自己团队使用的工具。

##### Jenkins的由来
目前持续集成(CI)已成为当前许多软件开发团队在整个软件开发生命周期内侧重于保证代码质量的常见做法。它是一种实践，旨在缓和和稳固软件的构建过程。并且能够帮助您的开发团队应对如下挑战：
- 软件构建自动化 ：配置完成后，CI系统会依照预先制定的时间表，或者针对某一特定事件，对目标软件进行构建。
- 构建可持续的自动化检查 ：CI系统能持续地获取新增或修改后签入的源代码，也就是说，当软件开发团队需要周期性的检查新增或修改后的代码时，CI系统会不断确认这些新代码是否破坏了原有软件的成功构建。这减少了开发者们在检查彼此相互依存的代码中变化情况需要花费的时间和精力(说直接一点也是钱啊，呵呵)。
- 构建可持续的自动化测试 ：构建检查的扩展部分，构建后执行预先制定的一套测试规则，完成后触发通知(Email,RSS等等)给相关的当事人。
- 生成后后续过程的自动化 :当自动化检查和测试成功完成，软件构建的周期中可能也需要一些额外的任务，诸如生成文档、打包软件、部署构件到一个运行环境或者软件仓库。这样，构件才能更迅速地提供给用户使用。

**部署一个CI系统需要的最低要求是，一个可获取的源代码的仓库，一个包含构建脚本的项目**。下图概括了CI系统的基本结构：
![jenkins](../images/jenkins.jpg)

该系统的各个组成部分是按如下顺序来发挥作用的：
1. 开发者检入代码到源代码仓库。
2. CI系统会为每一个项目创建了一个单独的工作区。当预设或请求一次新的构建时，它将把源代码仓库的源码存放到对应的工作区。
3. CI系统会在对应的工作区内执行构建过程。
4. (配置如果存在)构建完成后，CI系统会在一个新的构件中执行定义的一套测试。完成后触发通知(Email,RSS等等)给相关的当事人。
5. (配置如果存在)如果构建成功，这个构件会被打包并转移到一个部署目标(如应用服务器)或存储为软件仓库中的一个新版本。软件仓库可以是CI系统的一部分，也可以是一个外部的仓库，诸如一个文件服务器或者像Java.net、 SourceForge之类的网站。
6. CI系统通常会根据请求发起相应的操作，诸如即时构建、生成报告，或者检索一些构建好的构件。

Jenkins就是这么一个CI系统。之前叫做Hudson。以下是使用Jenkins的一些理由：
- 是所有CI产品中在安装和配置上最简单的。
- 基于Web访问，用户界面非常友好、直观和灵活，在许多情况下，还提供了AJAX的即时反馈。
- Jenkins是基于Java开发的(如果你是一个Java开发人员，这是非常有用的)，但它不仅限于构建基于Java的软件。
- Jenkins拥有大量的插件。这些插件极大的扩展了Jenkins的功能；它们都是开源的，而且它们可以直接通过web界面来进行安装与管理。



#### Jenkins的目标
Jenkins的主要目标是监控软件开发流程，快速显示问题。所以能保证开发人员以及相关人员省时省力提高开发效率。
CI系统在整个开发过程中的主要作用是控制：当系统在代码存储库中探测到修改时，它将运行构建的任务委托给构建过程本身。如果构建失败了，那么CI系统将通知相关人员，然后继续监视存储库。它的角色看起来是被动的；但它确能快速反映问题。
特别是它具有以下优点：
- Jenkins一切配置都可以在web界面上完成。有些配置如MAVEN_HOME和Email，只需要配置一次，所有的项目就都能用。当然也可以通过修改XML进行配置。
- 支持Maven的模块(Module)，Jenkins对Maven做了优化，因此它能自动识别Module，每个Module可以配置成一个job。相当灵活。
- 测试报告聚合，所有模块的测试报告都被聚合在一起，结果一目了然，使用其他CI，这几乎是件不可能完成的任务。
- 构件指纹(artifact fingerprint)，每次build的结果构件都被很好的自动管理，无需任何配置就可以方便的浏览下载。



#### Jenkins的主要特点
**容易安装**，只需要执行Java -jar jenkins.war， 或者直接部署到一个servlet container中，例如tomcat。不需要安装，不需要数据库的支持。
**容易配置**，jenkins可以完全地通过友好的web GUI来配置，且配置页面支持配置项的错误检查和很好的在线帮助。不需要手动地编辑xml的配置文件，但是jenkins也支持手动修改xml配置文件。
**项目源码修改的检测**，jenkins能够从项目的Subversion/CVS生成最近修改的集合列表，且改方式非常有效，不会增加Subversion/CVS Repository的负载。
**可读的永久的链接生成**，jenkins对于大部分pages都生成清楚的可读的永久的链接，例如''latest build"/"latest successful build",因此可以容易地在其他的地方引用jenkins的生成的pages。
**RSS/EMail/IM集成**，可以通过RSS，EMail或IM来实时地监视build的失败。
**Build完成后仍然可以tag**，支持在build完成后tag或重tag。
**Junit/TestNG 测试报告**，能够很好地显示各种测试的报告，且可以生成失败的趋向图。
**分布式build**，jenkins能够分发build/test的负载到多台机器，能够更好地利用硬件资源，提高build的时间。
**文件标识**，jenkins可以标识build产生的文件，例如jars。
**插件支持**，jenkins可以通过第三方的插件来扩展。
**跨平台**，支持几乎所有的平台，例如Windows,Ubuntu/Debian,Red Hat/Fedora/CentOS,Mac OS X,openSUSE,FreeBSD,OpenBSD,Solaris/OpenIndiana.Gentoo。



#### 安装Jenkins
在最简单的情况下，Jenkins 只需要两个步骤：
1. 下载最新的版本(一个 WAR 文件)。Jenkins官方网址: [http://Jenkins-ci.org/](http://jenkins-ci.org/)
2. 命运行运行 `java -jar jenkins.war` (默认情况下端口是8080，如果要使用其他端口启动，可以通过命令行`java –jar Jenkins.war --httpPort=80`的方式修改）
注意：Jenkins 需要运行 Java 5以及以上的版本。
还有一种安装方式就是将下载的war包文件部署到 servlet 容器，然后启动容器，在浏览器的URL地址栏中输入类似[http://localhost:8080/jenkins/](http://localhost:8088/hudson/)这样的地址即可。下图是安装成功后的界面（使用的是Linux+Tomcat6+Java6环境）：

![jenkinstart](../images/jenkinstart.jpg)



#### Jenkins配置
在配置前的一些话：Jenkins的配置不可能全部都说到的，大部分配置是有英文说明的，点击输入框后面的问号就可以看见了。英文不会用翻译工具，多测试几次就懂了。

##### 系统管理
在已运行的Jenkins主页中，点击左侧的系统管理进入如下界面：
![jenkinadmin](../images/jenkinadmin.png)

###### 提示信息
ps:版本不同提示的消息有可能不同

###### UTF-8编码
Your container doesn't use UTF-8 to decode URLs. If you use non-ASCII characters as a job name etc, this will cause problems. See [Containers](http://wiki.jenkins-ci.org/display/JENKINS/Containers) and [Tomcat i18n](http://wiki.jenkins-ci.org/display/JENKINS/Tomcat#Tomcat-i18n) for more details.
Jenkins建议在tomcat中使用utf-8编码，配置tomcat下conf目录的server.xml文件
![jenkinsutf8](../images/jenkinsutf8.png)

ps：如果Job的控制台中文输出乱码，请将URIEncoding=”utf-8”更改为useBodyEncodingForURI="true"

###### 新的版本
New version of Jenkins (1.518.JENKINS-14362-jzlib) is available for download (changelog).
提示有新的版本可以下载了,喜欢更新的点击download去下载吧！

###### 安全设置
![jenkinssecurity](../images/jenkinssecurity.png)
Jenkins允许网络上的任何人代表您启动进程。考虑至少启用身份验证来阻止滥用。点击Dismiss忽略该消息,点击Setup Security进入设置界面.详细设置请参考 Configure Global Security(安全设置) 章节

##### 系统设置
在已运行的Jenkins主页中，点击左侧的系统管理—>系统设置进入如下界面：
![jenkinssetting](../images/jenkinssetting.jpg)
ps：jenkins的根目录，默认地在C:\Documents and Settings\AAA\.hudson。



##### JDK、Maven、Ant配置(图为Windows环境)
配置一个JDK、Ant、Maven实例，请在每一节下面单击Add(新增) 按钮，这里将添加实例的名称和绝对地址。下图描述了这两个部分。
![jenkinsinstallother](../images/jenkinsinstallother.jpg)
点击“安装”，添加相应的设置，如下图：
![jenkinsinstallotherdetail](../images/jenkinsinstallotherdetail.jpg)
JDK别名：给你看的，随便你自己
JAVA_HOME：这个是本机JDK的安装路径（错误的路径会有红字提示你的）
注：Ant, Maven的配置是一样的(JDK去oracle官网下载，Ant与Maven去apache官网下载),**自动安装不推荐这个选项**
Ps：每个文本框后面都有个问号，点击问号就会出现帮助信息


##### 邮件通知配置(默认)
###### 配置发件人地址
![jenkinsemail](../images/jenkinsemail.jpg)系统管理员邮件地址（System Admin e-mail address）：Jenkins邮件发送地址，切记，必须设置。

###### 配置邮件通知
![jenkinsemailsetting](../images/jenkinsemailsetting.jpg)
设置：SMTP服务器，勾选"使用SMTP认证"，输入用户名与密码
ps：小技巧：用户默认邮件后缀配置了后，以后你填写邮件地址只需要@之前的就行了


##### Subversion配置
![jenkinssubversion](../images/jenkinssubversion.jpg)
Subversion Workspace Version：Subversion 的版本号，选择你对应的版本号就行了


##### Configure Global Security(安全设置)
在已运行的Jenkins主页中，点击左侧的系统管理—>Configure Global Security进入如下界面：
![jenkinsglobalconfig](../images/jenkinsglobalconfig.jpg)
设置如上图，保存后系统管理中就出现管理用户的选项。页面右上角也会出现登录/注册的选项。
此设置：只有登录用户可以做任何事


##### 管理用户设置
在右上角点击注册
![jenkinsuser](../images/jenkinsuser.png)
点击sign up按钮，提示你现在已经登录.返回首页.
登录后和匿名账号看到的首页有几点不同，如下图红框所示：
![jenkinsanno](../images/jenkinsanno.jpg)


##### 管理插件设置
建议先阅读[Jenkins插件](http://www.cnblogs.com/zz0412/p/jenkins02.html#_Jenkins%E6%8F%92%E4%BB%B6)章节，在回来安装如下所示的插件。
需求：这个插件将生成的构件（war或者ear）部署到主流的服务器上。
插件名称：[Deploy Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Deploy+Plugin)
插件介绍：This plugin takes a war/ear file and deploys that to a running remote application server at the end of a build



#### 项目构建设置
##### 构建自由风格的Job
###### 新建自由风格构建任务
在已运行的Jenkins主页中，点击左侧的新建Job进入如下界面：
![jenkinscreate](../images/jenkinscreate.png)
这时，需要为新的构建任务指定一个名称。（这里输入的任务名称为：Ant_test）这里有几种的任务类型可供选择，鉴于初步介绍，先选择构建一个自由风格的软件项目。对于其他的类型,经常使用的是拷贝已存在任务;这主要为了能在现有的任务基础上新建任务。点击OK按钮.
**需要注意的是**：
1.Job名称千万不要用中文名称（不作死就不会死）。
2.创建Job名称时最好有个规划，因为我们最后会通过正则匹配自动将Job归类，比如我喜欢 “项目前缀_一些说明-Job类型”这种方式。

##### 构建任务配置
###### 源码管理配置 
演示是使用Subversion的链接，在Repository URL中输入你的项目链接，如果没有权限则会提示如下图：
![jenkinsrepo](../images/jenkinsrepo.jpg)
设置成功后，就直接从SVN此目录获取文件到本地。Ps:要先添加Credentials。添加的方法如下操作：
点击Jenkins首页左侧Credentials，进入页面
![jenkinscre1](../images/jenkinscre1.jpg)
![jenkinscre2](../images/jenkinscre2.jpg)
下一步：一般都是使用的用户名和密码登陆的
![jenkinscre3](../images/jenkinscre3.jpg)
Ps：svn的用户名和密码设置了是没有办法在web界面修改的。如果要修改则先去Jenkins目录删除hudson.scm.SubversionSCM.xml文件



#### 构建触发器
在其他项目构建完成后才执行构建：指定的项目完成构建后，触发此项目的构建。
Poll SCM ：这是CI 系统中常见的选项。当您选择此选项，您可以指定一个定时作业表达式来定义Jenkins每隔多久检查一下您源代码仓库的变化。如果发现变化，就执行一次构建。例如，表达式中填写0,15,30,45 * * * *将使Jenkins每隔15分钟就检查一次您源码仓库的变化。
Build periodically ：此选项仅仅通知Jenkins按指定的频率对项目进行构建，而不管SCM是否有变化。如果想在这个Job中运行一些测试用例的话，它就很有帮助。
![jenkinsbuilder](../images/jenkinsbuilder.jpg)

##### Ant构建配置
因为我的项目是用ant脚本实现的编译和打包，所以我选择的是Invoke Ant，Ant Version选择你Ant配置的那个名字，注意不要选择default喔，那个选择了没有用。
![jenkinsant](../images/jenkinsant.jpg)
Ps：如果你的构建脚本build.xml不在workspace根目录、或者说你的构建脚本不叫build.xml。那么需要在高级里设置Build File选项的路径，指明你的脚本。注意：是相对路径

##### 构建Maven风格的Job(此块本人未弄)
###### 新建Maven构建任务
![jenkinsmaven](../images/jenkinsmaven.png)
这时，需要为新的构建任务指定一个名称。（这里输入的任务名称为：maven_test）这里有几种的任务类型可供选择，鉴于初步介绍，先选择构建一个maven2/3项目。对于其他的类型,经常使用的是拷贝已存在任务;这主要为了能在现有的任务基础上新建任务。点击OK按钮.

###### 构建任务配置
![jenkinsmaventask](../images/jenkinsmaventask.jpg)


###### 源码管理配置
演示是使用Subversion的链接，在Repository URL中输入你的项目链接，如果没有权限则会提示如下图：
![jenkinssourceadmin](../images/jenkinssourceadmin.png)

点击 enter credential 输入用户名和密码(我猜大家一般都是使用的用户名和密码登陆的)
![jenkinsrcsauth](../images/jenkinsrcsauth.png)

Ps：svn的用户名和密码设置了是没有办法在web界面修改的。如果要修改则先去Jenkins目录删除hudson.scm.SubversionSCM.xml文件（点到为止，毕竟这只是入门教程）

###### 构建触发器
在其他项目构建完成后才执行构建：指定的项目完成构建后，触发此项目的构建。
Poll SCM ：这是CI 系统中常见的选项。当您选择此选项，您可以指定一个定时作业表达式来定义Jenkins每隔多久检查一下您源代码仓库的变化。如果发现变化，就执行一次构建。例如，表达式中填写0,15,30,45 * * * *将使Jenkins每隔15分钟就检查一次您源码仓库的变化。
Build periodically ：此选项仅仅通知Jenkins按指定的频率对项目进行构建，而不管SCM是否有变化。如果想在这个Job中运行一些测试用例的话，它就很有帮助。

##### Maven构建设置
![jenkinsmavenbuilder](../images/jenkinsmavenbuilder.png)
2013-08-22补充Goals and options ：clean install  -Dmaven.test.skip=true　　#加入了跳过测试的代码
Root POM:填写你项目的pom.xml文件的位置，注意：是相对位置，如果该文件不存在，会有红色字提示。
部署请参考：[war文件部署](http://www.cnblogs.com/zz0412/p/jenkins02.html#_War%E6%96%87%E4%BB%B6%E9%83%A8%E7%BD%B2)章节

##### 构建maven项目的心得
使用Jenkins构建maven项目的一点小心得：
maven项目的构建是比较麻烦的，如果你的项目是下图这种结构。那么恭喜你！你新建一个job就可以了，因为只有一个根。如果你的svn地址是：https://192.xxx/Pe_Project/root-pom，那么Root POM只需要保持默认就行了，因为Jenkins可以再workspace目录下面找到pom.xml文件。如果你的svn地址是：https://192.xxx/Pe_Project，那么Root POM需要指定为root-pom/pom.xml，因为Jenkins可以再workspace/root-pom目录下面找到pom.xml文件
![jenkinsmaventhought](../images/jenkinsmaventhought.png)
上面这种方法打包的时候非常简单，但是用eclipse开发的时候你就不右键run as —>tomca启动了，如果你想使用这种方式，将tomcat换成jetty即可。如果你的项目是下图这种结构，那么非常悲剧的告诉你，你要建立好几个job来构建这一个项目，因为这个项目有4个根。
![jenkinsmavenc](../images/jenkinsmavenc.png)
上面这种方法打包的时候比较麻烦，但是用eclipse开发的时候你就可以使用右键run as —>tomca启动了



##### 邮件通知设置
![jenkinsmailsetting](../images/jenkinsmailsetting.png)
选择Add post-build action，然后选择E-mail Notification，如下图：
![jenkinsemailadd](../images/jenkinsemailadd.png)
在Recipients中输入收件人邮件地址，如果用多个收件人用“,”英文逗号隔开

##### War文件部署设置
首先你必须安装好[Deploy Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Deploy+Plugin)插件，然后在tomcat的conf目录配置tomcat-users.xml文件，在<tomcat-users>节点里添加如下内容：
```xml
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="username" password="password" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
```
引号里的username和password可以随便替换，待会要用的。好了，回到Jenkins项目配置页面：
![jenkinsaftersetting](../images/jenkinsaftersetting.png)
选择Add post-build action，然后选择Deploy war/ear to a container，如下图：
![jenkinswar](../images/jenkinswar.png)
WAR/EAR files：war文件的存放位置，如：target/test.war 注意：相对路径，target前是没有/的;
Context path：访问时需要输入的内容，如ofCard访问时如下：http://192.168.x.x:8080/ofCard/如果为空，默认是war包的名字;
Container：选择你的web容器，如tomca 6.x;
Manager user name：填入tomcat-users.xml配置的username内容;
Manager password：填入tomcat-users.xml配置的password内容;
Tomcat URL：填入http://192.168.x.x:8080/ ;
Deploy on failure：构建失败依然部署，一般不选择。
注意：虽然这种部署方法可能会导致tomcat加载时出现卡死的现象。但是也是最简单的部署方式。如果卡死了重启下就好了，将tomcat的java内存参数调高可以解决这个问题。最后不要忘记点击保存喔。好了！到此一个项目的获取源码，打包，远程部署，邮件通知就完成了。



#### 监控
当任务一旦运行，您将会看到这个任务正在队列中的仪表板和当前工作主页上运行。这两种显示如下。
![jenkinsbuildrunning](../images/jenkinsbuildrunning.jpg)
![jenkinsbuildhistory](../images/jenkinsbuildhistory.jpg)
一旦构建完成后，完成后的任务将会有三个地方进行显示。你可以在Jenkins的控制面板上看到它，如下图。
![jenkinsbuildresult](../images/jenkinsbuildresult.jpg)
在上面展示的截图中，您将注意到有两个图标描述当前作业的状态。S栏目代表着“最新构建状态”，W栏目代表着“构建稳定性”。Jenkins使用这两个概念来介绍一个作业的总体状况：
构建状态:下图中分级符号概述了一个Job新近一次构建会产生的四种可能的状态： 

- **Successful**:完成构建，且被认为是稳定的。
- **Unstable**:完成构建，但被认为不稳定。
- **Failed**:构建失败。
- **Disabled**:构建已禁用。

![jenkinsbuildstatus](../images/jenkinsbuildstatus.jpg)
构建稳定性: 当一个Job中构建已完成并生成了一个未发布的目标构件，如果您准备评估此次构建的稳定性，Jenkins会基于一些后处理器任务为构建发布一个稳健指数 (从0-100 )，这些任务一般以插件的方式实现。它们可能包括单元测试(JUnit)、覆盖率(Cobertura )和静态代码分析(FindBugs)。分数越高，表明构建越稳定。下图中分级符号概述了稳定性的评分范围。任何构建作业的状态(总分100)低于80分就是不稳定的。
![jenkinsstatusscore](../images/jenkinsstatusscore.jpg)

你也可以在当前Job主界面上看到它，如下图左下部分
![jenkinsjobdashtable](../images/jenkinsjobdashtable.jpg)

当前作业主页上还包含了一些有趣的条目。左侧栏的链接主要控制Job的配置、删除作业、构建作业。右边部分的链接指向最新的项目报告和构件。通过点击构建历史（Build History）中某个具体的构建链接，您就能跳转到Jenkins为这个构建实例而创建的构建主页上。如下图
![jenkinsbuildno](../images/jenkinsbuildno.jpg)

如果你想通过视图输出界面来监控当前任务的进展情况。你可以单击Console Output（控制台输出）。如果工作已完成，这将显示构建脚本产生的静态输出；如果作业仍然在运行中，Jenkins将不断刷新网页的内容，以便您可以看到它运行时的输出。如下图：
![jenkinsconsole](../images/jenkinsconsole.jpg)

上述是Jenkins的状态和说明, 我们在比较传统的项目之中, 需要打包之后自己安装, 然后运行, 这时候, 我们需要进入主面板, 然后选择则Daily构建, 选择好我们构建的版本比如XXX_V30_SP1, 点击进入, 然后选择Build With Parameters, 然后选择好要构建的Branch, 点击开始构建即可. 经过一定的时间, 就会有构建结果, 然后在面板上可以找到构建的状态和历史, 返回最初的主页面板, 选择需要使用的平台, 然后点进去, 按照构建的版本号, 就可以下载我们打包的文件了. 然后就可以开始安装和调试. 如果失败的话, 我们就可以在日志之中查看失败的原因。



#### Jenkins插件
从Jenkins现有的功能扩展或开发者们为Jenkins提供的新功能都可以称之为Jenkins插件。有些插件可以无缝添加到您的构建过程，而其它，诸如除CVS和Subversion的SCM插件则需要源代码控制系统的支持。
##### Jenkins插件安装
Jenkins 插件管理器允许您安装新的插件，和更新您Jenkins服务器上的插件。管理者将连接到联机资料库，检索可用的和已更新的插件。如果您的Jenkins服务器 无法直接连接到外部资源，您可以从Jenkins网站上下载。在已运行的Jenkins主页中，点击左侧的系统管理—>管理插件进入如下界面：
![jenkinsplugin](../images/jenkinsplugin.jpg)
它包含四个标签：
**更新**: 清单中列示了Jenkins为某些插件搜索到了可用的更新。列出的每个插件可以被选择并应用更新。
**可选安装**: 清单中列示了可用于安装（而不是目前已安装的）的所有插件。列出的每个插件都可以被选择并安装。
**已安装**: 清单中列示了已经安装的插件。
**高级**: 允许您通过设定HTTP代理的方式使Jenkins与在线插件库建立连接。此外，还提供了一个上传设备，可以安装你在Jenkins以外已下载的那些插件。
由上图可知，Jenkins缺省集成了maven2插件，并且一旦插件有新版本，会提示更新新版本插件。如果想安装新的插件，可以点击tab分页中的可选插件。如下图：
![jenkinsaddplugin](../images/jenkinsaddplugin.jpg)

从图可知，各种Jenkins插件根据之前所记述的类型进行分门别类。可勾选任意想安装的Jenkins插件，点击Install without restart按钮进行安装。安装后，所有插件以hpi作为后缀名放置在plugins文件夹下。如果是高级用户还可以自行开发插件方便具体项目使用。
注意：安装完成后需要重启Jenkins部署的容器。这样才能使用新装的插件。

##### Jenkins插件安装示例
Jenkins运行自动部署war包到servlet容器内，要实现这个功能必须安装一个插件。
![jenkinsavaliableplugin](../images/jenkinsavaliableplugin.png)
![jenkinspluginupandinstall](../images/jenkinspluginupandinstall.png)
好了，到此[Deploy Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Deploy+Plugin)插件安装完成！



ref:
1.[Jenkins学习一：Jenkins是什么？](https://www.cnblogs.com/yangxia-test/p/4354213.html),   2.[Jenkins学习二：Jenkins安装与配置](https://www.cnblogs.com/yangxia-test/p/4354328.html),   3.[使用Jenkins实现自动化打包](https://blog.csdn.net/charon_chui/article/details/80510701)

