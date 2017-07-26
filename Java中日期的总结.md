#####1.日期

日期：主要使用的是*java.util.Date* 以及*java.sql.Date* ,

sql中的Date是util中Date的子类，关系如下，但是如果直接转换的话会出现Cast转换错误。

 - java.lang.Object
   - java.util.Date
     - java.sql.Date

之间的转换可以通过如：

```java
java.util.Date utildate=new java.util.Date(System.getCurrentTime());
java.sql.Date  sqldate=new java.sql.Date(utildate.getTime());
```

这种方式来转换，由于sql.Date是util.Date的子类，所以可以直接将sql.Date赋值给util.Date.

##### 2.日期和字符串
日期和字符串之间的转换，主要是通过SimpleDateFormat类来完成的，之间的关系如下：
- java.lang.Object
  - java.text.Format
    - java.text.DateFormat
      - java.text.SimpleDateFormat

DateFormat是一个抽象的类，直接子类是SImpleDateFormat类，在使用其时，需要首先指定所要转换的日期/字符串的类型，也就是转换的规则，包括字符串--->日期和

日期--->字符串两种情况，如下：
```java
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-mm-dd");
SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-mm-dd hh:MM:ss");
```
一个包括时间，前者不包括时间。
==*SimpleDateFormat对于字符串和日期转换的两个重要方法是format()和parse()*==;

**format():日期转成字符串**。
**parse();字符串转成日期**。
**SimpleDateFormat**类的方法除了prase()之外，format()方法对于java.sql.Date和java.util.Date都是适用的。

##### 3.时间
==java.time==是jdk1.8之中新增的时间包，提供了日期和时间一致性的处理。
在Java中，现有的与日期和时间相关的类存在诸多问题，其中有：
- Java的日期/时间类的定义并不一致，在java.util和java.sql的包中都有日期类，此外用于格式化和解析的类在java.text包中定义。
- java.util.Date同时包含日期和时间，而java.sql.Date仅包含日期，将其纳入java.sql包并不合理。另外这两个类都有相同的名字，这本身就是一个非常糟糕的设计。
对于时间、时间戳、格式化以及解析，并没有一些明确定义的类。对于格式化和解析的需求，我们有java.text.DateFormat抽象类，但通常情况下，SimpleDateFormat类被用于此类需求。
- 所有的日期类都是可变的，因此他们都不是线程安全的，这是Java日期类最大的问题之一。
- 日期类并不提供国际化，没有时区支持，因此Java引入了java.util.Calendar和java.util.TimeZone类，但他们同样存在上述所有的问题。

新的API的优点：
- 不变性：新的日期/时间API中，所有的类都是不可变的，这对多线程环境有好处。
关注点分离：新的API将人可读的日期时间和机器时间（unix timestamp）明确分离，它为日期（Date）、时间（Time）、日期时间（DateTime）、时间戳（unix timestamp）以及时区定义了不同的类。
- 清晰：在所有的类中，方法都被明确定义用以完成相同的行为。举个例子，要拿到当前实例我们可以使用now()方法，在所有的类中都定义了format()和parse()方法，而不是像以前那样专门有一个独立的类。为了更好的处理问题，所有的类都使用了工厂模式和策略模式，一旦你使用了其中某个类的方法，与其他类协同工作并不困难。
- 实用操作：所有新的日期/时间API类都实现了一系列方法用以完成通用的任务，如：加、减、格式化、解析、从日期/时间中提取单独部分，等等。
- 可扩展性：新的日期/时间API是工作在ISO-8601日历系统上的，但我们也可以将其应用在非IOS的日历上。

