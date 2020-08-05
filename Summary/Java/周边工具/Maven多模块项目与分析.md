### 为什么要用Maven多模块
假设有这样一个项目，很常见的Java Web应用。在这个应用中，我们分了几层：
Dao
Service
Controller
对应的，在一个项目中，我们会看到一些包名：

```java
org.xx.app.dao
org.xx.app.service
org.xx.app.web
org.xx.app.util
```
但随着项目的进行，你可能会遇到如下问题：
1. 这个应用可能需要有一个前台和一个后台管理端，你发现大部分dao，一些service，和大部分util是在两个应用中可。
2. pom.xml中的依赖列表越来越长以重用的，但是，由于目前只有一个项目，你不得不新建一个项目依赖这个WAR.
3. build整个项目的时间越来越长，尽管你只是一直在web层工作，但你不得不build整个项目。
4. 某个模块，比如util，你只想让一些经验丰富的人来维护，可是，现在这种情况，每个开发者都能修改，这导致关键模块的代码质量不能达到你的要求。

我们会发现，其实这里实际上没有遵守一个设计模式原则：“高内聚，低耦合”。虽然我们通过包名划分了层次，并且你还会说，这些包的依赖都是单向的，没有包的环依赖。这很好，但还不够，因为就构建层次来说，所有东西都被耦合在一起了。因此我们需要使用Maven划分模块。
其实说白了，Maven多模块就是为了更好的复用，所以，要求划分子模块，为啥不单独开工程，然后我们各自去引用呢？我认为有一下几点：
1. 每个工程单独管理，必然要开单独的仓库，是否能及时更新，及时响应，不好管理；
2. 每个单独的工程，那就要单端部署和管理，如何部署，是否在同一台服务器上，是否支持远程调用，增加了运营运维的成本，不好管理；
3. 如果每个都单独开工程，那么有一部分的基础代码就会重复，比如POJO，各种配置，这些就会冗余。
所以，为了内聚和简单可以重复使用这个因素，就直接在一个大的工程里面，直接去开辟小的模块，这样就避免了上述的3个问题。



### Maven子模块和父模块的设置
在有子模块的maven工程之中，有子模块和父模块两个角色，父模块是root的角色，一般我们在父模块之中不写代码，所以创建好父模块的工程之后，就会删除src文件夹，父模块其实就是起一个管理的作用，管理插件，管理依赖，保证我们的子模块工程，使用的jar包在版本上是没有冲突的，而真正实现功能的部分是在子模块，子模块之间就能够相互引用(单方面的)，这就是基本的一个思想，按照这个想法，我们所要做的事情，其实已经一目了然，父模块-管理，子模块->干活，父子之间有层级关系。我们使用的是Maven管理，那就必然是关系到pom.xml文件，其中就牵扯到parent，packaging，modules，dependencyManagement，pluginManagement。
- parent
    - 所有的工程，都不需要写parent了，父工程可以写，但是没必要，子模块，没法写，因为父工程只是一个壳子，没有包名，所以子模块父模块都不需要写了，SpringBoot工程默认会有spring-boot-starter-parent的parent，可以直接去掉。
- packaging
    - 父工程变为pom， 子工程变成jar或者war，按照需求，一般是jar，方便引入使用。
- modules
    - 父工程之中使用modules标签，一个工程一个module，把子工程包裹起来。
- dependencyManagement
    - 父工程之中使用，依赖管理，相当于一个版本的定义，子工程可以不去使用，使用自己的版本也是可以的。
- pluginManagement
    - 父工程之中使用，插件管理，相当于一个版本的定义，子工程可以不去使用，使用自己的版本也是可以的。

按照这个操作后，项目的关系在IDEA之中的显示是如左图图的，也就是，在父工程后面，会标注一个root，而右边的图，bootvue虽然在springboot2.x-integration的文件夹下面，但是没有父子关系的。下面展示三个pom配置：

![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805142821071-1223738318.png)

