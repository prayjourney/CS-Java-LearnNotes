### StringUtils类的使用

***

##### 初步介绍

StringUtils 方法的操作对象是 java.lang.String 类型的对象，是对 JDK 提供的 String 类型操作方法的补充，并且是 **null 安全的**(即如果输入参数 String 为 null 则不会抛出  NullPointerException ，而是做了相应处理，例如，如果输入为 null 则返回也是null等，具体可以查看源代码)。除了构造器，StringUtils 中一共有130多个方法，并且 **都是static** 的，所以我们可以这样调用StringUtils.xxx() 



##### 方法介绍

1.``public static boolean isEmpty(String str) ``

判断某字符串是否为空，为空的标准是`str==null` 或 `str.length()==0 `下面是 StringUtils 判断是否为空的示例：

```java
StringUtils.isEmpty(null) = true
StringUtils.isEmpty("") = true 
StringUtils.isEmpty(" ") = false //注意在 StringUtils 中空格作非空处理
StringUtils.isEmpty("   ") = false
StringUtils.isEmpty("bob") = false
StringUtils.isEmpty(" bob ") = false
```

2.`public static boolean isNotEmpty(String str)` 

判断某字符串是否非空，等于 !isEmpty(String str) ,下面是示例：
```java
StringUtils.isNotEmpty(null) = false
StringUtils.isNotEmpty("") = false
StringUtils.isNotEmpty(" ") = true
StringUtils.isNotEmpty("         ") = true
StringUtils.isNotEmpty("bob") = true
StringUtils.isNotEmpty(" bob ") = true 
```
3.`public static boolean isBlank(String str) `
判断某字符串是否为空或长度为0或由空白符(whitespace) 构成，下面是示例：

```java
StringUtils.isBlank(null) = true
StringUtils.isBlank("") = true
StringUtils.isBlank(" ") = true
StringUtils.isBlank("        ") = true
StringUtils.isBlank("\t \n \f \r") = true   //对于制表符、换行符、换页符和回车符
StringUtils.isBlank()   //均识为空白符
StringUtils.isBlank("\b") = false   //"\b"为单词边界符
StringUtils.isBlank("bob") = false
StringUtils.isBlank(" bob ") = false 
```

4.`public static boolean isNotBlank(String str) `
判断某字符串是否不为空且长度不为0且不由空白符(whitespace) 构成，等于 `!isBlank(String str)` ，下面是示例：

```java
StringUtils.isNotBlank(null) = false
StringUtils.isNotBlank("") = false
StringUtils.isNotBlank(" ") = false
StringUtils.isNotBlank("         ") = false
StringUtils.isNotBlank("\t \n \f \r") = false
StringUtils.isNotBlank("\b") = true
StringUtils.isNotBlank("bob") = true
StringUtils.isNotBlank(" bob ") = true 
```

5.`public static String trim(String str) `
去掉字符串两端的控制符(control characters, char <= 32) , 如果输入为 null 则返回null ，下面是示例：

```java
StringUtils.trim(null) = null
StringUtils.trim("") = ""
StringUtils.trim(" ") = ""
StringUtils.trim("  \b \t \n \f \r    ") = ""
StringUtils.trim("     \n\tss   \b") = "ss"
StringUtils.trim(" d   d dd     ") = "d   d dd"
StringUtils.trim("dd     ") = "dd"
StringUtils.trim("     dd       ") = "dd" 
```

6.`public static String trimToNull(String str) `
去掉字符串两端的控制符(control characters, char <= 32) ,如果变为 null 或""，则返回 null ，下面是示例：

```java
StringUtils.trimToNull(null) = null
StringUtils.trimToNull("") = null
StringUtils.trimToNull(" ") = null
StringUtils.trimToNull("     \b \t \n \f \r    ") = null
StringUtils.trimToNull("     \n\tss   \b") = "ss"
StringUtils.trimToNull(" d   d dd     ") = "d   d dd"
StringUtils.trimToNull("dd     ") = "dd"
StringUtils.trimToNull("     dd       ") = "dd" 
```