新的API
- java.time包：这是新的Java日期/时间API的基础包，所有的主要基础类都是这个包的一部分，如：LocalDate, LocalTime, LocalDateTime, Instant, Period, Duration等等。所有这些类都是不可变的和线程安全的，在绝大多数情况下，这些类能够有效地处理一些公共的需求。
- java.time.format包：这个包包含能够格式化和解析日期时间对象的类，在绝大多数情况下，我们不应该直接使用它们，因为java.time包中相应的类已经提供了格式化和解析的方法。
- java.time.temporal包：这个包包含一些时态对象，我们可以用其找出关于日期/时间对象的某个特定日期或时间，比如说，可以找到某月的第一天或最后一天。你可以非常容易地认出这些方法，因为它们都具有“withXXX”的格式。
- java.time.zone包：这个包包含支持不同时区以及相关规则的类。

重要的类
1.LocalDate，没有时区信息的日期，是一个不可变的日期对象，默认形式为==2007-12-03==.
> A date without a time-zone in the ISO-8601 calendar system, such as 2007-12-03.
LocalDate is an immutable date-time object that represents a date, often viewed as year-month-day. Other date fields, such as day-of-year, day-of-week and week-of-year, can also be accessed. For example, the value "2nd October 2007" can be stored in a LocalDate.

继承层次如下：
>- java.lang.Object
   - java.time.LocalDate


常用的方法(部分):

| 返回值类型 |方法体  |  说明 |
|--------|--------|--------|
| int | compareTo(ChronoLocalDate other) | Compares this date to another date.         |
|boolean|equals(Object obj)|Checks if this date is equal to another date.
| String | format(DateTimeFormatter formatter) |Formats this date using the specified formatter.|
|int|	getDayOfMonth()| Gets the day-of-month field.|
|DayOfWeek | getDayOfWeek() | Gets the day-of-week field, which is an enum DayOfWeek. |
| int |	getDayOfYear() | Gets the day-of-year field. |
| LocalDate | withDayOfMonth(int dayOfMonth) |Returns a copy of this LocalDate with the day-of-month altered. |
|LocalDate | withYear(int year) | Returns a copy of this LocalDate with the year altered. |
| String | toString() | Outputs this date as a String, such as 2007-12-03. |
| static LocalDate | of(int year, int month, int dayOfMonth) | Obtains an instance of LocalDate from a year, month and day. |
| static LocalDate | of(int year, Month month, int dayOfMonth) | Obtains an instance of LocalDate from a year, month and day. |
| boolean | isAfter(ChronoLocalDate other) | Checks if this date is after the specified date. |
| boolean |	isBefore(ChronoLocalDate other) | Checks if this date is before the specified date. |
| boolean | isEqual(ChronoLocalDate other) | Checks if this date is equal to the specified date. |
| boolean | isLeapYear() |Checks if the year is a leap year, according to the ISO proleptic calendar system rules. |

2.LocalTime，没有时区信息的时间，是一个不可变的时间对象，默认形式为==10:15:30==.
> A time without a time-zone in the ISO-8601 calendar system, such as 10:15:30.
LocalTime is an immutable date-time object that represents a time, often viewed as hour-minute-second. Time is represented to nanosecond precision. For example, the value "13:45.30.123456789" can be stored in a LocalTime.

继承层次如下：
>- java.lang.Object
   - java.time.LocalTime

3.LocalDateTime，没有时区信息的日期时间，是一个不可变的日期时间对象，默认形式为==2007-12-03T10:15:30==.
> A date-time without a time-zone in the ISO-8601 calendar system, such as 2007-12-03T10:15:30.
LocalDateTime is an immutable date-time object that represents a date-time, often viewed as year-month-day-hour-minute-second. Other date and time fields, such as day-of-year, day-of-week and week-of-year, can also be accessed. Time is represented to nanosecond precision. For example, the value "2nd October 2007 at 13:45.30.123456789" can be stored in a LocalDateTime.

需要说明的是，以上的三个类之间相同点很多，而且其实现了==Comparable< ChronoLocalDateTime< ?>>==接口，可以通过before,after或者compaterTo方法比较时间，日期等,
##### 4.时间，日期之间的大小比较
主要分为java.util.Date类和java.time这两个区分，前者通过getTime()取得long值相减而得出，还有before()和after()两个方法，后者通过也可以通过getLong()来相减比较，也可以通过isAfter(), isBefore(), isEqual()等方法来得出，还有就是通过compareTo()方法来获得结果。

