### idea中iml文件的问题

---

iml文件是idea组织工程的文件, 里面记录了各种记录模块, 文件夹以及依赖的信息, 显示如下:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<module org.jetbrains.idea.maven.project.MavenProjectsManager.isMavenModule="true" type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" LANGUAGE_LEVEL="JDK_1_5">
    <output url="file://$MODULE_DIR$/target/classes" />
    <output-test url="file://$MODULE_DIR$/target/test-classes" />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/src/main/java" isTestSource="false" />
      <sourceFolder url="file://$MODULE_DIR$/src/main/resources" type="java-resource" />
      <sourceFolder url="file://$MODULE_DIR$/src/test/java" isTestSource="true" />
      <excludeFolder url="file://$MODULE_DIR$/target" />
    </content>
    <orderEntry type="inheritedJdk" />
    <orderEntry type="sourceFolder" forTests="false" />
  </component>
</module>
```
一般而言, 创建的工程都会有这个文件, 它的本质是一个**工程组织**文件, 和Maven的pom.xml, gradle的build.gradle, 等组织工程和处理依赖关系的文件并没有什么差别, 所以, 我们在创建Maven和gradle等自带工程组织的项目的时候, 可以删除此文件, 而且, 我们在提交到git仓库的时候, 往往会把此文件忽略掉, 这点需要注意一下.

ref:
1.[iml文件和pom.xml文件之间的关系](https://stackoverrun.com/cn/q/13107621)

