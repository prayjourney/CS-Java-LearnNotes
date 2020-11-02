### Maven了解一下

***

#### Eclipse 创建 Maven 工程
1.File-->New--->Maven Project
2.勾上 Create a simple project ,然后点击 next
3.填写 Group Id 和 Artifact Id
>**groupid和artifactId被统称为“坐标”是为了保证项目唯一性而提出的**，如果你要把你项目弄到maven本地仓库去，你想要找到你的项目就必须根据这两个id去查找。
>groupId一般分为多个段，这里只说两段，第一段为域，第二段为公司名称。域又分为org、com、cn等等许多，其中org为非营利组织，com为商业组织。举个apache公司的tomcat项目例子：这个项目的groupId是org.apache，它的域是org（因为tomcat是非营利项目），公司名称是apache，artigactId是tomcat。
>ArtifactID就是项目的唯一的标识符，实际对应项目的名称，就是项目根目录的名称。比如我创建一个项目，我一般会将groupId设置为com.ys，com表示域，ys是我个人姓名缩写，**Artifact Id**设置为hellomaven，表示你这个项目的名称是hellomaven，依照这个设置，你的包结构最好是com.ys.hellomaven打头的，如果有个StudentDao，它的全路径就是com.ys.hellomaven.dao.StudentDao

![img](../../../images/maven1.png)



#### Maven Java工程的目录结构 
1.我们根据上面的步骤，创建出如下的 maven 工程：
![img](../../../images/maven2.png)
对每个目录结构的解析如下：
![img](../../../images/maven3.png)
2.为什么 maven 工程的目录结构要这样呢？
- Maven 要负责项目的自动化构建，以编译为例，Maven 要想自动进行编译，那么它必须知道 Java 的源文件保存在哪里，这样约定之后，不用我们手动指定位置，Maven 能知道位置，从而帮我们完成自动编译。
- 遵循 约定>>>配置>>>编码。即能进行配置的不要去编码指定，能事先约定规则的不要去进行配置。这样既减轻了劳动力，也能防止出错。
- pom.xml 文件
**Project Object Model 项目对象模型**，Maven 的核心配置文件，pom.xml，与构建过程相关的一切设置都在这个文件中进　　



#### Maven 的常用命令
>①、在 src/main/java 新建包 com.ys.maven,然后在这个包中创建类 HelloMaven.java
>②、在 src/test/java 新建包 com.ys.maven,然后在这个包中创建类 HelloTest.java
>③、pom.xml 文件如上图所示　

**下面使用maven 命令来操作**，此处是在eclipse之中，在命令行之中，需要到工程文件夹下，操作，使用的命令是一致的。**最后标注命令行**。

1.**compile**:将Java 源程序编译成 class 字节码文件。**mvn compile**
第一步：选择 pom.xml 文件，右键--->Run As ---->2 Maven build...
![img](../../../images/maven4.png)
第二步：在第一步执行完后弹出来的对话框中，输入 compile，然后点击 Run 按钮
![img](../../../images/maven5.png)
第三步：查看控制台
![img](../../../images/maven6.png)
第四步：在 target 目录下，我们会发现编译生成的 class 文件