##### 5.Joda Time

##### 6.案例Demo

==*UseOldDate.java*==
```java
    package DateAndTime;

    import java.text.ParseException;
    import java.text.SimpleDateFormat;
    import java.util.Date;

   /**
    * Created by renjiaxin on 2017/7/26.
    */
    public class UseOldDate {
    public static void main(String[] args) throws ParseException {
        String str1 = "1992-09-12";
        String str2 = "2008-12-13 12:14:22";
        SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY-mm-dd");
        SimpleDateFormat sdf2 = new SimpleDateFormat("YYYY-mm-dd hh:MM:ss");
        Date date1 = sdf1.parse(str1);//从字符串提取时间
        Date date2 = sdf2.parse(str2);
        Date date3 = new Date();//取得当前时间
        String str3=sdf2.format(date3);
        Date date4 = new java.sql.Date(date1.getTime());//java.sql.Date是java.util.Date子类型
        java.sql.Date date5 = new java.sql.Date(date1.getTime());//创建java.sql.Date类型的时间
        String str4=sdf2.format(date5);//时间格式化为字符串
        Date date6=date5;//java.sql.Date是java.util.Date子类型
        //java.sql.Date date7=sdf1.parse(str1);//无法直接使用从字符串提取时间赋值给java.sql.Date类型
        System.out.println(date1);
        System.out.println(date2);
        System.out.println(date3);
        System.out.println(date4);
        System.out.println(date5);
        System.out.println(date6);
        System.out.println("time is :"+str3+".");
        System.out.println("time is :"+str4+".");
    }
  }
```

==*UseNewTime.java*==
```java
    package DateAndTime;

    import java.text.ParseException;
    import java.text.SimpleDateFormat;
    import java.time.*;
    import java.time.format.DateTimeFormatter;
    import java.util.Date;

   /**
    * Created by renjiaxin on 2017/7/26.
    */
    public class UseNewTime {
    public static void main(String[] args) throws ParseException {
        //LocalDate
        LocalDate localDate1=LocalDate.of(1992, Month.FEBRUARY,12);//定义日期
        LocalDate localDate2=LocalDate.of(2009,6,12);
        LocalDate localDate3=LocalDate.ofYearDay(2017,118);
        LocalDate localDate4=LocalDate.now();//当前时间
        System.out.println(localDate1);
        System.out.println(localDate2);
        System.out.println(localDate3);
        System.out.println(localDate4);
        localDate2=localDate2.withDayOfYear(234);//修改日期
        System.out.println(localDate2);
        String str1="2016-09-09";
        LocalDate localDate5=LocalDate.parse(str1);
        String str2=localDate5.format(DateTimeFormatter.ISO_LOCAL_DATE);//格式化类型,要求str1日期是两位数的
        System.out.println("str2:"+str2);
        //LocalDateTime
        LocalDateTime localDateTime1=LocalDateTime.of(2008,5,12,12,24);
        LocalDateTime localDateTime2=LocalDateTime.now();
        LocalDateTime localDateTime3=localDateTime1.plusMonths(24);
        LocalDateTime localDateTime4=localDateTime2.withDayOfYear(112);
        LocalDate localDate6=localDateTime1.toLocalDate();//LocalDateTime转LocalDate
        boolean isLeapYear=localDate6.isLeapYear();//平年测试
        int day=localDateTime1.getDayOfYear();//day of year
        DayOfWeek dw=localDate6.getDayOfWeek();//day of week
        String str3=localDateTime3.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String str4=localDateTime4.toString();
        System.out.println(localDateTime1);
        System.out.println(localDateTime2);
        System.out.println(localDateTime3);
        System.out.println(localDateTime4);
        System.out.println(localDate6);
        System.out.println("str3:"+str3);
        System.out.println("str4:"+str4);
        System.out.println("isLeapYear:"+isLeapYear+",day:"+day+",dw:"+dw);
        //LocalTime
        LocalTime localTime1=LocalTime.MAX;
        LocalTime localTime2=LocalTime.now();//当前时间
        LocalTime localTime3=LocalTime.of(12,24,36);//创建时间
        int secondOfDay=localTime3.toSecondOfDay();//一天中的第几秒钟。
        String str5=localTime3.toString();
        String str6=localTime3.format(DateTimeFormatter.ISO_LOCAL_TIME);
        boolean isAfter=localTime3.isAfter(localTime2);//比较时间大小
        int comTime=localTime3.compareTo(localDateTime2.toLocalTime());//转换，并比较时间
        System.out.println(localTime1);
        System.out.println(localTime2);
        System.out.println(localTime3);
        System.out.println("secondOfDay:"+secondOfDay);
        System.out.println("str5:"+str5);
        System.out.println("str5:"+str5);
        System.out.println("isAfter:"+isAfter);
        System.out.println("comTime:"+comTime);

        //新旧的转化，还是要化成正规默认的样式，才便于进行。
        String temp=localDate1.format(DateTimeFormatter.ISO_DATE);
        SimpleDateFormat sdf=new SimpleDateFormat("YYYY-MM-DD");
        java.util.Date oldDate1=sdf.parse(temp);//转换
        java.util.Date oldDate2=new Date();
        //LocalDate localDate7=LocalDate.parse(sdf.format(oldDate2));//转换,此处有问题
        System.out.println("temp:"+temp);
        System.out.println("oldDate1:"+oldDate1);
        System.out.println("oldDate2:"+oldDate2);
        //System.out.println("localDate7:"+localDate7);
    }
  }
```

