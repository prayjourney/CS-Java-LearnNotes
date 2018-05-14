### 浅谈jsp、freemarker、velocity和thymeleaf 的区别

***

在java领域，表现层技术主要有三种：jsp、freemarker、velocity、themleaf



##### jsp
是大家最熟悉的技术

- 优点：
  - 功能强大，可以写java代码
  - 支持jsp标签（jsp tag）
  - 支持表达式语言（el）
  - 官方标准，用户群广，丰富的第三方jsp标签库
  - 性能良好。jsp编译成class文件执行，有很好的性能表现
- 缺点：
  - jsp没有明显缺点，非要挑点骨头那就是，由于可以编写java代码，如使用不当容易破坏mvc结构



##### velocity
是较早出现的用于代替jsp的模板语言
- 优点：
  - 不能编写java代码，可以实现严格的mvc分离
  - 性能良好，据说比jsp性能还要好些
  - 使用表达式语言，据说jsp的表达式语言就是学velocity的
- 缺点：
  - 不是官方标准
  - 用户群体和第三方标签库没有jsp多。
  - 对jsp标签支持不够好



##### freemarker
- 优点：
  - 不能编写java代码，可以实现严格的mvc分离
  - 性能非常不错
  - 对jsp标签支持良好
  - 内置大量常用功能，使用非常方便
  - 宏定义（类似jsp标签）非常方便
  - 使用表达式语言
- 缺点：
  - 不是官方标准
  - 用户群体和第三方标签库没有jsp多



##### freemarker
- 性能。velocity应该是最好的，其次是jsp，普通的页面freemarker性能最差（虽然只是几毫秒到十几毫秒的差距）。但是在复杂页面上（包含大量判断、日期金额格式化）的页面上，freemarker的性能比使用tag和el的jsp好。
- 宏定义比jsp tag方便
- 内置大量常用功能。比如html过滤，日期金额格式化等等，使用非常方便
- 支持jsp标签
- 可以实现严格的mvc分离



thymeleaf 

- 官方推荐

ref：

1.[浅谈jsp、freemarker、velocity区别 ](https://blog.csdn.net/tjcyjd/article/details/16803877),   2.[thymeleaf快速入门教程 ](https://blog.csdn.net/u014042066/article/details/75614906)