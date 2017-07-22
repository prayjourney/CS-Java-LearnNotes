#####1.日期####
日期：主要使用的是*java.util.Date* 以及*java.sql.Date* ,
sql中的Date是util中Date的子类，关系如下，但是如果直接转换的话会出现Cast转换错误。
 - java.lang.Object
   - java.util.Date
     - java.sql.Date

之间的转换可以通过如：
`
java.util.Date utildate=new java.util.Date(System.getCurrentTime());
java.sql.Date  sqldate=new java.sql.Date(utildate.getTime());
`
这种方式来转换，
由于sql.Date是util.Date的子类，所以可以直接将sql.Date赋值给util.Date

2.日期和字符串
日期和字符串之间的转换，主要是通过SimpleDateFormat类来完成的，之间的关系如下：
- java.lang.Object
  - java.text.Format
    - java.text.DateFormat
      - java.text.SimpleDateFormat

DateFormat是一个抽象的类，直接子类是SImpleDateFormat类，在使用其时，需要首先指定所要转换的日期/字符串的类型，也就是转换的规则，包括字符串--->日期和
日期--->字符串两种情况，如下：
`
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-mm-dd");
SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-mm-dd hh:MM:ss");
`
一个包括时间，前者不包括时间。
SimpleDateFormat对于字符串和日期转换的两个重要方法是format()和parse();

**format():日期转成字符串。
parse();字符串转成日期**。