==*TimeCompare.java*==
```java
    package DateAndTime;

    import java.text.ParseException;
    import java.text.SimpleDateFormat;
    import java.time.LocalDate;
    import java.time.LocalDateTime;
    import java.util.Date;

    /**
    * Created by renjiaxin on 2017/7/26.
    */
    public class TimeCompare {
    public static void main(String[] args) throws ParseException {
        /**旧的类**/
        //getTime()
        Date date1 = new Date();
        String str1 = "2012-09-08";
        SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY-MM-DD");
        long d1 = date1.getTime();
        Date date2=sdf1.parse(str1);
        long d2 = date2.getTime();

        boolean isBig;
        if (d1 - d2 > 0) {
            isBig= true;
        } else {
            isBig = false;
        }
        System.out.println(date1+" is bigger than "+ date2+":"+isBig);
        //before(),after()
        boolean isBefore=date1.after(date2);
        System.out.println(date1+" is before than "+ date2+":"+isBefore);
        /*新的类*/
        //isAfter()
        LocalDate localDate1=LocalDate.now();
        LocalDate localDate2=LocalDate.of(1999,9,9);
        LocalDate localDate3=LocalDate.of(1999,9,8);
        boolean isAfter=localDate1.isAfter(localDate2);
        localDate3.plusDays(1);
        boolean isEqual=localDate2.isEqual(localDate3);
        System.out.println(isAfter+" ,"+ isEqual);

        //compareTo()
        LocalDateTime localDateTime1=LocalDateTime.now();
        LocalDateTime localDateTime2=LocalDateTime.of(2016,3,6,12,25,56);
        int com=localDateTime1.compareTo(localDateTime2);
        System.out.println(com+" .");

    }
  }
```


ref:
[java中Date与String的相互转化](http://blog.csdn.net/woshisap/article/details/6742423/),
[java日期比较，日期计算](http://www.cnblogs.com/xu-lei/p/5881899.html),
[Java8 日期/时间（Date Time）API指南](http://www.importnew.com/14140.html)