7.`public static String trimToEmpty(String str) `
去掉字符串两端的控制符(control characters, char <= 32) ,如果变为 null 或 "" ，则返回 "" ,下面是示例：

```java
StringUtils.trimToEmpty(null) = ""
StringUtils.trimToEmpty("") = ""
StringUtils.trimToEmpty(" ") = ""
StringUtils.trimToEmpty("     \b \t \n \f \r    ") = ""
StringUtils.trimToEmpty("     \n\tss   \b") = "ss"
StringUtils.trimToEmpty(" d   d dd     ") = "d   d dd"
StringUtils.trimToEmpty("dd     ") = "dd"
StringUtils.trimToEmpty("     dd       ") = "dd" 
```

8.`public static String strip(String str) `
去掉字符串两端的空白符(whitespace) ，如果输入为 null 则返回 null ，下面是示例(注意和 trim() 的区别)：

```java
StringUtils.strip(null) = null
StringUtils.strip("") = ""
StringUtils.strip(" ") = ""
StringUtils.strip("     \b \t \n \f \r    ") = "\b"
StringUtils.strip("     \n\tss   \b") = "ss   \b"
StringUtils.strip(" d   d dd     ") = "d   d dd"
StringUtils.strip("dd     ") = "dd"
StringUtils.strip("     dd       ") = "dd" 
```

9.`public static String stripToNull(String str) `
去掉字符串两端的空白符(whitespace) ，如果变为 null 或""，则返回 null ，下面是示例(注意和 trimToNull() 的区别)：

```java
StringUtils.stripToNull(null) = null
StringUtils.stripToNull("") = null
StringUtils.stripToNull(" ") = null
StringUtils.stripToNull("     \b \t \n \f \r    ") = "\b"
StringUtils.stripToNull("     \n\tss   \b") = "ss   \b"
StringUtils.stripToNull(" d   d dd     ") = "d   d dd"
StringUtils.stripToNull("dd     ") = "dd"
StringUtils.stripToNull("     dd       ") = "dd" 
```


10.`public static String stripToEmpty(String str)` 
去掉字符串两端的空白符(whitespace) ，如果变为 null 或"" ，则返回"" ，下面是示例(注意和 trimToEmpty() 的区别)：
```java
StringUtils.stripToNull(null) = ""
StringUtils.stripToNull("") = ""
StringUtils.stripToNull(" ") = ""
StringUtils.stripToNull("     \b \t \n \f \r    ") = "\b"
StringUtils.stripToNull("     \n\tss   \b") = "ss   \b"
StringUtils.stripToNull(" d   d dd     ") = "d   d dd"
StringUtils.stripToNull("dd     ") = "dd"
StringUtils.stripToNull("     dd       ") = "dd"
```

##### 用途归类

1.检查字符串是否为空或null或仅仅包含空格

 ```java
String test = "";
String test1=" ";
String test2 = "\n\n\t";
String test3 = null;
System.out.println( "test blank? " + StringUtils.isBlank( test ) ); 
System.out.println( "test1 blank? " + StringUtils.isBlank( test1 ) );
System.out.println( "test2 blank? " + StringUtils.isBlank( test2 ) );
System.out.println( "test3 blank? " + StringUtils.isBlank( test3 ) );
 ```

运行结果：
test blank? true
test1 blank? true
test2 blank? true
test3 blank? true
相对应的还有一个StringUtils.isNotBlank(String str)
**StringUtils.isEmpty(String str)则检查字符串是否为空或null（不检查是否仅仅包含空格）**


2.分解字符串
```java
StringUtils.split(null, *, *)            = null
StringUtils.split("", *, *)              = []
StringUtils.split("ab de fg", null, 0)   = ["ab", "cd", "ef"]
StringUtils.split("ab   de fg", null, 0) = ["ab", "cd", "ef"]
StringUtils.split("ab:cd:ef", ":", 0)    = ["ab", "cd", "ef"]
StringUtils.split("ab:cd:ef", ":", 1)    = ["ab:cd:ef"]
StringUtils.split("ab:cd:ef", ":", 2)    = ["ab", "cd:ef"]
StringUtils.split(String str,String separatorChars,int max) str为null时返回null
```
separatorChars为null时默认为按空格分解，max为0或负数时分解没有限制，max为1时返回整个字符串，max为分解成的个数（大于实际则无效）