2.**test:测试，并生成测试报告**。**mvn test**
第一步：选择 pom.xml 文件，右键--->Run As ---->2 Maven build...,然后在弹出框中输入 test； 或者选择 pom.xml 文件，右键--->Run As------>6 Maven test，如下图
第二步：查看控制台
分析测试程序，我们传入的参数是Tom，而我们希望的是maven，很显然是不相等的，那么测试失败
![img](../../../images/maven7.png)
如果测试类 HelloTest.java改为如下：重新执行 mvn test 命令，控制台如下：
![img](../../../images/maven8.png)
生成的测试报告可以在如下目录查看：target/surefire-reports
![img](../../../images/maven9.png)
3.**mvn clean 将以前编译得到的旧的 class 字节码文件删除** **mvn test**
第一步：选择 pom.xml 文件，右键--->Run As ---->2 Maven build...,然后在弹出框中输入 clear；或者选择 pom.xml 文件，右键--->Run As------>3 Maven clear，如下图
第二步：查看控制台
![img](../../../images/maven10.png)
第三步：发现 mvn compile 编译好的文件这时已经清除了
4.**mvn pakage 打包,动态 web工程打 war包，Java工程打 jar 包。** **mvn package**
第一步：选择 pom.xml 文件，右键--->Run As ---->2 Maven build...,然后在弹出框中输入 package
![img](../../../images/maven11.png)
第二步：查看控制台
![img](../../../images/maven12.png)
第三步：进入到 target 目录，会发现打出来的 jar 包
![img](../../../images/maven13.png)
5.**mvn install 将项目生成 jar 包放在仓库中，以便别的模块调用**。 **mvn install**
这里我们就不截图了，执行命令后，进入到 settings.xml 文件中配置的仓库，你会发现生成的 jar 包
![img](../../../images/maven14.png)



#### Maven坐标

**数学中的坐标**
在平面上，使用 X 、Y 两个向量可以唯一的定位平面中的任何一个点，在空间中，使用 X、Y、Z 三个向量可以唯一的定位空间中的任意一个点
**Maven 中的坐标**
俗称 **gav**：使用下面三个向量子仓库中唯一定位一个 Maven 工程。在项目中的 pom.xml 文件中，我们可以看到下面gav的定义：
```xml
　1、groupid:公司或组织域名倒序 
　　　<groupid>com.ys.maven</groupid>
　2、artifactid:模块名，也是实际项目的名称
　　　<artifactid>Maven_05</artifactid>
　3、version:当前项目的版本
　　 <version>0.0.1-SNAPSHOT</version>
```
![img](../../../images/maven15.png)

**Maven 坐标和仓库，jar 包的关系**
现在只需要知道是Maven 用来存放 jar 包的地方。那么依照上面定义的 gav，我们执行 mvn -install 命令，会出现什么情况呢？
查看maven `settings.xml `文件配置的仓库目录。将我们上面配置的 gav 向量组合起来就是目录：
`com/ys/maven/Maven_05/0.0.1-SNAPSHOT/Maven_05-0.0.1-SNAPSHOT.jar`
![img](../../../images/maven16.png)
其次，我们观察打出来的 jar 包：Maven_05-0.0.1-SNAPSHOT.jar，也就是 artifactid-version.jar，就是说通过执行**mvn install**命令，**我们将我们的工程打包成了一个可用的jar(war)文件，相当于编译过，可以供别的程序调用，并且，其被放置在了我们本地的依赖库之中**。



#### 依赖和配置

**什么是依赖？ **
什么是 依赖？每当我们需要使用某个框架时，比如 SpringMVC，那么我们需要导入相应的 jar 包，但是手动导入包的时候，往往会漏掉几个 jar 包，那么在使用该框架的时候系统就会报错。那么我们就说导入的包与未导入的包存在依赖关系。而使用 Maven,我们只需要在 pom.xml 文件中进行相应的配置，它就会帮助我们自动管理 jar 包之间的依赖关系。那么它是怎么管理的呢，接下来我们讲解。

**依赖的详细配置**
我们以 Junit 为例，在 pom.xml 文件中进行详细而完整的配置。　
>①、dependencies：一个 pom.xml 文件中只能存在一个这样的标签。用来管理依赖的总标签。
>②、dependency:包含在dependencies标签中，可以有无数个，每一个表示一个依赖
>③、groupId,artifactId和version：依赖的基本坐标，对于任何一个依赖来说，基本坐标是最重要的，Maven根据坐标才能找到需要的依赖。
>④、type：依赖的类型，对应于项目坐标定义的packaging。大部分情况下，该元素不必声明，其默认值是jar。
>⑤、scope：依赖的范围，默认值是 compile。后面会进行详解。
>⑥、optional：标记依赖是否可选。
>⑦、exclusions：用来排除传递性依赖，后面会进行详细介绍。



