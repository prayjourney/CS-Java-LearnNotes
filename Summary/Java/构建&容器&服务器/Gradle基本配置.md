#### Gradle配置文件

**1.gradle.properties:** 从它的名字可以看出，这个文件中定义了一系列“属性”。实际上，这个文件中定义了一系列供build.gradle使用的常量，比如keystore的存储路径、keyalias等等。

**2.gradlew与gradlew.bat:** gradlew为Linux下的shell脚本，gradlew.bat是Windows下的批处理文件。 gradlew是gradle wrapper的缩写，也就是说它对gradle的命令进行了包装，比如我们进入到指定Module目录并执行“gradlew.bat assemble”即可完成对当前Module的构建（Windows系统下）。

**3.local.properties:** 从名字就可以看出来，这个文件中定义了一些本地属性，比如SDK的路径。

**4.settings.gradle:** 假如我们的项目包含了不只一个Module时，我们想要一次性构建所有Module以完成整个项目的构建，这时我们需要用到这个文件。比如我们的项目包含了ModuleA和ModuleB这两个模块，则这个文件中会包含这样的语句：include ':ModuleA', ':ModuleB'。

**5.build.gradle:** 它指定了整个项目的构建规则.

**6.gradle-wrapper：**Wrapper是对Gradle的一层包装，便于在团队开发过程中统一Gradle构建的版本号，这样大家都可以使用统一的Gradle版本进行构建。gradle-wrapper.properties文件中，我们其实最关心的应该是distributionUrl这个属性，他是下载Gradle的路径，

![img](C:/Users/Administrator/AppData/Local/YNote/data/prayjourney@yeah.net/f1129a3540c04389ba0e9fd6dfcfbe4c/clipboard.png)

它下载的东西会出现.gradle>wrapper>dists之中，是各个版本的gradle，然后我们下载的lib，都是在这个里面，结构如dists>gradle-4.10.2-all>divx0s2uj4thofgytb7gf9fsi或者dists>gradle-4.10.2-bin>divx0s2uj4thofgytb7gf9fsi

![img](C:/Users/Administrator/AppData/Local/YNote/data/prayjourney@yeah.net/540d115f2104444680a1ff007ac6eac7/clipboard.png)

gradle-4.10.2-all是带有源码的，



![img](C:/Users/Administrator/AppData/Local/YNote/data/prayjourney@yeah.net/91cbf9953b4545d3a7c54680039d6ffc/clipboard.png)

而gradle-4.10.2-bin只是二进制的文件，在这两个之中，有一个文件夹gradle-4.10.2，里面包含了lib, 就是我们下载下来的lib, 项目就依赖这些jar包和依赖。

![img](C:/Users/Administrator/AppData/Local/YNote/data/prayjourney@yeah.net/3ac99eb381224a7e9ebaa0358859fba8/clipboard.png)

**7.buildscript:** 其中的声明是gradle脚本自身需要使用的资源。可以声明的资源包括依赖项、第三方插件、maven仓库地址等

**8.ext:** 自定义属性，现在很多人都喜欢把所有关于版本的信息都利用ext放在另一个自己新建的gradle文件中集中管理

**9.repositories:** 顾名思义就是仓库的意思啦，而jcenter()、maven()和google()就是托管第三方插件的平台

**10.dependencies:** 当然配置了仓库还不够，我们还需要在dependencies{}里面的配置里，把需要配置     的依赖用classpath配置上，因为这个dependencies在buildscript{}里面，所以代表的是Gradle需要的插件。

**11.apply plugin：’×××' ：**这种叫做引入Gradle插件，而Gradle插件大致分为分为两种，

​     apply plugin：’×××’：叫做二进制插件，二进制插件一般都是被打包在一个jar里独立发布的，

​     apply from：’×××’：叫做应用脚本插件，其实这不能算一个插件，它只是一个脚本。

`apply plugin: 'com.android.application'`

这句话的意思就是应用“com.android.application“这个插件来构建app模块，app模块就是Gradle  中的一个Project，每个插件之中包含了不同的顶级任务，如com.android.application插件， 就包含了4个顶级任务：

​	1.assemble: 构建项目的输出（apk）

​	2.check: 进行校验工作

​    3.build: 执行assemble任务与check任务

​	4.clean: 清除项目的输出

**settings.gradle是对于整个大的项目而言， 而build.gradle 是真正的构建规则**。





#### buildscript例子

```java
buildscript {
    repositories {
        jcenter() //构建脚本中所依赖的库都在jcenter仓库下载
    }
    dependencies {
        //指定了gradle插件的版本
        classpath 'com.android.tools.build:gradle:1.5.0'
    }
}

allprojects {
    repositories {
        //当前项目所有模块所依赖的库都在jcenter仓库下载
        jcenter()
    }
}
```

buildscript是构建脚本，allprojects是所有的项目，二者内容可能是相同的，buildscript中的声明是gradle脚本自身需要使用的资源，就是说他是管家自己需要的资源，跟你这个大少爷其实并没有什么关系。而allprojects声明的却是你所有module所需要使用的资源，就是说如果大少爷你的每个module都需要用同一个第三库的时候，你可以在allprojects里面声明。