3.去除字符串前后指定的字符
```java
StringUtils.strip(null, *)          = null
StringUtils.strip("", *)            = ""
StringUtils.strip("abc", null)      = "abc"
StringUtils.strip(" abc ", null)    = "abc"
StringUtils.strip("  abcyx", "xyz") = "  abc"
StringUtils.strip(String str,String stripChars) str为null时返回null,stripChars为null时默认为空格
```
4.创建醒目的Header（调试时用）
```java
public String createHeader( String title ) {
  int width = 30;
  String stars = StringUtils.repeat( "*", width);
  String centered = StringUtils.center( title, width, "*" );
  String heading = StringUtils.join(new Object[]{stars, centered, stars}, "\n");
  return heading;
}
```
调用createHeader("TEST")的输出结果:
```
******************************
  ************ TEST ************
******************************
******************************
```

5.**字符的全部反转及以单个词为单位的反转** 

```java
String original = "In time, I grew tired of his babbling nonsense.";
StringUtils.reverse( original )   = ".esnesnon gnilbbab sih fo derit werg I ,emit nI"

//以单个词为单位的反转
public Sentence reverseSentence(String sentence) {
String reversed = StringUtils.chomp( sentence, "." );
reversed = StringUtils.reverseDelimited( reversed, ' ' );
reversed = reversed + ".";
return reversed;
}

String sentence = "I am Susan."
reverseSentence( sentence ) )   = "Susan am I."
```

6.**检查字符串是否仅仅包含数字、字母或数字和字母的混合**  String test1 = "ORANGE";

```java
String test2 = "ICE9";
String test3 = "ICE CREAM";
String test4 = "820B Judson Avenue";
String test5 = "1976";

结果：

boolean t1val = StringUtils.isAlpha( test1 ); // returns true
boolean t2val = StringUtils.isAlphanumeric( test2 ); // returns true
boolean t3val = StringUtils.isAlphaSpace( test3 ); // returns true
boolean t4val = StringUtils.isAlphanumericSpace( test4 ); // returns true
boolean t5val = StringUtils.isNumeric( test5 ); // returns true
```



##### API功能

以下方法只介绍其功能，不再举例：
1.`public static String strip(String str, String stripChars)`
去掉 str 两端的在 stripChars 中的字符。
如果 str 为 null 或等于"" ，则返回它本身；
如果 stripChars 为 null 或"" ，则返回 strip(String str) 。

2.`public static String stripStart(String str, String stripChars) `
和11相似，去掉 str 前端的在 stripChars 中的字符。

3.`public static String stripEnd(String str, String stripChars)` 
和11相似，去掉 str 末端的在 stripChars 中的字符。

4.`public static String[] stripAll(String[] strs)` 
对字符串数组中的每个字符串进行 strip(String str) ，然后返回。
如果 strs 为 null 或 strs 长度为0，则返回 strs 本身

5.`public static String[] stripAll(String[] strs, String stripChars) `
对字符串数组中的每个字符串进行 strip(String str, String stripChars) ，然后返回。
如果 strs 为 null 或 strs 长度为0，则返回 strs 本身

6.`public static boolean equals(String str1, String str2)` 
比较两个字符串是否相等，如果两个均为空则也认为相等。
7.public static boolean equalsIgnoreCase(String str1, String str2) 
比较两个字符串是否相等，不区分大小写，如果两个均为空则也认为相等。

8.`public static int indexOf(String str, char searchChar)` 
返回字符 searchChar 在字符串 str 中第一次出现的位置。
如果 searchChar 没有在 str 中出现则返回-1，
如果 str 为 null 或 "" ，则也返回-1

9.`public static int indexOf(String str, char searchChar, int startPos)` 
如果从 startPos 开始 searchChar 没有在 str 中出现则返回-1，
如果 str 为 null 或 "" ，则也返回-1

10.`public static int indexOf(String str, String searchStr)`
返回字符串 searchStr 在字符串 str 中第一次出现的位置。
如果 str 为 null 或 searchStr 为 null 则返回-1，
如果 searchStr 为 "" ,且 str 为不为 null ，则返回0，
如果 searchStr 不在 str 中，则返回-1