#### 依赖的范围 scope 

##### 依赖的范围种类

![img](../../../images/maven17.png)
一般情况下，我们对前面三个依赖用的比较多。下面的主程序表示maven 目录结构 src/main/java.测试程序目录结构为：src/test/java

**1、compile 范围依赖**
- 对主程序是否有效：有效
- 对测试程序是否有效：有效
- 是否参与打包：参与
- 是否参与部署：参与
- 典型例子：log4j

**2、test 范围依赖**
- 对主程序是否有效：无效
- 对测试程序是否有效：有效
- 是否参与打包：不参与
- 是否参与部署：不参与
- 典型例子：Junit

**3、provided 范围依赖**
- 对主程序是否有效：有效
- 对测试程序是否有效：有效
- 是否参与打包：不参与
- 是否参与部署：不参与
- 典型例子：servlet-api.jar，一般在发布到 服务器中，比如 tomcat，服务器会自带 servlet-api.jar 包，所以provided 范围依赖只在编译测试有效。

**4、runtime 范围依赖**：在测试、运行的时候依赖，在编译的时候不依赖。例如：JDBC驱动，项目代码只需要jdk提供的jdbc接口，只有在执行测试和运行项目的时候才需要实现jdbc的功能。

##### 依赖之间的区别

**test 依赖和 compile 依赖的区别：**

①、首先我们在 pom.xml 文件中配置，Junit 的 test 依赖
![img](../../../images/maven18.png)

②、我们在主程序中去导入 Junit 的包，然后进行 mvn -compile 编译，很明显，test 范围的在主程序中无效，故编译会报错。
我们在 src/main/java 包下新建 MavenTest.java,并导入 Junit 包
![img](../../../images/maven19.png)
然后执行 mvn -compile 操作，如下图报错信息：
![img](../../../images/maven20.png)

③、我们将 Junit 的依赖范围改为 compile，然后执行 mvn -compile
![img](../../../images/maven21.png)
发现 mvn -compile 没有报错了。
![img](../../../images/maven22.png)



#### 依赖的传递和排除
##### 依赖传递
比如我们创建三个Maven 工程，maven-first,maven-second以及maven-third,而third依赖于second，second又依赖于first，那么我们说 second 是 third 的第一直接依赖，first是second的第二直接依赖。而first是third的间接依赖。
![img](../../../images/maven23.png)
依赖之间的传递如下图：**第一列表示第一直接依赖，第一行表示第二直接依赖**
![img](../../../images/maven24.png)

**总结：**
我们这里举个例子来看：
①、第二依赖范围是 test
Maven_first 的pom.xml 文件如下：
![img](../../../images/maven25.png)
然后Maven_second依赖Maven_fisrt,Maven_third依赖Maven-second,其pom.xml 文件如下：
Maven_second的 pom.xml
![img](../../../images/maven26.png)
Maven_third的 pom.xml
![img](../../../images/maven27.png)

我们发现在 Maven_third和 Maven_second 都没有 Maven_first 引入的 Junit 包，正好符合上面总结的第二点：当第二直接依赖的范围是test的时候，依赖不会得以传递。
![img](../../../images/maven28.png)

②、第二依赖范围是 compile
如果我们将 Maven_first 的Junit 改为 compile，那么将会符合上面总结的第一点：当第二依赖的范围是compile的时候，传递性依赖的范围与第一直接依赖的范围一致。

![img](../../../images/maven29.png)

##### 依赖排除