#### build.gradle例子

整个工程的build.gradle通常不需我们改动，这里我们介绍下一些对模块目录下build.gradle文件的常见配置。

**1.依赖第三方库**，在build.gradle之中添加，如下

```java
dependencies {
    ...
    compile 'com.facebook.fresco:fresco:0.11.0'
}
```

**2. 导入本地jar包**，只需要先把jar文件添加到app\libs目录下，然后在相应jar文件上单击右键，选择“Ad As Library”。然后在build.gradle的dependencies块下添加如下语句：

```java
dependencies {
    ...
    compile files('libs/xxx.jar')
}
```

实际上我们可以看到，系统为我们创建的build.gradle中就已经包含了如下语句：

```java
compile fileTree(dir: 'libs', include: ['*.jar']) 
```

这句话的意思是，将libs目录下的所有jar包都导入。所以实际上我们只需要把jar包添加到libs目录下并“Ad As Library"即可。

**3. 依赖其它模块**，app模块依赖other模块，那么我们只需app\build.gradle的denpendencies块下添加如下语句：

```groovy
dependencies {
    ...
    compile project(':other')
}
```





#### 一些设置

**设置全局编码**

如果导入一个windows下编写的项目，而代码中有中文注释，采用GBK, GB18030等编码方式时，编译会报错，可以采用如下方式统一项目的编码

```groovy
allprojects {
    repositories {
        jcenter()
    }

    tasks.withType(JavaCompile) {
        options.encoding = "UTF-8"
    }
}
```



**设置全局编译器的版本**

如果编程过程中采用了新版JDK（比如1.7）才支持的特性(比如new HashMap<>这样的写法)，而编译的时候默认是旧版的JDK(比如1.6)，这个时候编译会报错，采用如下方式可以指定用哪个版本的编译器编译，前提是JAVA_HOME指定的JDK是大于等于新版JDK的哦^o^，其他和java编译器相关的也可以在这里配置

```groovy
allprojects {
    repositories {
        jcenter()
    }
    tasks.withType(JavaCompile) {
        sourceCompatibility = JavaVersion.VERSION_1_7
        targetCompatibility = JavaVersion.VERSION_1_7
    }
}
```

如果不想全局生效，可以将tasks.withType(JavaCompile)放入某个子项目中。



**设置第三方maven地址**

其中name和credentials是可选项，视具体情况而定

```groovy
allprojects {
    repositories {
        maven {
            url 'url'
            name 'maven name'
            credentials {
                username = 'username'
                password = 'password'
            }
        }
    }
}
```



**全局变量定义及引用**

可以在顶层build.gradle脚本中定义一些全局变量，提供给子脚本引用

```java
ext {
    // global variables definition
    compileSdkVersion = 'Google Inc.:Google APIs:23'
    buildToolsVersion = "23.0.3"
    minSdkVersion = 14
    targetSdkVersion = 23
}
// 子脚本引用
android {
    compileSdkVersion rootProject.ext.compileSdkVersion
    buildToolsVersion rootProject.ext.buildToolsVersion

    defaultConfig {
        minSdkVersion rootProject.ext.minSdkVersion
        targetSdkVersion rootProject.ext.targetSdkVersion
    }
}
```



---

ref:

**gradle系统学习：**

https://blog.csdn.net/lastsweetop/article/category/9271161

**gradle配置：**

https://blog.csdn.net/yechaoa/article/details/80484468

https://blog.csdn.net/achenyuan/article/details/80682288

https://blog.csdn.net/maosidiaoxian/article/details/40109337



其他的资源：

https://www.cnblogs.com/Bonker/p/5619458.html

http://www.figotan.org/2016/04/01/gradle-on-android-best-practise/

https://www.jianshu.com/p/7f8bad461fea

https://blog.csdn.net/lwj_zeal/article/details/82750751



**groovy基本知识：**

https://www.jianshu.com/p/b58b254d8f6e

https://mp.weixin.qq.com/s?__biz=MzIwMTAzMTMxMg==&mid=2649492338&idx=1&sn=49cb619fb057720db505b7c3b8f894e8&chksm=8eec808db99b099b6b0bc5e983fc10df48a085a78ca935593737ec9d76b373188e20cf1042d9&mpshare=1&scene=1&srcid=0725CUXNoNL3Dd3OfCCHP1Op&key=7dad7409be596df6cce12e9b567196d7feb09e0b9355578f0f23d84bd8c9d75e68eef65cffcd9b8208776ce935da0a8111b64313deb9e842aa6e29b91507b9ccbcccbee70857fcd69e3ebffd9250130c&ascene=0&uin=MTI0NjM4NTEyMA%3D%3D&devicetype=iMac+MacBookPro11%2C4+OSX+OSX+10.11.1+build(15B42)&version=12010110&nettype=WIFI&fontScale=100&pass_ticket=EQnKsyDv55Ot1aANSvOTlzt78Sjt1f74YaI%2FX7yrrFLhXmvsamoahV%2F%2BKPNQ21oX