### gradle入门学习
---

##### gradle是什么

gradle跟ant/maven一样, 是一种依赖管理/自动化构建工具. 但是跟ant/maven不一样, 它并没有使用xml语言, 而是采用了Groovy语言, 这使得它更加简洁、灵活, 更加强大的是, gradle完全兼容maven和ivy. 更多详细介绍可以看它的[官网](http://www.gradle.org/).



#####  为什么使用gradle
更容易重用资源和代码; 可以更容易创建不同的版本的程序, 多个类型的apk包; 更容易配置, 扩展; 更好的IDE集成;



##### gradle入门需知
###### 基本配置
首先明确gradle跟maven一样, 也有一个配置文件, maven里面是叫pom.xml, 而在gradle中是叫build.gradle. Android Studio中的android项目通常至少包含两个build.gradle文件, 一个是project范围的, 另一个是module范围的, 由于一个project可以有多个module, 所以每个module下都会对应一个build.gradle. 比如有如瞎示意图:

```shell
gradledemo
|-------- build.gradle      -- 全局配置
├-------- settings.gradle   -- 全局配置
|
├-------- common            -- common子模块
│     └-- build.gradle      -- common子模块配置
├
|-------- rest              -- rest子模块
│     └-- build.gradle      -- rest子模块配置
├
|-------- web               -- web子模块
│     └-- build.gradle      -- web子模块2配置
```

上面是一个gradle配置的多module的project基本视图, 上面那个是module下的build.gradle文件. project的名称是gradledemo, 下面第一个build.gradle文件 是全局配置, setting.gradle文件也是全局配置, build.gradle是配置依赖, 依赖仓库这些的, setting是模块之间以依赖, 和父子模块管理的配置项. project下的build.gradle是基于整个project的配置, 而module下的build.gradle是每个模块自己的配置. project是一个大的工程, 下面可以包含不同的module, 下面看下这两个build.gradle里面的内容:

gradledemo的build.gradle:
```groovy
// Top-level build file where you can add configuration options common to all sub-projects/modules. 
// 构建脚本
buildscript {
    ext {
         springBootVersion = '2.1.2.RELEASE'
         fastjsonVersion = "1.2.54"
    }
    // 构建过程依赖的仓库
    repositories {
          jcenter()
          maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}
    }
    // 构建过程需要依赖的库
     dependencies {
          // 下面声明的是gradle插件的版本
          classpath 'com.android.tools.build:gradle:1.1.0'
          classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
          compile("com.alibaba:fastjson:$fastjsonVersion")
          // NOTE: Do not place your application dependencies here; they belong
          // in the individual module build.gradle files
    }
}
// 这里面配置整个项目依赖的仓库, 这样每个module就不用配置仓库了, 所有的仓库都适用, 父模块的部分也适用
allprojects {
     group 'com.diboot'
     version '1.0-SNAPSHOT'
     apply plugin: 'idea'

     repositories {
          jcenter()
     }

     dependencies {
          compile("org.apache.commons:commons-lang3:3.8.1")
    }
}
// 子模块通用配置, 这里的子模块是指的例如common, rest, web这样的子模块, 而不包括父模块的部分
subprojects {
    apply plugin: 'java'
    apply plugin: 'idea'
    apply plugin: 'eclipse'

    group = 'cn.com.hellowood'
    version = '0.0.2-SNAPSHOT'

    sourceCompatibility = 1.8

    // java编译的时候缺省状态下会因为中文字符而失败
    [compileJava, compileTestJava, javadoc]*.options*.encoding = 'UTF-8'

    repositories {
        mavenLocal()
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        mavenCentral()
        jcenter()
    }

    dependencies {
        testCompile 'junit:junit:4.12'
    }
}
```
>大家可能很奇怪, 为什么仓库repositories需要声明两次, 这其实是由于它们作用不同, buildscript中的仓库是gradle脚本自身需要的资源, 而allprojects下的仓库是项目所有模块需要的资源. 所以大家千万不要配错了.

common模块的build.gradle:
```groovy
// 构建脚本
buildscript {
    ext {
        springBootVersion = '1.5.9.RELEASE'
    }
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'org.springframework.boot'

archivesBaseName = 'Controller'

description = 'myapp-controller'

repositories {
    mavenCentral()
}


dependencies {
     // 该子工程包含另外一个子工程
     compile project(':rest')

     compile('org.mybatis.spring.boot:mybatis-spring-boot-starter:1.3.1')
     compile('org.springframework.boot:spring-boot-starter-web')
     compile('io.springfox:springfox-swagger2:2.7.0')
     compile('io.springfox:springfox-swagger-ui:2.7.0')
     runtime('mysql:mysql-connector-java')
     runtime('com.h2database:h2')
     testCompile('org.springframework.boot:spring-boot-starter-test')
     testCompile('org.springframework.restdocs:spring-restdocs-mockmvc')
}
```

gradledemo的settings.gradle:
```groovy
// 这个文件是用来配置多模块的, 比如你的项目有两个模块module-a,module-b,那么你就需要在这个文件中进行配置, 格式如下:
include ':common',':web'
```

###### 其他配置
现在我们对build.gradle已经初步了解了, 我们再看下其他一些与gradle相关的文件:
1. gradle.properties:
从名字上就知道它是一个配置文件, 没错, 这里面可以定义一些常量供build.gradle使用, 比如可以配置签名相关信息如keystore位置, 密码, keyalias等. 
2. settings.gradle:
这个文件是用来配置多模块的, 比如你的项目有两个模块module-a,module-b,那么你就需要在这个文件中进行配置
3. gradle文件夹:
这里面有两个文件, gradle-wrapper.jar和gradle-wrapper.properties,它们就是gradle wrapper. gradle项目都会有, 你可以通过命令gradle init来创建它们(前提是本地安装了gradle并且配置到了环境变量中).
4. gradlew和gradlew.bat:
这分别是linux下的shell脚本和windows下的批处理文件, 它们的作用是根据gradle-wrapper.properties文件中的distributionUrl下载对应的gradle版本. 这样就可以保证在不同的环境下构建时都是使用的统一版本的gradle, 即使该环境没有安装gradle也可以, 因为gradle wrapper会自动下载对应的gradle版本. gradlew的用法跟gradle一模一样, 比如执行构建gradle build命令, 你可以用gradlew build. gradlew即gradle wrapper的缩写.



##### gradle仓库:
gradle有三种仓库, maven仓库, ivy仓库以及flat本地仓库. 声明方式如下:
```groovy
maven{
      url "..."
}
ivy{
      url "..."
}
flatDir{
      dirs 'xxx'
}
```

有一些仓库提供了别名, 可直接使用:
```groovy
repositories{
     mavenCentral()
     jcenter()
     mavenLocal()
}
```



##### gradle任务:
gradle中有一个核心概念叫任务, 跟maven中的插件目标类似. gradle的android插件提供了四个顶级任务
```groovy
assemble    构建项目输出
check       运行检测和测试任务
build       运行assemble和check
clean       清理输出任务
```
执行任务可以通过gradle/gradlew+任务名称的方式执, 执行一个顶级任务会同时执行与其依赖的任务, 比如你执行`gradlew assemble`, 它通常会执行:
```groovy
gradlew assembleDebug
gradlew assembleRelease
```
这时会在你项目的build/outputs/apk或者build/outputs/aar目录生成输出文件, `gradlew tasks`列出所有可用的任务. 在IDE中可以打开右侧gradle视图查看所有任务.



##### gradle常用命令
基本上, gradle是通过各种plugin来完成相关功能的, 这点是从maven学来的, 所以基本上学习gradle, 就是掌握一些常见plugin的用法及关键配置.
1. 创建项目
随便建一个空目录，然后cd 进入该目录，再`gradle init` 就可以了
2. 常用命令
     ```groovy
     # 查看所有可用的task
     gradle task

     #编译（编译过程中会进行单元测试）
     gradle build

     #单元测试
     gradle test

     #编译时跳过单元测试
     gradle build -x test

     #直接运行项目 
     gradle run

     #清空所有编译、打包生成的文件(即：清空build目录)
     gradle clean

     #生成mybatis的model、mapper、xml映射文件，注： 生成前，先修改src/main/resources/generatorConfig.xml 文件中的相关参数 ， 比如：mysql连接串，目标文件的生成路径等等
     gradle mybatisGenerate

     #生成可运行的jar包，生成的文件在build/install/hello-gradle下，其中子目录bin下为启动脚本， 子目录lib为生成的jar包
     gradle installApp

     #打包源代码，打包后的源代码，在build/libs目录下
     gradle sourcesJar

     #安装到本机maven仓库，此命令跟maven install的效果一样
     gradle install

     #生成pom.xml文件，将会在build根目录下生成pom.xml文件，把它复制项目根目录下，即可将gradle方便转成maven项目
     gradle createPom
     ```


##### 常见问题
1. 导入本地jar包: 
    跟eclipse不太一样, android studio导入本地jar除了将jar包放到模块的libs目录中以外, 还得在该模块的build.gradle中进行配置, 配置方式是在dependencies结点下进行如下声明: `compile files('libs/xxx.jar')`, 如果libs下有多个jar文件, 可以这样声明: `compile fileTree(dir: 'libs', include: ['*.jar'])`

2. 导入maven库:
    `compile 'com.android.support:appcompat-v7:21.0.3'`, 可以简写为: `compile 'groupId:artifactId:version'`

3. 导入某个project:
    app是多模块的, 假设有两个模块app和module-A,并且app模块是依赖module-A的, 这时候我们就需要在app模块的build.gradle中的dependencies结点下配置依赖: `compile project(':module-A')`, 并且你需要在settings.gradle中把module-A模块包含进来: `include ':module-A',':app'`, 此外, 这种情况下module-A模块是作为库存在的, 因而它的build.gradle中的插件声明通常应该是这样的: `apply plugin: 'com.android.library'`, 而且, 作为library的模块module-A的build.gradle文件的defaultConfig中是不允许声明applicationId的, 这点需要注意.

4. 声明三方maven仓库:
    可能你项目需要的一些库文件是在你们公司的私服上, 这时候repositories中仅有jcenter就不行了, 你还需要把私服地址配到里面来, 注意, 应该配到project的build.gradle中的allprojects结点下或者直接配到某个模块中如果仅有这个模块用到. 配置方式:
    ```groovy
         repositories{
              maven{
                   url="http://mvnrepo.xxx.com"
              }
         }
    ```

5. 排除依赖: 
    当出现依赖冲突的时候可以通过排除依赖解决, 具体方式如下:
    ```groovy
    compile (group:'xxx',name:'xxx',version:'xxx'){
         exclude group:'xxx',module:'xxx'//module对应的就是artifactId
    }
    ```

6. 自动移除不用资源
    可以在buildTypes结点中增加如下配置: 
    ```groovy
    buildTypes{
         release{
              minifyEnabled true
              shrinkResources true
         }
    }
    ```

7. 忽略lint错误:
    可以在build.gradle文件中的android结点下增加如下配置:
    ```groovy
    android{
         lintOptions{
              abortOnError false
         }
    }
    ```

8. 声明编译的java版本
    可以在build.gradle文件中的android结点下增加如下配置:
    ```groovy
    compileOptions {
         sourceCompatibility JavaVersion.VERSION_1_7
         targetCompatibility JavaVersion.VERSION_1_7
    }
    ```

9. 定制buildConfig: 
    在build.gradle中配置:
    ```
    buildTypes{
          release{
                buildConfigField "string","type","\"release\""
          }
          debug{
                buildConfigField "string","type","\"debug\""
          }
    }
    ```
    这样就会在BuildConfig类中生成type字段: 
    //build/generate/source/buildConfig/release/包名/   路径下的BuildConfig.java
    public static final String type = "release"
    //build/generate/source/buildConfig/debug/包名/    路径下的BuildConfig.java
    public static final String type = "debug"

---
ref:
1.[Gradle 使用-多项目构建](https://blog.csdn.net/u013360850/article/details/78405981),   2.[IDEA下Gradle多模块(项目)的构建](https://segmentfault.com/a/1190000018028996),   3.[Gradle学习系列----多项目构建](https://juejin.im/post/5afe85d551882542ba080264),   4.[gradle 教程学习笔记（二）](https://blog.csdn.net/king_is_everyone/article/details/39958561),   5.[gradle入门](http://www.androidchina.net/2155.html),   6.[Gradle构建多模块项目](https://www.cnblogs.com/heart-king/p/5909225.html),   7.[gradle入门](https://www.cnblogs.com/lhwcoding/p/5106408.html),   8.[【入门】Gradle的基本使用、在IDEA中的配置、常用命令](https://www.cnblogs.com/sunny3096/p/9013704.html),   9.[Gradle依赖包全局配置管理](https://blog.csdn.net/u010358168/article/details/80227467)