如果我们在当前工程中引入了一个依赖是 A，而 A 又依赖了 B，那么 Maven 会自动将 A 依赖的 B 引入当前工程，但是个别情况下 B 有可能是一个不稳定版，或对当前工程有不良影响。这时我们可以在引入 A 的时候将 B 排除。比如：我们在Maven_first 中添加 spring-core,maven 会自动将 commons-logging添加进来，那么由于 Maven_second 是依赖 Maven_first  的，那么 Maven_second  中将存在 spring-core(自带了commons-logging)，这时候我们不想要 commons-logging，那该怎么办呢？我们上面第二大点提到了：
Maven_first 的 pom.xml 文件
![img](../../../images/maven30.png)
由于 Maven_second 依赖 Maven_second，故Maven_second 存在 spring-core 包
![img](../../../images/maven31.png)
如何排除呢？我们在 Maven_second 的 pom.xml 文件中添加如下代码：

![img](../../../images/maven32.png)
再次查看工程：Maven_second 的 commons-logging 已经移除了
![img](../../../images/maven33.png)



#### 依赖的冲突
在maven中存在两种冲突方式：一种是跨pom文件的冲突，一致是同一个pom文件中的冲突。
1.**跨 pom 文件，路径最短者优先**
比如我们在 Maven_first 中的 Junit 是4.9版本的，Maven_second 中的 Junit 是4.8版本的，那么Maven_third 中的 Junit 将会是那个版本呢？
![img](../../../images/maven34.png)
由上图我们可以看出，由于 Maven_second 是 Maven_third 的直接依赖，明显相比于 Maven_first 路径要短，所以 Maven_third 的 Junit 版本与 Maven_second 保持一致。
2.**同一个pom.xml 文件，先申明者优先**
![img](../../../images/maven35.png)
**看 Maven_second**
![img](../../../images/maven36.png)



#### 可选依赖

Optional标签标示该依赖是否可选，默认是false。可以理解为，如果为true，则表示该依赖不会传递下去，如果为false，则会传递下去。
![img](../../../images/maven37.png)
我们是在 Maven_second 的 pom 文件中设定 Junit 不可传递，那么Maven_third 工程中将不会有来自 Maven_second 的 Junit 的传递。

#### Maven的生命周期
##### 什么是 生命周期？
Maven 强大的原因是有一个十分完善的生命周期，生命周期可以理解为项目构建步骤的集合，它定义了各个构建环节的执行顺序，有了这个顺序，Maven 就可以自动化的执行构建命令。Maven 的核心程序中定义了抽象的生命周期，生命周期中各个阶段的具体任务是由插件来完成的。有三套相互独立的生命周期，各个构建环节执行顺序不能打乱，必须按照既定的正确顺序来执行。

**①、Clean Lifecycle:在进行真正的构建之前进行一些清理工作**
**②、Default Lifecycle：构建的核心部分，编译、测试、打包、安装、部署等等。**
**③、Site Lifecycle：生成项目报告，站点，发布站点。**

这三个都是相互独立的。你可以仅仅调用 clean 来清理工作目录，仅仅调用 site 来生成站点。当然，也可以直接运行 **mvn clean install site **运行所有这三套生命周期。下面我们分别来谈谈这三个生命周期。

##### Clean Lifecycle:在进行真正的构建之前进行一些清理工作

我们前面讲的执行命令 mvn -clean,也就等同于 Clean 生命周期中的第一个阶段 mvn pre-clean clean。注意有 Clean 声明周期，而这个声明周期中又有 clean 阶段。
**只要执行后面的命令，那么前面的命令都会执行，不需要再重新去输入命令。**

##### Default Lifecycle：构建的核心部分，编译、测试、打包、安装、部署等等

```xml
validate 
generate-sources 
process-sources 
generate-resources 
process-resources 复制并处理资源文件，至目标目录，准备打包。 
compile 编译项目的源代码。 
process-classes 
generate-test-sources 
process-test-sources 
generate-test-resources 
process-test-resources 复制并处理资源文件，至目标测试目录。 
test-compile 编译测试源代码。 
process-test-classes 
test 使用合适的单元测试框架运行测试。这些测试代码不会被打包或部署。 
prepare-package 
package 接受编译好的代码，打包成可发布的格式，如 JAR 。 
pre-integration-test 
integration-test 
post-integration-test 
verify 
install 将包安装至本地仓库，以让其它项目依赖。 
deploy 将最终的包复制到远程的仓库，以让其它开发人员与项目共享。
```
这里我们强调一下：**在maven中，只要在同一个生命周期，你执行后面的阶段，那么前面的阶段也会被执行，而且不需要额外去输入前面的阶段。**我们举个例子：执行 mven compile 命令，根据上面的声明周期，它会默认执行前面五个个步骤也就是