11.`public static int ordinalIndexOf(String str, String searchStr, int ordinal)` 
返回字符串 searchStr 在字符串 str 中第 ordinal 次出现的位置。
如果 str=null 或 searchStr=null 或 ordinal<=0 则返回-1
举例(*代表任意字符串)：
```java
StringUtils.ordinalIndexOf(null, *, *) = -1
StringUtils.ordinalIndexOf(*, null, *) = -1
StringUtils.ordinalIndexOf("", "", *) = 0
StringUtils.ordinalIndexOf("aabaabaa", "a", 1) = 0
StringUtils.ordinalIndexOf("aabaabaa", "a", 2) = 1
StringUtils.ordinalIndexOf("aabaabaa", "b", 1) = 2
StringUtils.ordinalIndexOf("aabaabaa", "b", 2) = 5
StringUtils.ordinalIndexOf("aabaabaa", "ab", 1) = 1
StringUtils.ordinalIndexOf("aabaabaa", "ab", 2) = 4
StringUtils.ordinalIndexOf("aabaabaa", "bc", 1) = -1
StringUtils.ordinalIndexOf("aabaabaa", "", 1) = 0
StringUtils.ordinalIndexOf("aabaabaa", "", 2) = 0 
```

12.`public static int indexOf(String str, String searchStr, int startPos)`
返回字符串 searchStr 从 startPos 开始在字符串 str 中第一次出现的位置。举例(*代表任意字符串)：
```java
StringUtils.indexOf(null, *, *) = -1
StringUtils.indexOf(*, null, *) = -1
StringUtils.indexOf("", "", 0) = 0
StringUtils.indexOf("aabaabaa", "a", 0) = 0
StringUtils.indexOf("aabaabaa", "b", 0) = 2
StringUtils.indexOf("aabaabaa", "ab", 0) = 1
StringUtils.indexOf("aabaabaa", "b", 3) = 5
StringUtils.indexOf("aabaabaa", "b", 9) = -1
StringUtils.indexOf("aabaabaa", "b", -1) = 2
StringUtils.indexOf("aabaabaa", "", 2) = 2
StringUtils.indexOf("abc", "", 9) = 3 
```
13.`public static int lastIndexOf(String str, char searchChar)` 
基本原理同--
14.`public static int lastIndexOf(String str, char searchChar, int startPos)` 
基本原理同--
15.`public static int lastIndexOf(String str, String searchStr)`
基本原理同--
16.`public static int lastIndexOf(String str, String searchStr, int startPos)` 
基本原理同--



##### 另附
`String 的 split(String regex)`   方法的用法
如果我们需要把某个字符串拆分为字符串数组，则通常用 split(String regex) 来实现。例如：

```java
String str = "aa,bb,cc,dd";     
String[] strArray = str.split(",");      
System.out.println(strArray.length);     
  for (int i = 0; i < strArray.length; i++) {     
       System.out.println(strArray[i]);     
}  
```

结果为：

```java
4
aa
bb
cc
dd 
```

如果，
`String str = "aa.bb.cc.dd";`
`String[] strArray = str.split("."); `
则结果为：0
为什么结果不是我们所想的呢，原因是参数 String regex 是正则表达式 (regular expression) 而不是普通字符串，而 "." 在正则表达式中有特殊含义，表示匹配所有单个字符。如果要那样拆分，我们必须给 "." 进行转义，String[] strArray = str.split(".") 修改为 String[] strArray = str.split("\\.") 即可。
另外有关 StringUtils 的详细 API 请参见[官方网站](http://commons.apache.org/lang/api-release/index.html)



ref:

1.[StringUtils工具类的常用方法](http://www.cnblogs.com/huaxingtianxia/p/5752041.html),   2.[关于对java字符串进行常用处理转换的工具类StringUtils示例&总结](http://www.xwood.net/_site_domain_/_root/5870/5874/t_c264606.html),   3.[StringUtils类使用](http://www.cnblogs.com/Apollo/archive/2006/03/11/347929.html)