**zgytest的pom.xml**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <!-- 父模块，parent可有可无 -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.3.0.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.zgy.test</groupId>
    <artifactId>zgytest</artifactId>
    <packaging>pom</packaging>
    <version>0.0.1-SNAPSHOT</version>
    <name>zgytest</name>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <spring-boot.version>2.3.0.RELEASE</spring-boot.version>
    </properties>

    <!-- 子模块 -->
    <modules>
        <module>mine</module>
        <module>hello</module>
    </modules>

    <!-- 依赖管理 -->
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring-boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>

            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter</artifactId>
            </dependency>

            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-devtools</artifactId>
                <scope>runtime</scope>
                <optional>true</optional>
            </dependency>

        </dependencies>
    </dependencyManagement>

    <build>
        <!-- 插件管理 -->
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.8.1</version>
                    <configuration>
                        <source>1.8</source>
                        <target>1.8</target>
                        <encoding>UTF-8</encoding>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>

</project>
```

**hello的pom.xml**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example.hello</groupId>
    <artifactId>hello</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>hello</name>
    <packaging>jar</packaging>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <spring-boot.version>2.3.0.RELEASE</spring-boot.version>
        <spring-cloud-alibaba.version>2.2.1.RELEASE</spring-cloud-alibaba.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-dubbo</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>com.taobao.arthas</groupId>
            <artifactId>arthas-spring-boot-starter</artifactId>
            <version>3.3.7</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

**mine的pom.xml**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example.dream</groupId>
    <artifactId>mine</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>mine</name>
    <packaging>jar</packaging>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <spring-boot.version>2.3.0.RELEASE</spring-boot.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>


        <!-- 引入hello模块 -->
        <dependency>
            <groupId>com.example.hello</groupId>
            <artifactId>hello</artifactId>
            <version>0.0.1-SNAPSHOT</version>
        </dependency>

    </dependencies>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring-boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>

        </plugins>
    </build>

</project>
```

### Maven多模块项目的创建
和普通的项目创建没有区别，一般我们直接创建SpringBoot工程或者maven工程，按照上面的Maven子模块和父模块的设置的设置配置即可，关键点就是pom文件之中的parent，packaging，modules，dependencyManagement，pluginManagement这几个标签，其中parent，packaging，modules是必须处理的。详细：[Maven 多模块父子工程 (含Spring Boot示例)](https://www.cnblogs.com/meitanzai/p/10945085.html)，https://www.cnblogs.com/flywang/p/8567175.html，https://blog.csdn.net/u013983628/article/details/89511553，https://blog.csdn.net/qq_42449963/article/details/105405247



### **Maven子模块相互调用**
其实，maven工程如果分成了子模块父模块的模式，父模块只是一个壳子，相当于是进行了一个依赖，版本等的管理，更像是一个管家，而各个子模块可以直接从父模块获取需要的依赖，这样的话，就可以保证各个子模块所获取的依赖，没有冲突，相同的依赖，不至于因为版本的不同而导致一些莫名其妙的问题发生，我们也知道，如果是子模块之间，有依赖，那么我们就直接调用引入依赖即可，但是要确保这个时候是单向的，也就是要排除循环依赖的问题。比如，moduleA，moduleB，在moduleB之中依赖了moduleA，那么也就是要引入moduleA即可，如同下图之中的mine工程，引入了hello模块，和我们正常引入其他的jar包并没有任何区别。

```xml
<dependency>
    <groupId>com.example.hello</groupId>
    <artifactId>hello</artifactId>
    <version>0.0.1-SNAPSHOT</version>
</dependency>
```

![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805142931219-933871482.png)



### Maven子模块和父模块工程的替代方式
这个其实我们从上面也可以看出来，模块之间的调用和普通的引入第三方的jar包没有任何区别，只不过从上述提出的三个方面：
1. 每个工程单独管理，必然要开单独的仓库，是否能及时更新，及时响应，不好管理；
2. 每个单独的工程，那就要单端部署和管理，如何部署，是否在同一台服务器上，是否支持远程调用，增加了运营运维的成本，不好管理；
3. 如果每个都单独开工程，那么有一部分的基础代码就会重复，比如POJO，各种配置，这些就会冗余。
而言，这样会比较麻烦，不管从运营，维护，以及更新，都会有一定的成本，所以就选择了多层级的处理方式，但是实际上，还是单层级的项目最简洁，这种方式代替也很简单，就是一个模块，当做是一个单独的项目，如果有使用就去调用，至于是否支持远程调用，那就要看是不是部署在同一个服务器上面，如果在同一台服务器，普通的方式就行，如果不在同一台服务器，那就要支持远程调用，那就要用到RPC， `Dubbo`的方式了，更远一步说，就是`分布式架构`和`微服务`的范畴了，所以从这个角度上面来说，微服务，就是从这个角度出发的。