```xml
validate
generate-sources
process-sources
generate-resources
process-resources 复制并处理资源文件，至目标目录，准备打包。
compile 编译项目的源代码。
```
我们在 eclipse 中执行 mvn compile 命令
![img](../../../images/maven38.png)

看到红色框的两部分，第一个 maven-compiler-plugin:2.6:resource 就是用来执行前面几个步骤的插件，第二个插件 maven-compiler-plugin:3.1:compile 则是用来执行 mvn compile 的插件。这里我们提一下，mvn 的各个生命周期步骤都是依赖插件来完成的，后面我们会详细讲解 maven 插件。**这恰好说明maven 的各个生命周期是由其不同的插件支持的！**

##### Site Lifecycle：生成项目报告，站点，发布站点
这里经常用到的是 site 阶段和 site-deploy 阶段，用来生成和发布 maven 站点，这是 Maven 比较强大的功能，文档及统计数据自动生成。由于现在的系统会有专门工具来生成文档或报表。所以这个功能也是比较鸡肋吧，不够简洁和美观，用的不太多。



#### 继承
**需求场景：**
有三个 Maven 工程，每个工程都依赖某个 jar 包，比如 Junit，由于 test 范围的依赖不能传递，它必然会分散在每个工程中，而且每个工程的jar 包版本可能不一致。那么如何管理各个工程中对于某个 jar 包的版本呢？
**解决办法：**
将那个 jar 包版本统一提取到 “父" 工程中，在子工程中声明依赖时不指定版本，以父工程中统一设定的为准，同时也便于修改。
**操作步骤：**
①、创建父工程
![img](../../../images/maven39.png)
②、在子工程中声明对父工程的引用
③、将子工程的坐标中与父工程坐标重复的内容删除（不删除也可以，为了简洁）
![img](../../../images/maven40.png)
④、在父工程中统一那个 jar 的版本依赖
**dependencyManagement标签管理的依赖，其实没有真正依赖，它只是管理依赖的版本。**
⑤、在子工程中删除 Junit 的版本号
![img](../../../images/maven41.png)
**以后要更改版本号，我们只需要更改父工程中的版本号即可！！！**
⑥、父工程通过 properties 统一管理版本号
![img](../../../images/maven42.png)
我们可以通过\<properties>\</properties>自定义标签，然后在标签里面填写常量，这种方法不仅可以用来管理版本号，还可以用来管理比如设置某种编码等等。

 

####  聚合
**需求场景：**
在真实项目中，一个项目有表现层、业务层、持久层等。我们在用Maven 管理项目的时候，通常为创建多个 Maven 工程，也就是一个项目的多个模块。但是这样分成多个模块了，当我们进行项目打包发布的时候，那么要每一个模块都执行打包操作吗？这种重复的操作我们怎么才能避免呢？
**解决办法：**
创建一个聚合工程，将其他的各个模块都由这个聚合工程来管理，那么我们在进行项目发布的时候，只需要打包这个聚合工程就可以了。
**①、创建聚合工程（注意聚合工程的打包方式也必须为 pom，通常由 上面所讲的父工程来充当聚合工程）**
![img](../../../images/maven43.png)
**②、创建子工程：业务层**
  - 选择 Maven Module
![img](../../../images/maven44.png)
  - 填写子工程模块名，打包方式选择 jar（子工程除了 web 层我们打包方式选择 war ，其余的都选择 jar）
![img](../../../images/maven45.png)

