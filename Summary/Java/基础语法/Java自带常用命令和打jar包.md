### Java自带常用命令和打jar包

***
以打jar包的命令来算, 其实我们打jar包有很多种途径, 最常用的, 可以通过各种构建工具, 比如maven, gradle, 还有springboot的打包方式, 这样的话很简单, 以maven为例子, 我们使用`mvn package -Dmaven.test.skip=true`, 这样就能够把相关的java文件打成了jar包, 这样的话是通过使用高级的方法, 现在要说的是通过最初的方式, 来构建jar包, 也就是java, javac, jar这几个相关命令, 首先来说, java是运行class文件&jar文件的, 无法直接运行\*.java文件, \*.java文件是需要让javac命令来运行的, 也就是要先通过javac的编译, 才能变换成\*.class文件, 而jar命令就是纯粹来打jar包使用. 三者之间的关系

![java相关命令](../../../images/java相关命令.png)



##### 创建jar包
###### 1.将文件简单打包
将\*.java文件简单打包的关键在于创建**MANIFEST.mf**文件, 在这个文件之中, 我们记录了如下的内容:
```txt
Manifest-Version: 1.0
Created-By: 1.8.0_121 (Oracle Corporation)
Main-Class: Hello
```
比如我们有两个类文件
```java
class Tom{
     public static void speak(){
         System.out.println("hello");
     }
}
```
```java
class Hello{
     public static void main(String[] agrs){
         Tom.speak();
     }
 }
```
执行时, 我们首先进行`javac Tom.java`和 `javac Hello.java`,然后配合上述已经创建好的MENIFEST.mf文件, 也就是这个描述文件, 目前**MENIFEST.mf和这两个类文件是在同一个目录层级**, 然后运行`jar -cvfm hello.jar MENIFEST.mf Hello.class Tom.class `, 这样打包就可以了, 然后运行`java -jar hello.jar`就输出了`hello`的结果, 这一切显示是在console之中的. **上述的是类之间有调用的情况, 有调用的时候需要全部把所需要的类打包到jar文件之中, 如果是单一的class文件, 则后面只有一个即可**.
需要注意, javac有一个选线`javac -d xxxx`,通过这个命令, 我们可以将class文件输出到不同的目录之中.
如果有包呢? 比如com. zgy这样的包? 怎么打包呢?
```java
package com.zgy
class Tom{
     public static void speak(){
         System.out.println("hello");
     }
}
```
```java
package com.cqu

import com.zgy;

class Hello{
     public static void main(String[] agrs){
         Tom.speak();
     }
 }
```