**③、创建子工程：表现层和持久层**
**创建步骤和前面一样，注意表现层打包方式我们要选择 war，因为要发布到 tomcat 容器运行。**
**④、在聚合工程中添加子工程的引用**

注意：
- 这里虽然各个模块有依赖关系，但是\<module>\</module>可以不让依赖顺序添加，maven会自动识别依赖关系进行编译打包。
- 这里总的聚合工程随便哪个工程都可以，但是通常用 Parent 工程来完成。



#### Maven命令

##### Maven 命令参数
```
-D 传入属性参数 
-P 使用pom中指定的配置 
-e 显示maven运行出错的信息 
-o 离线执行命令,即不去远程仓库更新包 
-X 显示maven允许的debug信息 
-U 强制去远程参考更新snapshot包
```
例如 mvn install -Dmaven.test.skip=true -Poracle 其他参数可以通过mvn help 获取

##### Maven常用命令

**1. 创建Maven的普通Java项目：**
```xml
mvn archetype:create
    -DgroupId=packageName
    -DartifactId=projectName
```

**2. 创建Maven的Web项目：**
```xml
mvn archetype:create
    -DgroupId=packageName
    -DartifactId=webappName
    -DarchetypeArtifactId=maven-archetype-webapp
```

**3. 反向生成 maven 项目的骨架：**
```xml
mvn archetype:generate
```

你是怎么创建你的maven项目的?是不是像这样:
```xml
mvn archetype:create -DarchetypeArtifactId=maven-archetype-quickstart -DgroupId=com.ryanote -Dartifact=common
```

如果你还再用的话,那你就out了,现代人都用mvn archetype:generate了,它将创建项目这件枯燥的事更加人性化,你再也不需要记那么多的archetypeArtifactId,你只需输入archetype:generate,剩下的就是做”选择题”了。命令行步骤：

![img](../../../images/maven46.png)

缩写写法：
```xml
mvn archetype:generate -DgroupId=otowa.user.dao -DartifactId=user-dao -Dversion=0.01-SNAPSHOT
```

**4. 编译源代码：**
```xml
mvn compile
```

**5. 编译测试代码：**
```xml
mvn test-compile
```

**6. 运行测试:**
```xml
mvn test
```

**7. 产生site：**
```xml
mvn site
```

**8. 打包：**
```xml
mvn package
```

**9. 在本地Repository中安装jar：**
```xml
mvn install
例：installing D:\xxx\xx.jar to D:\xx\xxxx
```

**10. 清除产生的项目：**
```xml
mvn clean
```

**11. 生成eclipse项目：**
```xml
mvn eclipse:eclipse
```

**12. 生成idea项目：**
```xml
mvn idea:idea
```

**13. 组合使用goal命令，如只打包不测试：**
```xml
mvn -Dtest package
```

**14. 编译测试的内容：**
```xml
mvn test-compile
```

**15. 只打jar包:**
```xml
mvn jar:jar
```

**16. 只测试而不编译，也不测试编译：**
```xml
mvn test -skipping compile -skipping test-compile
 ( -skipping 的灵活运用，当然也可以用于其他组合命令) 
```

**17. 清除eclipse的一些系统设置:**
```xml
mvn eclipse:clean 
```

**18.查看当前项目已被解析的依赖：**
```xml
mvn dependency:list
```

**19.上传到私服：**
```xml
mvn deploy
```

**20. 强制检查更新，由于快照版本的更新策略(一天更新几次、隔段时间更新一次)存在，如果想强制更新就会用到此命令:** 
```xml
mvn clean install-U
```

**21. 源码打包：**

```xml
mvn source:jar
或
mvn source:jar-no-fork
```

##### mvn compile与mvn install、mvn deploy的区别
1.mvn compile，编译类文件
2.mvn install，包含mvn compile，mvn package，然后上传到本地仓库
3.mvn deploy,包含mvn install,然后，上传到私服



#### Maven插件
##### maven-eclipse-plugin插件

1.mvn eclipse:eclipse 
说明: 生成eclipse配置文件,导入到eclipse开放,如果是使用m2eclipse插件,则可以不用次命令.直接使用插件导入到eclipse进行开放。注:通过次命令生产的项目,需要在eclipse中配置M2_HOME的命令,指向你的本地仓库文件夹。
![img](../../../images/maven47.png)
来看看生成的结果：classpath就是字节码
![img](../../../images/maven48.png)

2.mvn eclipse:m2eclipse 
生成eclipse配置文件,该配置文件需依赖eclipse 中有m2eclipse 
-DdownloadSources=true 下载依赖包的源码文件 
-Declipse.addVersionToProjectName=true 添加版本信息到项目名称中 

3.mvn eclipse:clean 
清除eclipse的项目文件
![img](../../../images/maven49.png)
看看文件内容，没有project文件 了
![img](../../../images/maven50.png)

##### maven-jetty-plugin插件

1.mvn jetty:run 
说明: 可以直接用jetty的服务器运行 注:此命令只适用于war的模块,即web模块. 
2.mvn archetype:generate 
说明: 模块创建命令, 执行命令后，会提示选择创建项目的模版，这里选18(maven-archetype-quickstart) 
后面会提示你输入groupId(包存放的路径): 
eg:com.lin

提示输入artifactId(模块名称)：

eg:test-core 
提示输入version(版本): 
1.0.0-SNAPSHOT 
提示输入package(指项目中基本的包路径): 
eg:com.lin
提示确认,回车即可

##### maven-release-plugin插件

说明: 发行版本,可与scm工具集成,来提供版本管理.不等同与版本控制.允许是必须有goal.两个常用的goal如下: 
1.mvn release:clean 
清理release操作是遗留下来的文件
![img](../../../images/maven51.png)

2.mvn release:branch 
说明: 创建分支,会在分支下创建执行的分支路径 
-DbranchName=xxxx-100317 分支中的名称 
-DupdateBranchVersions=false 是否更新分支的版本信息,默认为false 
-DupdateWorkingCopyVersions=false 是否更新主干的版本信息,默认为true 

3.mvn release:prepare 
创建标记,会有交互过程,提示tag中pom的版本及trunk下的新版本号,每个模块都会询问,默认是最小版本号+1 
-Dtag = 4.4.0 将在tags创建该名称文件夹 
-DdryRun=true 检查各项设置是否正确,可做测试用,会产生一些修改的配置文件信息. 
命令: 
```xml
mvn release:perform 
```
次命令会自动帮我们签出刚才打的tag，然后打包，分发到远程Maven仓库中 



ref:

1.[Maven详解（三）------ Maven工程目录介绍](https://www.cnblogs.com/ysocean/p/7420373.html),   2.[Maven详解（四）------ 常用的Maven命令](https://www.cnblogs.com/ysocean/p/7416307.html),   3.[Maven详解（五）------ 坐标的概念以及依赖管理](https://www.cnblogs.com/ysocean/p/7451054.html),   4.[Maven详解（六）------ 生命周期](https://www.cnblogs.com/ysocean/p/7456179.html),   5.[Maven详解（七）------ 创建Web工程以及插件原理](https://www.cnblogs.com/ysocean/p/7460617.html),   6.[Maven详解（八）------ 继承和聚合](https://www.cnblogs.com/ysocean/p/7460616.html),   7.[Maven学习(十五)-----Maven常用命令](https://www.cnblogs.com/zy-jiayou/p/7661415.html),   8.[Maven学习(十四)-----Maven 构建配置文件](https://www.cnblogs.com/zy-jiayou/p/7661293.html),   9.[Maven常用命令](https://www.cnblogs.com/wkrbky/p/6352188.html),   10.[maven3常用命令、java项目搭建、web项目搭建详细图解](https://blog.csdn.net/edward0830ly/article/details/8748986)
