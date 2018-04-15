### JavaScript基础
***
##### 一、JavaScript基础

1．最新标准版本

```
ECMAScript 6.0版本
```

2．Java与JavaScript的关系

```
a.Java是属于后台语言，JavaScript属于脚本
b.Java是属于面向对象语言，JavaScript是基于对象语言
c.Java是属于强变量类型语言，JavaScript属于弱变量类型
    强类型语言，也称为强类型定义语言。一种总是强制类型定义的语言，要求变量的使用要严格符合定义，所有变量都必须先定义后使用。
    java、.NET、C++、python等都是强制类型定义的。
    也就是说，一旦一个变量被指定了某个数据类型，如果不经过强制转换，那么它就永远是这个数据类型了。
    例如你有一个整数，如果不显式地进行转换，你不能将其视为一个字符串。
    与其相对应的是弱类型语言：数据类型可以被忽略的语言。
    它与强类型定义语言相反, 一个变量可以赋不同数据类型的值。
```

3．JavaScript的组成

```
JavaScript = ECMAScript + DOM + BOM
a.ECMAScript：基本的语法
ECMA欧洲计算机制造联合会（European Computer Manufactures Association）
规定了基本的规则/语法，如何让代码更简单，扩展性更强
b.DOM：Document Object Model 文档对象模型（操作标签）
c.BOM：Browser Object Model  浏览器对象模型（有兼容问题，较少用）
```

##### 二、变量

1.定义变量

```
使用var操作符
变量先声明后使用
a.使用局部变量性能优于全局变量
    局部变量可以尽可能规避命名冲突
b.全局变量
    必须要在赋值语句被运行之后，才可以对全局变量进行输出等操作，否则即便有开辟空间都为undefined
```

2.JavaScript与Java的变量不同点

```
JavaScript的变量为弱变量，可以用来保存任何类型的数据。
Java的变量为强变量，只能用来存储声明的变量类型的数据。
```

3.标识符

```
a.什么是标识符
    标识符，指的是变量、函数、属性的名字，或者函数的参数。
b.标识符命名规范
    1)以数字、字母、美元符$、下划线组成，但是不能以数字开头
    2)区分大小写
    3)不能含有空格
    4)不能含有关键字与保留字命名
        关键字、保留字：
        关键字可用于表示控制语句的开始或结束，或者用于执行特定操作等。按照规则，关键字也是语言保留的，不能用作标识符。
```

```
break   do  instanceof  typeof
case    else    new var
catch   finally return  void
continue    for switch  while
function    this    with    default
if  throw   delete  in
try 
```

保留字有可能在将来被用作关键字来使用。 

```
throws  const   goto    private
final   native  class   float
extends long    super   char
export  interface   static  byte
abstract    int short   boolean
double  import  public   
```

```
c.标识符命名推荐
    1)小驼峰命名法
    （多个英文单词组成一个表示符号名称，除了首个单词之外，所有单词的首字母大写，例如userName）
    2)对属性/变量 —— 要求名词开头
    3)对方法/函数 —— 要求动词开头
    4)常量 —— 全部大写，多个单词之间用下划线分隔。
        例如： var MAX_VALUE = 1000000;
        构造函数 —— 大驼峰（所有单词的首字母大写）
        构造函数为JS自己定义的函数，如Math()、Date()。

d.命名冲突的解决方法
    1)协调命名法 —— 开发人员之间商量用开发人员名称或页面名称命名，例如userName_cl、    userName_index
    2)对象命名空间
```

```
    <script type="text/javascript">
            var userName = "陈立";
            var people = {
                userName: "南佳欣",
                showInfo: function() {
                    // 对象.属性
                    console.log(people.userName);
                }
            }
    </script>
```

```
    // 对象.方法
    <script type="text/javascript">
        console.log(people.showInfo());
        people.showInfo()
        console.log(userName);
    </script>
```

3)匿名函数

```
// 可用来解决命名冲突
// 例如：
var year = 2016;
(function() {
    var year = 2015;
    console.log(year);
})();
console.log(year)
```

##### 三、math对象

1.math是属于谁的对象

```
math是JavaScript内置对象
```

2.绝对值

```
定义和用法
abs() 方法可返回数的绝对值。
语法
Math.abs(x)
参数  描述
x       必需。且必须是一个数值。
返回值
x 的绝对值。
```

3.随机数

```
a.随机数的产生范围：返回0~1之间的随机数，但是不包括0和1
b.去随机数方法：
    Math.floor(Math.random() * 可能的总数 + 第一个可能出现的值)
```

```
    // 如何产生0~15的随机数，包括0和15？
    console.log(Math.floor(16 * Math.random()));
    // 如何产生3~15的随机数，包括3~15
    console.log(Math.floor(3 + +13 * Math.random()));
```

4.舍入取整

```
a.Math.ceil();  它将数值向上舍入为最接近的整数
```

```
Math.ceil(0.6);
1
Math.ceil(-0.1);
-0
```

```
b.Math.floor(); 它将数值向下舍入为最接近的整数
```

```
Math.floor(-0.6);
-1
Math.floor(0.6);
0
```

c.Math.round(); 它将数值四舍五入为最接近的整数

5.随机产生去重数组 
<http://www.h5course.com/a/2015042747.html>

##### 四、常见JS数据类型

1．常见数据类型是什么？

```
a.Undefined —— 变量的值未定义（存在变量，没有赋值）
b.Null —— 空对象，如设定一个变量，需要存储变量数据，但现未存储，即可先定义为null，例如var userName = null;
c.String —— 字符串（单引号和双引号没有区别），例如var userName = "字符串";
d.Number —— 数字
e.Boolean —— 布尔值（true/false）
f.Object —— JavaScript里面{}代表对象，[]代表数组，()代表提升运算符的优先级
```

2．各数据类型的基本概念

```
a.Undefined
    1)变量的值未定义（存在变量，没有赋值）
    2)数据类型为undefined，且未定义的变量是可以被typeof()输出变量类型为undefined
    3)声明了变量但未进行赋值，会自动被赋值为undefined
    4)undefined进行任何数学运算，均得到NaN：not a number
    5)undefined使用Number()转换为数字，所得结果为NaN
```

```
console.log(typeof undefined);          // undefined
console.log(typeof(typeof undefined));      // string（数据类型本身为一个字符串）
console.log(undefined == undefined);        // 输出true
console.log(undefined === undefined);       // 输出true
console.log(undefined + 2);             // 输出NaN
console.log(undefined - 2);             // 输出NaN
console.log(undefined * 2);             // 输出NaN
console.log(undefined / 2);             // 输出NaN
console.log((undefined * 2) == NaN);        // 输出false（NaN与任何值（包括它本身），都不相等）
console.log((undefined * 2) != NaN);        // 输出true
console.log(Number(undefined));         // 输出NaN
var a;
console.log(a);                         // 输出undefined
console.log(a * 4);                     // 输出NaN
```

```
b.Null
    1)空对象，如设定一个变量，需要存储变量数据，但现未存储，即可先定义为null，例如var userName = null;
    2)数据类型为object
    3)用来保存对象的变量，还没有真正保存对象，就可以设置为null。
    4)null在进行+-*/%数学运算时，起到的效果与0相同，但其本身不等于0。
    5)null与undefined的关系
```

```
console.log(null == undefined);         // 输出true
console.log(null === undefined);            // 输出false
console.log(null != undefined);         // 输出false
console.log(null !== undefined);            // 输出true

console.log(typeof null);                   // 输出object
console.log(typeof(typeof null));           // 输出string
var a = null;
console.log(a);                         // 输出null
console.log(typeof a);                  // 输出object
console.log(null == null);              // 输出true
console.log(null === null);             // 输出true
console.log(null == 0);                 // 输出false
console.log(null + 100);                    // 输出100
console.log(null - 100);                    // 输出 -100
console.log(null * 100);                    // 输出0
console.log(null / 100);                    // 输出0
console.log(null % 100);                    // 输出0
console.log(-null % 100);               // 输出 -0
```

```
c.String
    1)字符串（单引号和双引号没有区别），例如var userName = "字符串";
    2)数字字符串除了+之外，基本能进行数学运算
    3)+会将数字字符串与其他类型变量连接起来
    4)-*/都可以将数字字符串隐式转换为数字类型
    5)%也可以进行数字字符串到数字的隐式转换，但无法保留原来的值
```

```
console.log("" == '');                  // 输出true（单引号和双引号没有区别）
console.log("" === '');                 // 输出true
console.log(" " == ' ');                    // 输出true
console.log(" " === ' ');                   // 输出true
console.log(" " == "");                 // 输出false
```

```
    数字字符串的计算：
```

```
var a = "123";
console.log(typeof a);                  // 输出string
console.log(123 + a);                   // 输出123123
console.log(typeof (123 + a));          // 输出string
console.log(123 - a);                   // 输出0
console.log(typeof (123 - a));              // 输出number
console.log(123 * a);                   // 输出15129
console.log(typeof (123 * a));              // 输出number
console.log(123 / a);                   // 输出1
console.log(typeof (123 / a));              // 输出number
console.log(a % 1);                     // 输出0
console.log(typeof (a % 1));                // 输出number
console.log(typeof("123" - 0));         // 输出123
console.log(typeof("123" - 0));         // 输出number
console.log("123" == 123);              // 输出true
console.log("123" === 123);             // 输出false
console.log("123" - 456);               // 输出-333
console.log("123" - "456");             // 输出-333
console.log("123" * "456");             // 输出56088
```

```
d.Number —— 数字
    1)小数进行+-*/操作，均有可能输出多余位数的小数，即使本身数学上的计算可以除尽。
    2)取余操作时，但被除数小余除数时，取余结果为被除数本身，并且结果不会出现多余位数的小数
    3)取余操作时，若除数为0，则结果为NaN
    4)取余操作时，若被除数为小数，则有可能输出多余位数的小数（未找到合理的取余结果规律）
    5)取余操作时，输出结果的符号和被除数一样，与除数无关
    6)数字 / 0等于无穷大，符号根据计算结果而定。
    7)0 / 0等于NaN
    8)Infinity和NaN也属于number类型
    9)任何设计NaN的操作都会返回NaN，NaN与任何值（包括它本身），都不相等
```

```
// +-*/运算规则
console.log(2.2 + 2.2);                 // 输出4.4
console.log(2.2 + 2.1);                 // 输出4.300000000000001
console.log(0.5 + 0.4);                 // 输出0.9
console.log(0.2 + 0.4);                 // 输出0.6000000000000001
console.log(2.9 - 2.4);                 // 输出0.5
console.log(2.5 -2.4);                  // 输出0.10000000000000009
console.log(0.9 - 0.5);                 // 输出0.4
console.log(0.7 - 0.5);                 // 输出0.19999999999999996
console.log(2.2 * 2.4);                 // 输出5.28
console.log(2.9 * 2.7);                 // 输出7.83
console.log(1.9 * 0.7);                 // 输出1.3299999999999998
console.log(0.6 * 0.4);                 // 输出0.24
console.log(0.2 * 0.4);                 // 输出0.08000000000000002
console.log(2.2 / 4.4);                 // 输出0.5
console.log(2.8 / 3.2);                 // 输出0.8749999999999999
console.log(0.2 / 0.4);                 // 输出0.5
console.log(0.7 / 0.8);                 // 输出0.8749999999999999
console.log(2 / 0);                     // 输出infinity
console.log(-2 / 0);                        // 输出-infinity
console.log(2 / -0);                        // 输出-infinity
console.log(-2 / -0);                       // 输出infinity
console.log(0 / 0);                     // 输出NaN

// %运算规则
console.log(-2 % 4);                    // 输出-2
console.log(2 % -4);                    // 输出2
console.log(0.2 % 2);                   // 输出0.2
console.log(-0.3 % 5);                  // 输出-0.3
console.log(2 % 0);                     // 输出NaN
console.log(0.2 % 0);                   // 输出NaN
console.log(2 % 0.2);                   // 输出0.1999999999999999
console.log(2 % 0.8);                   // 输出0.3999999999999999
console.log(2 % 0.5);                   // 输出0
console.log(2 % 0.6);                   // 输出0.20000000000000007
console.log(2 % 0.1);                   // 输出0.0999999999999999

// NaN运算规则
console.log(typeof NaN);                // 输出number
console.log(typeof Infinity);               // 输出number
console.log(NaN == NaN);                // 输出false
console.log(NaN != NaN);                // 输出true
console.log(NaN === NaN);               // 输出false
console.log(NaN + 100);                 // 输出NaN
console.log(NaN - 100);                 // 输出NaN
console.log(NaN * 100);                 // 输出NaN
console.log(NaN / 100);                 // 输出NaN
console.log(NaN % 100);             // 输出NaN
console.log(-NaN % 100);                // 输出NaN
console.log(NaN == 0);                  // 输出false
```

```
e.Boolean —— 布尔值（true/false）
    1)布尔值在进行+-*/%数学运算时，true代表1，false代表0，并且计算后的数据类型为number。
    2)1 == true为真，1 === true为假
    3)0 == false为真，0 === false为假
```

```
console.log(true + 1);                  // 输出2
console.log(true - 1);                  // 输出0
console.log(true * 20);                 // 输出20
console.log(true / 20);                 // 输出0.05
console.log(true % 2);                  // 输出1
console.log(typeof (true + 1));         // 输出number
console.log(false + 200);                   // 输出200
console.log(false - 200);                   // 输出-200
console.log(false * 200);                   // 输出0
console.log(false / 200);                   // 输出0
console.log(typeof (false + 200));          // 输出number
console.log(false % 2);                 // 输出0
console.log(1 / false);                 // 输出Infinity
console.log(typeof (1 / false));            // 输出number
```

```
f.Object —— JavaScript里面{}代表对象，[]代表数组，()代表提升运算符的优先级
    对象不等于对象，与自身相比时除外
    当object对象进行+运算时，会将对象和其他数据组合在一起，类似字符串的+运算，输出的数据类型为string
    当object对象进行-*/%运算时，输出结果为NaN，数据类型为number
```

```
var con = document.getElementById("conBox");
console.log(con);                       // 输出<div class="wrap" id="conBox">HTML5学堂</div>
console.log(con == con);                // 输出true
console.log(con === con);               // 输出true
console.log(con + 3);                   // 输出[object HTMLDivElement]3
console.log(typeof (con + 3))               // 输出string
console.log(con + undefined);           // 输出[object HTMLDivElement]undefined
console.log(typeof (con + undefined))       // 输出string
console.log(con + null);                    // 输出[object HTMLDivElement]null
console.log(typeof (con + null));           // 输出string
console.log(con + true);                    // 输出[object HTMLDivElement]true
console.log(typeof (con + true));           // 输出string
console.log(con + "a");                 // 输出[object HTMLDivElement]a
console.log(typeof (con + "a"));            // 输出string
console.log({});                        // 输出Object {}
console.log({} + con);                  // 输出[object Object][object HTMLDivElement]
console.log(con + con);                 // 输出[object HTMLDivElement][object HTMLDivElement]
console.log(typeof (con + con));            // 输出string
console.log({} + 3);                    // 输出[object Object]3
console.log(typeof ({} + 3));               // 输出string
console.log({} - 3);                        // 输出NaN
console.log(typeof ({} - 3));               // 输出number
console.log({} * 3);                        // 输出NaN
console.log(typeof ({} * 3));               // 输出number
console.log({} / 3);                        // 输出NaN
console.log(typeof ({} / 3));               // 输出number
console.log({} % 3);                    // 输出NaN
console.log(typeof ({} % 3));               // 输出number
```

3．数据类型自身的布尔值关系

```
a.布尔值
```

```
var judge = true;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出true
var judge = false;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出false
```

```
b.字符串
```

```
var judge = "a";
var judge = "5";
var judge = "0";
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出true
var judge = "";
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出false
```

```
c.数字
```

```
var judge = 5;
var judge = 1;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出true
var judge = 0;
var judge = NaN;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出false
```

```
d.对象（null的数据类型也是对象）
```

```
<div class="wrap" id="conBox">HTML5学堂</div>
<script>
var con = document.getElementById("conBox");
if (con) {
    console.log("true");
} else {
    console.log("false");
}
</script>
// 输出true;
var judge = null;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出false
```

```
e.undefined
```

```
var judge;
if (judge) {
    console.log("true");
} else {
    console.log("false");
}
// 输出false
```

4．数据类型的转换

```
a.显式转换
    数字字符串 → 为数字：
    显示转换应用速度快，好理解，不易出错，推荐使用
    1)parseInt()
        ①　parseInt()只能转换整数，若转换的数字中有小数，则会忽略小数，直接输出整数
        ②　parseInt()若转换的字符串中，数字之后有字母、运算符或空格等字符时，则不会再输出字符及其之后的数字。
        ③　parseInt('a',b)该写法表示将a做为b进制数计算，输出10进制数。
            b的取值为0和2≤b≤36的整数，b为0时输出a本身，因为数字的取值最大为英文字母z，即为36
        ④　parseInt()转换的字符串，第一个字符除空格、+、-符号外，都不能转换成数字，将返回NaN
        ⑤　parseInt()转换的字符串，若最前面字符为空格（不限数量），则忽略
        ⑥　parseInt()转换的字符串，若第一个字符为+，则输出正数
        ⑦　parseInt()转换的字符串，若第一个字符为-，则输出负数
        ⑧　parseInt()将undefined、null、true、false转换为数值，只能输出NaN
        ⑨　parseInt()将空字符串转换为数值，只能输出NaN
        ⑩　十六进制输出：
```

```
        var a = "0x70";
        console.log(typeof parseInt(a));            // 输出number
        console.log(parseInt(a))                    // 输出112
        alert(typeof parseInt(a));                  // IE6、7、8：输出number
        alert(parseInt(a))                          // IE6、7、8：输出112，x代表16进制
```

```
        ⑪　兼容问题：
            0开头字符串在IE8-及以下版本会解析成8进制，其他浏览器则按照10进制正常解析
```

```
        var a = "070";
        console.log(typeof parseInt(a));            // 输出number
        console.log(parseInt(a))                    // 输出70
        alert(typeof parseInt(a));                  // IE6、7、8：输出number
        alert(parseInt(a))                          // IE6、7、8：输出56，因为0开头字符串在           IE8-及以下版本会解析成8进制，其他浏览器则按照10进制正常解析

        // 解决办法：输出类型该为a, 10即可让浏览器用10进制输出
        alert(typeof parseInt(a, 10));              // IE6、7、8：输出number
        alert(parseInt(a, 10))                      // IE6、7、8：输出70

        // parseInt练习
        var a = "234 456";
        console.log(typeof parseInt(a));            // 输出number
        console.log(parseInt(a))                    // 输出234
        var a = "a234 456";
        console.log(typeof parseInt(a));            // 输出number
        console.log(parseInt(a))                    // 输出NaN
        var a = "23a4 456";
        console.log(typeof parseInt(a));            // 输出number
        console.log(parseInt(a))                    // 输出23
        console.log(parseInt('11.958'));            // 输出11
        console.log(parseInt('11aabb11'));          // 输出11
        console.log(parseInt('11 22'));             // 输出11
        console.log(parseInt('11+22'));             // 输出11
        console.log(parseInt('11-22'));             // 输出11
        console.log(parseInt(' 11 '));              // 输出11
        console.log(parseInt('11', 2));             // 输出3
        console.log(parseInt('11', 16));            // 输出17
        console.log(parseInt('11', 21));            // 输出22
        console.log(parseInt('11', 36));            // 输出37
        console.log(parseInt('aa11bb'));            // 输出NaN
        console.log(parseInt(' 11 111'));           // 输出11
        console.log(parseInt('+11'));               // 输出11
        console.log(parseInt('-11'));               // 输出-11
        console.log(parseInt('*11'));               // 输出NaN
        console.log(parseInt('/11'));               // 输出NaN
        console.log(parseInt('=11'));               // 输出NaN
        console.log(parseInt('!11'));               // 输出NaN
        console.log(parseInt('undefined'));         // 输出NaN
        console.log(parseInt('null'));              // 输出NaN
        console.log(parseInt('true'));              // 输出NaN
        console.log(parseInt(undefined));           // 输出NaN
        console.log(parseInt(null));                // 输出NaN
        console.log(parseInt(true));                // 输出NaN
        console.log(parseInt(false));               // 输出NaN
        console.log(parseInt(""));                  // 输出NaN
```

```
    2)parseFloat()
        ①　输出为小数
        ②　parseFloat()可以将小数形式的数字字符串直接输出为小数。
        ③　parseFloat()若转换的字符串中，数字之后有字母、运算符或空格等字符时，则不会再输出字符及其之后的数字。
        ④　parseFloat没有parseFloat('a',b)写法，若使用该写法，b为0时会报错，b不为0时都只会输出a
        ⑤　parseFloat()转换的字符串，第一个字符除空格、+、-符号外，都不能转换成数字，将返回NaN
        ⑥　parseFloat()转换的字符串，若最前面字符为空格（不限数量），则忽略
        ⑦　parseFloat()转换的字符串，若第一个字符为+，则输出正数
        ⑧　parseFloat()转换的字符串，若第一个字符为-，则输出负数
        ⑨　parseFloat()将undefined、null、true、false转换为数值，只能输出NaN
        ⑩　parseFloat()将空字符串转换为数值，只能输出NaN
```

```
        var a = "070";
        console.log(typeof parseFloat(a));          // 输出number
        console.log(parseFloat(a));                 // 输出70
        var a = "5.634646465";
        console.log(typeof parseFloat(a));          // 输出number
        console.log(parseFloat(a));                 // 输出5.634646465
        console.log(parseInt(a));                   // 输出5

        console.log(parseFloat('11.958'));          // 输出11.958
        console.log(parseFloat('11.958aabb11'));    // 输出11.958
        console.log(parseFloat('11.958 22'));       // 输出11.958
        console.log(parseFloat('11+22'));           // 输出11
        console.log(parseFloat('11-22'));           // 输出11
        console.log(parseFloat(' 11 '));            // 输出11
        console.log(parseFloat('11.958', 2));       // 输出11.958
        console.log(parseFloat('aa11bb'));          // 输出NaN
        console.log(parseFloat(' 11 111'));         // 输出11
        console.log(parseFloat('+11'));             // 输出11
        console.log(parseFloat('-11'));             // 输出-11
        console.log(parseFloat('*11'));             // 输出NaN
        console.log(parseFloat('/11'));             // 输出NaN
        console.log(parseFloat('=11'));             // 输出NaN
        console.log(parseFloat('!11'));             // 输出NaN
        console.log(parseFloat('undefined'));       // 输出NaN
        console.log(parseFloat('null'));            // 输出NaN
        console.log(parseFloat('true'));            // 输出NaN
        console.log(parseFloat(undefined));         // 输出NaN
        console.log(parseFloat(null));              // 输出NaN
        console.log(parseFloat(true));              // 输出NaN
        console.log(parseFloat(false));             // 输出NaN
        console.log(parseFloat(""));                // 输出NaN
```

```
    3)Number()
        ①　能够将数字字符串中的小数完整输出
        ②　只要数字字符串中包含了无法转换成数字的字符则会返回NaN
        ③　可将undefined转换为NaN，将null转换为0，将true转换为1，将false转换为0。
            但转换时，undefined、null、true、false不能加引号，否则会被认为是字符串，而默认输出NaN
        ④　可将空字符串转换为0
```

```
        var a = "5.634646465";
        console.log(typeof Number(a));              // 输出number
        console.log(Number(a));                     // 输出5.634646465
        var a = "56787878";
        console.log(typeof Number(a));              // 输出number
        console.log(Number(a));                     // 输出56787878
        var a = "5678 7878";
        console.log(typeof Number(a));              // 输出number
        console.log(Number(a));                     // 输出NaN
        var a = "5678a7878";
        console.log(typeof Number(a));              // 输出number
        console.log(Number(a));                     // 输出NaN
```

```
        console.log(Number('meng520'));             // 输出NaN
        console.log(Number('520meng'));             // 输出NaN
        console.log(Number('1234520'));             // 输出1234520
        console.log(Number('1234520.1234520'));     // 输出1234520.123452
        console.log(Number('undefined'));           // 输出NaN
        console.log(Number('null'));                // 输出NaN
        console.log(Number('true'));                // 输出NaN
        console.log(Number('false'));               // 输出NaN
        console.log(Number(undefined));             // 输出NaN
        console.log(Number(null));                  // 输出0
        console.log(Number(true));                  // 输出1
        console.log(Number(false));                 // 输出0
        console.log(Number(""));                    // 输出0
```

```
数字 → 数字字符串
    1)toString()
        ①　a.toString()可将数字转化为字符串
        ②　a.toString(b)可将a转化为b进制输出，b的取值范围为2≤b≤36，因为输出的值最大为英文字母z，即为36
        ③　a不可用数字直接代替，需要将数字存储在变量中，再使用toString()方法进行转换
```

```
        var a = 10;
        console.log(typeof a.toString());           //输出string
        console.log(a.toString());                  //输出10
        console.log(a.toString(2));                 //输出1010（即a被转化为二进制）
        console.log(a.toString(8));                 //输出12（即a被转化为二进制）
        var a = 22;
        console.log(typeof a.toString());           //输出string
        console.log(a.toString());                  //输出22
        console.log(a.toString(2));                 //输出10110
        console.log(a.toString(8));                 //输出26
        console.log(a.toString(23));                //输出m
        console.log(a.toString(16));                //输出16
```

```
    2)toFixed() 精确小数
        ①　可用来解决运算中出现的出现多位小数问题
        ②　理论上toFixed()方法采用四舍五入来计算。
            实际上某些情况下，即使在Chrome中，四舍五入并不适用。
            如0.855.toFixed(2)，输出为0.85，可以改用Math.round()方法进行计算。
        ③　toFixed()精确小数后，会将数字转换为字符类型输出
        ④　负数进行toFixed(0)运算时，如果结果为0，则会输出-0
        ⑤　若toFixed()中没有参数，则默认为0
        ⑥　toFixed()中的参数取值范围为0~20
        ⑦　toFixed()中的参数大于运算小数的位数时，会用0将缺失的位数补足
        ⑧　进行运算的对象不是Number类型时，会报错
        ⑨　IE兼容问题：
        当传入的值为0的时候，在IE8-中，范围0.5~0.94或者-0.94~-0.5的时候不能正常取舍，计算结果为0
        var a = 0.51
        console.log(a.toFixed(0)); //输出1
        alert(a.toFixed(0)); // IE8-中，输出0
```

```
        var a = 0.2 * 0.4;
                console.log(typeof a);                  //输出number
                console.log(a);                         //输出0.08000000000000002
                console.log(typeof a.toFixed(2));       //输出string
                console.log(a.toFixed(2));              //输出0.08

        var a = 0.854;
        console.log(a.toFixed(2));                      // 输出0.85
        console.log(typeof a.toFixed(2));               // 输出string
        var a = 0.855;
        console.log(a.toFixed(2));                      // 输出0.85
        console.log(typeof a.toFixed(2));               // 输出string
        console.log(((Math.round(a * 100)) / 100));                     //输出 0.86
        console.log(typeof (((Math.round(a * 100)) / 100)));            //输出 number
        console.log(Math.round(-0.5));                  // 输出-0
        var a = 0.555;
        console.log(a.toFixed(2));                      // 输出0.56
        console.log(typeof a.toFixed(2));               // 输出string
        console.log(-0.2.toFixed(0));                   // 输出-0
```

```
b.隐式转换
    没有使用一些方法，而采用操作符、数字、字符串的特点进行转换
    运行速度慢，平时不用，但编写时要注意不要因此出问题。
    1)数字 → 数字字符串
        （数字 + 字符串、字符串 + 字符串） + 连接符
        +两边都是数字 + 数学运算的加法
```

```
    var a = 10;
        console.log(typeof a);      // 输出 number
        var b = a + "";             // “”空字符串，" "空格字符串
        console.log(typeof b);      // 输出 string
        console.log(b);             // 输出10
        var b = a + " ";
        console.log(typeof b);      // 输出 string
        console.log(b);             // 输出10 
```

```
    2)数字字符串 → 数字
        数字字符串 / 1，数字字符串 * 1，数字字符串 - 0
        %也可以进行数字字符串到数字的隐式转换，但无法保留原来的值
```

```
        var a = "10";
        var b;
        console.log(typeof a);      // 输出 string
        var b = a * 1;              // 输出10
        console.log(typeof b);      // 输出 number
        console.log(b);             // 输出10
        var b = a / 1;
        console.log(typeof b);      // 输出 number
        console.log(b);             // 输出10
        var b = a - 0;
        console.log(typeof b);      // 输出 number
        console.log(b);
```

```
    3)扩展知识
        非0的正数除0得到Infinity（无穷大），非0的负数除0得到-Infinity（负无穷大）
```

```
        var a = 10 / 0;
        console.log(a);             //输出Infinity（无穷大）
        console.log(typeof a);      // number
        var a = -10 / 0;
        console.log(a);             //输出-Infinity（无穷大）
        console.log(typeof a);      // number
        // 0除0得到NaN
        var a = 0 / 0;
        console.log(a); // 输出NaN
        console.log(typeof a); // number
```

##### 五、操作符及优先级

1.操作符的优先级

```
a.自增、自减操作符
b.逻辑非操作符
c.算术操作符
d.关系操作符
e.逻辑与
f.逻辑或
g.条件操作符
h.赋值操作符
```

![这里写图片描述](http://img.blog.csdn.net/20170512113112927?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

2.操作符的概念

```
a.函数运算操作符
    函数调用运算符的第一个参数是一个函数名或者是一个引用函数的表达式，其后是括号()。
    括号中间可以是数目不定的运算符，这些运算数可以是任意的表达式，它们之间用逗号隔开。
    函数调用运算符将计算它的每一个运算数，第一个运算数指定为函数名（括号前），而括号中间的所有运算数的值将传递给这个函数作为函数的参数。
```

```
var a = 1;
var b = 2;
var c = 3;
alert(++a, ++b, ++c);       // 输出2，因()为函数运算操作符，所以由左到右运行表达式后，输出第一个表达式的结果
console.log(a);             // 输出2
console.log(b);             // 输出3
console.log(c);             // 输出4
alert((++a, ++b, ++c));     // 输出5，因()提高了内部语句的优先级，所以先计算()内部的语句，因内部语句含有,操作符，则按照,操作符的规则从左到右运行表达式后，输出最后一个表达式的结果。
console.log(a);             // 输出3
console.log(b);             // 输出4
console.log(c);             // 输出5
```

```
b.赋值操作符
    =   +=  -=  *=  /=  %=
    =的特性:
    当出现双等号时，先运行后面的等号，再运行前面的等号
    即a = b = 5时，先运行b = 5，再运行a = b，结果为a = 5，b = 5。

    +=  -=  *=  /=  %=的特性：
    例如：
```

```
        var plus = 100;
        plus *= 100;
        // plus = plus * 100;
```

```
c.算数操作符
    +   -   *   /   %（百分号为取余数）
    + - * / 算法:
```

```
        var minus = 150;
        minus = minus - plus;
        console.log(minus);
```

```
    +加号特性：除了数字之间的+之外，+都被做为连接符使用。
    并且对象、布尔值、undefined、null、字符串之间或与数字相加，结果都为数据的连接，并且输出的数据类型都为string
    %余数特性：余数的符号与被除数的符号保持一致，与除数的符号无关。被除数为0时，计算结果为0，若为-0，计算结果为-0。
```

```
        var remainder;
        remainder = 100 % -3;
        console.log(remainder);
        // 输出值为1
```

```
d.关系操作符
    >   >=  <   <=  ==（相等）  ===（全等） !=（不相等，只对比值，不对比数据类型）    !==（不全等，值和数据类型都对比）
    关系操作符返回的是布尔值（true/false）
    1 == true为真，1 === true为假
    0 == false为真，0 === false为假
    0 == null为假
    运算符的优先级为< <= > >=高于== != === !==
```

```
    var contrast = 100;
    // 定义字符串
    var contrastStr = "100";
    console.log(contrast == contrastStr);
    // == 只要求值相等，输出true
    console.log(contrast === contrastStr);
    // === 不仅要求值相等，而且数据类型也要相等， 输出false
```

```
    console.log(1 > 0 < 1);         // 输出false
    console.log(2 != 2 > 1);        // 输出true
    console.log(0 == 0 > 1);        // 输出true
    console.log(1 == 0 != 1);       // 输出true
    console.log(1 != 1 == 0);       // 输出true
    console.log(1 != 1 !== 0);      // 输出true
    console.log(2 == 0 <= 1);       // 输出false
    console.log(2 <= 0 > -1);       // 输出true
```

```
e.条件操作符
    表达式1 ? 表达式2 : 表达式3
    如果表达式1成立，执行表达式2，否则执行表达式3
```

```
    // 如何判断一个数能被2整除，输出偶数，否则输出奇数
    var condition = 100;
    (condition % 2 == 0) ? console.log("偶数") : console.log("奇数");
```

```
f.逻辑操作符
    &&  ||  !（与 或 非）

    &&与的计算规则：
    1)若&&前面的表达式为false，则不会运行后面的表达式，整个&&表达式输出false。
    2)若&&前面的表达式为true，则运行后面的表达式，并且整个&&表达式的输出结果为后面的表达式中的结果。
    3)若后面的表达式结果为布尔值，则输出相应布尔值。
    4)若后面的表达式结果为计算式结果赋值或者直接赋值，则输出赋值的结果。
```

```
    var a = 2;
    var b = 3;
    c = (a < b) && (a = 5);
    console.log(a);     // 5
    console.log(c);     // 5
    c = (a > b) && (a > b);
    console.log(a);     // 5
    console.log(c);     // true
    c = (a = 2) && (b = 5);
    console.log(a);     // 2
    console.log(c);     // 5
```

```
    ||或的计算规则
        1)如果||前面的表达式成立，则执行前面的表达式，不执行后面的表达式，同时将前面表达式的结果赋值给整个||表达式
        2)如果||前面的表达式不成立，则执行后面的表达式，若后面的表达式成立，则将后面表达式的结果赋值给整个||表达式
        3)若内部表达式结果为布尔值，则输出相应布尔值。
        4)若内部的表达式结果为计算式结果赋值或者直接赋值，则输出赋值的结果。
        5)若两个表达式都为false，则将false赋值给整个||表达式。
        6)若两个表达式的值都为0，则将0赋值给整个||表达式。
        7)若两个表达式一个为0一个为false，则将后面的表达式的结果输出给整个||表达式
```

```
        var a = 2;
        var b = 3;
        c = (a < b) || (a = 5);
        console.log(a);     // 2
        console.log(c);     // true
        c = (a > b) || (a = 4);
        console.log(a);     // 4
        console.log(c);     // 4
        var a = 2;
        var b = 3;
        c = (a = 1) || (b = 6);
        console.log(a);     // 1
        console.log(b);     // 3
        console.log(c);     // 1
        c = (a = 0) || (b = 7);
        console.log(a);     // 0
        console.log(b);     // 7
        console.log(c);     // 7
        var a = 4;
        var b = 3;
        c = (a < b) || (a = 5);
        console.log(a);     // 5
        console.log(c);     // 5
        var a = 0;
        var b = false;
        c = (b) || (a);
        console.log(c);     // 0

        var result = 100;
        // 如何判断一个数大于20小于60
        console.log((20 < result) && (result < 60));
        // false
        console.log((20 < result) || (result < 60));
        // true
        console.log(!((20 < result) || (result < 60)));
        // false
```

```
        // 逻辑操作符的短路操作：如果&&前面的条件不成立，自动不执行后面的表达式；如果||前面的表达式成立，自动不执行后面的表达式
        var num = 10;
        (num > 9) || (num = 100);
        console.log(num);
        // 输出10
        var num = 10;
        (num < 9) || (num = 100);
        console.log(num);
        // 输出100
        var num = 10;
        (num > 9) && (num = 100);
        console.log(num);
        // 输出100
        var num = 10;
        (num < 9) && (num = 100);
        console.log(num);
        // 输出10
```

```
g.自增、自减操作符
    ++  自增操作符
    --  自减操作符
    ++变量名
    1)先自增+1后的结果赋值给该变量后，再根据此结果进行其他计算操作。
    变量名++
    1)表示++之前的第一个操作符（包括=）使用变量的原值，++之后操作符使用原值+1的结果值。
    2)若在同一个算式中，变量++之后还有出现该变量，则之后的变量取值都按原值+1.
    3)因=操作符优先级最低，表示将整个表达式的结果赋值给结果变量。
        =最后运行，自增、自减操作符在赋值之前进行，如此会造成若计算式结果赋值给++变量时，++变量的结果会被计算时覆盖。
    --自减操作符同理
```

```
    var a = 1;
    function show() {
        var b;
        // a = ++a;         // 输出a = 2, b = undefined
        // a = a++;         // 输出a = 1, b = undefined
        // b = a++;         // 输出a = 2, b = 1
        // b = ++a;         // 输出a = 2, b = 2
        // a = a + a++ + 1;     // 输出a = 3, b = undefined
        // b = a + a++ + 1;     // 输出a = 2, b = 3
        // a = a + ++a + 1;     // 输出a = 4, b = undefined
        // b = a + ++a + 1;     // 输出a = 2, b = 4
        // a = a + a++ + a;     // 输出a = 4, b = undefined
        // b = a + a++ + a;     // 输出a = 2, b = 4
        // a = a + ++a + a;     // 输出a = 5, b = undefined
        // b = a + ++a + a;     // 输出a = 2, b = 5
        console.log(a);
        console.log(b);
    }show();
```

```
h., 逗号操作符
    逗号操作符表示最后一个逗号后的值，才会起作用，其他值不起作用。
    1)逗号操作符的计算顺序为从左到右。
    2)逗号操作符的返回值是最右边参数值。
    3)逗号操作符的优先级最低
```

```
    var a = 2;
    var b = 3;
    var n = (a, b);     // 输出3，函数运算操作符()提高了内部表达式的优先级，按逗号运算符规则运算
    console.log(n);
    var n = a, b;
    console.log(n); // 输出2，因=赋值运算符优先级高于逗号运算符，所以n = a看做一个单独的语句被运行。
```

```
    // 逗号操作符
    // 从左到右进行计算，并返回最后一个值
    var a = 10, b = 20;

    function CommaTest(){
        return a++, b++, 10;
    }

    var c = CommaTest();

    console.log(a); // 返回11
    console.log(b); // 返回21
    console.log(c); // 返回10
```

```
    // 逗号操作符与()函数调用操作符的冲突
    var a = 1;
    var b = 2;
    var c = 3;
    alert(++a, ++b, ++c);       // 输出2，因()为函数运算操作符，所以由左到右运行表达式后，输出第一个表达式的结果
    console.log(a);             // 输出2
    console.log(b);         // 输出3
    console.log(c);             // 输出4
    alert((++a, ++b, ++c));     // 输出5，因()提高了内部语句的优先级，所以先计算()内部的语句，因内部语句含有,操作符，则按照,操作符的规则从左到右运行表达式后，输出最后一个表达式的结果。
    console.log(a);             // 输出3
    console.log(b);         // 输出4
    console.log(c);             // 输出5
```

```
    // 逗号操作符和赋值操作符的冲突
    var a = 20;
    var b = ++a, 10;    
    // 逗号运算符要求它的运算数是一个复杂的表达式或简单的表达式（如变量或直接量），但由于赋值运算符优先于逗号运算符执行，因此变成左边不是一个运算数或一个表达式，而是一个含有var关键字的语句。运行时会认为该语句在定义一个变量，而定义变量的值为++a, 10，不是一个数字或字符串，即报错。
    var b = (++a, 10);
    console.log(b);

    var x = 0;
    var y = 0;
    function test() {
        return x = 8*2, x*4; /*整个表达式的值为64，x的值为16*/ 
        return (x = 8 * 2, x * 4), x * 2; /*整个表达式的值为32，x的值为16*/ 
        return x = (y = 5, 5 * 2); /*整个表达式为赋值表达式，它的值为10，x的值为10，y的值为5*/ 
        return x = y = 5, 5 * 2; /*整个表达式为逗号表达式，它的值为10，x和y的值都为5*/ 
    }
    console.log(test());
    console.log(x);
    console.log(y);
```

##### 六、this关键字

1.this是属于谁的属性（对象）

```
this是JavaScript函数内部的属性（对象）
```

2.this的指向问题

```
this指向原则：永远指向它所在函数的所有者，如果没有所有者，则指向window
a.全局中的this指向
    全局中定义的函数，因全局下的函数没有归属，所以指向为window

```

```
    function show() {
        console.log(this);
    }show();
    // 输出window
```

```
b.对象.方法的this指向
```

```
    // 指向对象
    var obj = {
        name: "HTML5",
        sayName: function() {
            console.log(this);
            console.log(this.name);
        }
    }
    obj.sayName();
    // 输出Object {name: "HTML5"}
    // name: "HTML5"
    // sayName: ()
    // __proto__: Object
    // 输出HTML5

    var obj = {};
    obj.testOne = function() {
        console.log(this);
        console.log(this == obj);
    }
    var testTwo = obj.testOne;
    obj.testOne();  // 输出obj true
    testTwo();      // 输出window false
```

```
c.鼠标点击事件等函数绑定时的this指向
```

```
    // 指向绑定事件的对象
    var outerArr = document.getElementById("outerEle").getElementsByTagName("div");
    for (var i = 0; i < 4; i++) {
        outerArr[i].onmouseenter = function() {
            console.log(this);
            this.style.width = "300px";
        }
    }

    <div id="test">测试块</div>
    var testBox = document.getElementById('test');
    testBox.onclick = function() {
        console.log(this);
        function show() {
            console.log(this);
        }show();
    }
    // 输出<div id="test">测试块</div>，因匿名函数是testBox.onclick事件的函数，其属于testBox对象，所以输出该对象
    // 输出window，因show函数虽然在匿名函数中，但并没有具体指向，所以指向window
```

```
d.计时器中的this指向
```

```
    // setTimeout(obj.add, 1000);
    // setTimeout所属的对象是window，代码应为window.setTimeout。相当于把obj.add所对应的函数地址，传递给计时器后，由计时器调用该函数。
    setTimeout(function() {
        obj.add();
    }, 1000);
    // 计时器调用时，调用的是匿名函数，函数中使用了()对obj.add进行了调用，所以运行的是obj.add属性中的函数，所以为this指向为obj


    var obj = {};
    obj.x = 1;
    obj.y = 2;
    window.x = 40;
    window.y = 4;
    obj.add = function() {
        console.log(this.x + this.y);
    }

    setTimeout(obj.add, 1000);
    // 输出44, 3
    // setTimeout所属的对象是window，代码应为window.setTimeout。相当于把obj.add所对应的函数地址，传递给计时器后，由计时器调用该函数。

    setTimeout(function() {
        obj.add();
    }, 1000);
    // 计时器调用时，调用的是匿名函数，函数中使用了()对obj.add进行了调用，所以运行的是obj.add属性中的函数，所以为this指向为obj
```

```
e.双层及多层嵌套中的this指向问题
    函数嵌套多层时，且函数本身没有所有者时，无论嵌套在哪个对象中，所有者都为window
```

```
    var name = "The Window";
    var Object = {
        name : "My Object",
        getNameFunc : function() {
            return function() {
                return this.name;
            }
        }
    }
    Object.getNameFunc();       // 输出My Object
    alert(Object.getNameFunc()());
    // 输出My Object The Window

    var testBox = document.getElementById('test');
    testBox.onclick = function() {
        console.log(this);
        function show() {
            console.log(this);
        }show();
    }
    // 输出<div id="test">测试块</div>，因匿名函数是testBox.onclick事件的函数，其属于testBox对象，所以输出该对象
    // 输出window，因show函数虽然在匿名函数中，但并没有具体指向，所以指向window
```

```
f.IE中DOM2级事件绑定attachEvent方法的this指向问题
    attachEvent方法无论在何时何地被调用，他所指向的对象都是window
```

```
    test.attachEvent('onclick', show);
    function show(){
        console.log(this);
    }
    // 输出[object] window
```

```
g.call和apply改变this指向
    call和apply的传参方式不同，call传的值可以是任意的，而apply传的剩余值必须为数组。
```

```
    var oo = {
        "name" : "我是oo"
    }
    oo.test3 = function() {
        console.log(this.name);
    }
    var ooo = {
        "name" : "我是ooo"
    }
    oo.test3.call(ooo);
    // 输出我是ooo

    window.x = 100;
    var oo = {};
    oo.x = 1000;
    oo.test3 = function(y, z, k) {
        console.log(this.x + y + z + k);
        console.log(this);
    }
    var arr = [2, 3, 4];
    oo.test3.call(window, 2, 3, 4);
    oo.test3.apply(window, [2, 3, 4]);
    oo.test3.apply(window, arr);
    oo.test3.call(window, arr[0], arr[1], arr[2]);
    oo.test3(2, 3, 4);
    // 输出109, 109, 109, 109
```

七、高级计时器

1.计时器种类

```
a.setInterval(函数, 时间) —— 执行多次
    只能支持一个等待，一个执行
b.setTimeout(函数, 时间) —— 执行一次
c.计时器的归属
    setInterval和setTimeout都是属于window的方法。
```

2.setInterval和setTimeout计时器的区别

```
a.setInterval的内存泄露问题
    内联书写setInterval时，由于匿名函数被定义于全局中，不能够计时器的清除，因此很容易造成内存泄露。
b.计时器延迟问题
```

<http://www.h5course.com/a/2015050290.html>

```
    1)计时器延迟概述
        因JavaScript运行是单线程，在onclick事件未运行完成之前，计时器虽然会被添加到运行队列中。
        并且也会开始计时器的计时动作，但即使计时完成之后，也会因为onclick事件未运行完成，造成计时器内部函数代码无法运行。
        从而只能在onclick事件运行完成后才能进行调用，所以会造成计时器延迟。
```

![这里写图片描述](http://img.blog.csdn.net/20170512115611331?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512115644800?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

2)延迟的解决方法

```
timer = setTimeout(function() {
    // clearInterval();
    // clearTimeout(timer);
    Change += 10;
    changeDiv.style.width = Change +"px";
    changeDiv.style.height = Change + "px";
    setTimeout(arguments.callee, 200);
}, 1000);
```

```
c.计时器的提前问题
    1)计时器提前问题描述
        若setInterval计时器内部的函数运行时间大于其设定的时间间隔时。
        则会出现代码还在运行时，等待的时间已经结束，原本需要间隔一段时间才要运行的代码，会在第一段代码完成时立即运行。
        另外，此时因setInterval计时器只能支持一个等待，一个执行，不支持多个计时器同时等待。
        此时会有部分新加入的计时器，因原本线程中有代码在等待运行而被舍弃跳过。
```

![这里写图片描述](http://img.blog.csdn.net/20170512115744913?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512115805757?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
    2)计时器提前问题解决方法
        使用内置setTimeout计时器来模拟setInterval。
```

```
        function show() {
            secondTime += 1;
            if (second.innerHTML < 9) {
                second.innerHTML = "0" + secondTime;
            } else {
                second.innerHTML = secondTime;
            }
        timer = setTimeout(show, 1000);
                }
        timer = setTimeout(show, 1000);
```

3.计时器的编号建规则和清除计时器之间的关系

```
创建计时器时，浏览器内部存储计时器，是按照计时器的编号，第一次被创建的计时器为1，第二次为2，以此类推。
创建的计时器编号和id无关，即计时器编号只有一个，每次计时器被创建都会加1，然后把结果赋值给相应的id，而不是每个id单独使用一个编号。
无论创建多少个id名，或同一个id名被创建多少次，在浏览器中，总是以计时器编号做为存储。
id名只是做为创建和清除时的一个代号，而不是计时器编号本身。
创建时写入的id名与计时器编号虽然存在一一对应的关系，但一个id名只允许存储一个计时器编号。
因此会造成多次创建的计时器使用同一个id名时，之前创建的编号会被最后创建的编号覆盖。
从而造成之前创建的计时器编号无法被系统查询到，因而无法被清除的问题。
浏览器清除计时器时，也是按照创建时该id名所创建的最后一个编号来清除。
若该id名被创建多次，则只会清除最后一个，之前的几个编号的计时器不会被清除。
因此，在创建计时器时，要避免同一个id名的计时器在未清除的情况下被创建多次，造成计时器无法清除的问题。

```

4.计时器写法 
[http://www.h5course.com/a/20150509160.html](http://www.h5course.com/a/20150509160.html)

```
a.函数部分
    1)直接整个函数书写在内部
```

```
        setTimeout(function(){
             console.log('内容');
        },500);
```

```
        该方法较常用，不容易出错，如下：

        如下方法使用时，会出现每次onclick事件运行时，secondTime都会被+1
```

```
        function show() {
            timer = setTimeout(show, 1000);
            secondTime += 1;
        }
        start.onclick = function() {
            clearTimeout(timer);
            show();
        }
```

```
        使用函数书写在内部的方法，即可规避此问题，因为每次点击运行的show函数，必须在1000ms后才会运行+1

```

```
        function show() {
            timer = setInterval(function() {
                secondTime += 1;
                }
            }, 1000);
        }
        start.onclick = function() {
            clearTimeout(timer);
            show();
        }
```

```
    2)setInterval(函数名, 毫秒数)，书写一个函数名（类似调用）
        setInterval(move,1000);

    3)书写(”函数名()”，字符串)
        setInterval("move()",1000);
        此种方法不使用，会产生内存泄露，因程序不断调用，每次都不断占用内存。

b.错误写法
```

```
         setInterval(move(),1000);
         function move(){
             alert(1)
         }
```

```
    这种写法能发现move只运行了一次。为什么呢？
    原因很简单，setInterval要求第一个参数必须是含Javascript命令的字符串或函数对象。
    所以setInterval("move()",1000)以及setInterval(move,1000)，这两个都是正确的。
    而setInterval(move(),1000)呢？
    当Javascript运行到这个语句时，会立即执行move这个函数，然后把函数的返回值作为setInterval的第一个参数。
    而由于move函数没有返回值，实际就相当于setInterval(undefined,1000)这个当然就不会运行。
    表面看起来就是move只运行了一次。那么咱们改一改看看。
    需要改为：
```

```
         setInterval(move(),1000);
         function move(){
             alert(1)
             return move;
         }
```

```
小结：
    move()和move是不相同的，move()是语句，表示要立即执行这个函数的意思；
    move则是一个函数对象，代表了这个函数本身，本身是不会运行的，可以把它赋值给其他对象或作为其他函数的参数。
    就像咱们写的这个例子，把move赋值给setInterval函数作为参数。

c.时间部分
    单位为ms，1s = 1000ms
```

4．计时器运用

```
a.直接运行
    setInterval(move,1000);
    直接在window下开辟空间

b.存储变量运行
    var timer = null;
    timer = setInterval(show, 1000);
    函数存储在变量中运行，可以使用clearInterval(timer);的方法清除计时器，停止运行

c.运用递归算法使setTimeout无限循环
```

```
        var timer = null;
        function show() {
            Change += 10;
            changeDiv.style.width = Change +"px";
            changeDiv.style.height = Change + "px";
            setTimeout(show, 200);
        }
        timer = setTimeout(show, 1000);
```

```
d.封装函数
```

```
function show() {
    secondTime += 1;
    if (second.innerHTML < 9) {
        second.innerHTML = "0" + secondTime;
    } else {
        second.innerHTML = secondTime;
    }
    timer = setTimeout(show, 1000);
}
```

```
    同时，在最后调用setTimeout;，即可在程序执行完成之后调用计时器，即可模拟成setInterval计时器。
    因它之后没有函数，也可规避计时器提前的问题

e.用于计算代码运行时间
```

```
    // 计算代码运行时间方法
    var time1 = new Date();
    // 需要计算运行时间的代码
    var time2 = new Date();
    var difference = time1.getTime() - time2.getTime();
    console.log(difference); 
```

```
f.计时器中的函数中的this指向问题
```

```
        var obj = {};
        obj.x = 1;
        obj.y = 2;
        window.x = 40;
        window.y = 4;
        obj.add = function() {
            console.log(this.x + this.y);
        }
        setTimeout(obj.add, 1000);
        // 输出44, 3
        // setTimeout真正调用的对象是window，代码应为window.setTimeout。相当于把obj.add所对应的函数地址，传递给计时器后，由计时器调用该函数。
        setTimeout(function() {
            obj.add();
        }, 1000);
        // 计时器调用时，调用的是匿名函数，函数中使用了()对obj.add进行了调用，所以运行的是obj.add属性中的函数，所以为this指向为obj
```

5．清除计时器

```
为了防止计时器被重复调用，而造成重复运行，计时混乱的问题。
无论用clearInterval(ID);和clearTimeout(ID);，只要ID相同计时器都会被请除。但推荐计时器名称要正确。
a.clearInterval(ID);
b.clearTimeout(ID);
```

6．计时器传参方法

```
    function show(index) {
        console.log(index);
    }
    // 第一种方法
    setinterval(function() {
        show(20);
    }, 16);
    // 第二种方法
    setinterval("show(20)", 16);
    // 触发eval()方法，影响JavaScript性能和安全
```

7．内存泄露

```
内存泄露是指分配给应用的内存不能被重新分配，即使在内存已经不再被使用的时候
内联书写setInterval时，由于匿名函数被定义于全局中，不能够计时器的清除，因此很容易造成内存泄露。
造成内存泄露的写法：
a.闭包
b.计时器方法3：(”函数名()”，字符串)
```

##### 八、Date对象

<http://blog.csdn.net/lwkhehe/article/details/7944504>

1．Date概述

```
用于设置与获取当前的时间
Date()为函数，但因不能使用方法.方法，故在使用时需要先将Date()存储在变量中，成为对象，才可使用对象.方法来调用其下的方法。
```

```
        var time = new Date();
        var year = time.getFullYear();
```

2．构造函数

```
a.new Date(); 根据当前时间创建Date对象;
b.new Date(milliseconds); 与标准时间之间的毫秒数;
c.new Date(datestring); 以字符串形式定义日期的参数;
d.new Date(year, month, day, hours, minutes, ms); 对应年、月、日、时、分、秒6个参数。
详解：
创建 Date 对象的语法：
var myDate=new Date()
Date 对象会自动把当前日期和时间保存为其初始值。
参数形式有以下５种：  
```

```
new Date("month dd,yyyy hh:mm:ss");
new Date("month dd,yyyy");
new Date(yyyy,mth,dd,hh,mm,ss);
new Date(yyyy,mth,dd);
new Date(ms);
```

```
注意最后一种形式，参数表示的是需要创建的时间和GMT时间1970年1月1日之间相差的毫秒数。各种函数的含义如下：
month:用英文表示月份名称，从January到December
mth:用整数表示月份，从0-11(1月到12月)
dd:表示一个月中的第几天，从1到31
yyyy:四位数表示的年份
hh:小时数，从0（午夜）到23（晚11点）
mm:分钟数，从0到59的整数
ss:秒数，从0到59的整数
ms:毫秒数，为大于等于0的整数
如：
```

```
new Date("January 12,2006 22:19:35");
new Date("January 12,2006");
new Date(2006,0,12,22,19,35);
new Date(2006,0,12);
new Date(1137075575000);
```

3．方法

```
Date对象方法分为：一种使用本地时间；一种使用世界时间UTC(即当方法中有“UTC”)，则代表世界时间；还有一个是与字符串间的转换。
a.获取时间:
    01、get[UTC]Date():返回Date对象的月份中的日期值;
    02、get[UTC]Day():返回Date对象的一周中的日期值;
    03、get[UTC]FullYear():返回日期的年份，完整的4位数字;
    04、get[UTC]Hours():返回Date对象的小时值;
    05、get[UTC]Millseconds():返回Date对象的毫秒值;
    06、get[UTC]Minutes():返回Date对象的分钟值;
    07、get[UTC]Month():返回Date对象的月份值;
    08、get[UTC]Seconds():返回Date对象的秒数值;
    09、getTime():返回 1970 年 1 月 1 日至今的毫秒数，这个值没有“UTC”方法;
    10、getTimezoneOffset():返回当前日期的本地表示与UTC表示之间的时间差的值;
    11、getYear():返回Date对象的年份值，建议使用get[UTC]FullYear().
b.设置时间:
    01、set[UTC]Date():设置日期的月份的日期值;
    02、set[UTC]FullYear():设置日期的年份(以及可选的月份及日期)值;
    03、set[UTC]Hours():设置日期的小时值(以及可选的分钟、秒以及毫秒)值;
    04、set[UTC]Millseconds():设置日期的毫秒值;
    05、set[UTC]Minutes():设置日期的分钟值(以及可选的秒和毫秒)值;
    06、set[UTC]Month():设置日期的月份值(以及可选的月份中的天数)值;
    07、set[UTC]Seconds():设置日期的秒(以及可选的毫秒)值;
    08、setTime():使用毫秒格式，设置一个Date对象的值;
    09、setYear():设置年份值，建议使用set[UTC]FullYear().

c.部分方法无UTC方法
    getYear()和getTime()无UTC方法，UTC方法用于获取本初子午线的时间。
    setUTCYear、setUTCTime、setUTCDay、setday方法不存在
```

4．静态方法

```
a.Date.now();
    返回当前的时间，从1970-01-01午夜到现在的时间，以毫秒表示。
b.Date.parse();
    解析一个日期/时间字符串，返回该日期的内部毫秒表示。
c.Date.UTC();
    返回指定的UTC日期及时间的毫秒表示。
```

5．Date对象函数使用

```
案例一：创建一个Date对象，然后用若干方法来操作，包括：获取日期、时间、星期、判断是否是周末。
```

```
<srcipt>
        var dateTimes = new Date();
        console.log("Today is:" + dateTimes.toLocaleDateString() + "."); // 显示日期
        console.log("The time is:" + dateTimes.toLocaleTimeString()); // 显示时间
        var dayOfWeek = dateTimes.getDay(); // 显示星期
        console.log("The weekday is :" + dayOfWeek);
        var weekend = (dayOfWeek == 0) || (dayOfWeek == 6); // 判断是否是周末！
        if (weekend = true) {
            console.log("周末到了！");
        } else {
            console.log("还要上班！");
        }
</script>
```

```
案例二：从当前时间的毫秒表示中减去其他的时间，判断两个时间之间的时间差。
```

```
<srcipt>
        var today = new Date(); // 记下当天的日期
        var NewYear = new Date(); // 取得当前年份日期
        NewYear.setFullYear(2016); // 将年份设置为2016年
        NewYear.setMonth(1); // 12个月份的取值是对应0~11，此处设置为1月
        NewYear.setDate(8); // 将天设置为1号
        var difference = 0;
        // 计算与元旦之间的毫秒数，然后将它转换为天数并输出一条信息
        if (today.getTime() < NewYear.getTime()) {
             difference = NewYear.getTime() - today.getTime();
             difference = Math.floor(difference / (1000 * 60 *60 * 24));
             console.log("距离春节只有" + difference + "天了！");
        }
</script>
```

```
案例三：使用Date对象来进行计时(此处的today沿用)。
```

```
<script>
        var now = new Date();
        var difference = now.getTime() - today.getTime();
        console.log("加载本页花费了" + difference + "秒。");
 </script>
```

##### 九、滚动效果的相关属性介绍

1.scrollLeft系列属性介绍

```
scrollHeight：获取当前对象可滚动的总高度
scrollWidth：获取当前对象可滚动的总宽度
scrollLeft：获取/设置当前对象左滚动的举例
scrollLeft(max) = scrollWidth - (content + padding)
scrollTop：获取/设置当前对象右滚动的举例
注意：scrollLeft、scrollTop针对外部块（有滚动条），不属于style，也不需要添加单位

```

![这里写图片描述](http://img.blog.csdn.net/20170512125730089?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

2.临界值计算所需属性

```
a.临界值（scrollLeft的最大值） = 内部的宽 - 外部的宽
b.offsetWidth：获取自身元素的宽度（包含边框、滚动条）
c.offsetHeight：获取自身元素的高度（包含边框、滚动条）
d.clientWidth：获取自身元素的宽度（不包含边框）
e.clientHeight：获取自身元素的高度（不包含边框）
f.offsetLeft：获取当前对象与父级之间的左边距离
g.offsetTop：获取当前对象与父级之间的上边距离
h.clientLeft：效果和边框宽度相同，很少用到
i.clientTop：效果和边框宽度相同，很少用到

```

![这里写图片描述](http://img.blog.csdn.net/20170512125804731?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512125909128?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512125935613?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512125959816?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

##### 十、Event事件对象

1.Event事件对象的概念

<http://www.w3school.com.cn/jsref/dom_obj_event.asp>

```
事件对象是用来记录一些事件发生时的相关信息的对象。事件对象只有事件发生时才会产生，并且只能是事件处理函数内部访问。
在所有事件处理函数运行结束后，事件对象就被销毁！
Event代表事件的状态，例如触发event对象的元素、鼠标的位置及状态、按下的键等等。 
event对象只在事件发生的过程中才有效。
event的某些属性只对特定的事件有意义。比如，fromElement 和 toElement 属性只对 onmouseover 和 onmouseout 事件有意义。
Event 对象代表事件的状态，比如事件在其中发生的元素、键盘按键的状态、鼠标的位置、鼠标按钮的状态。
事件通常与函数结合使用，函数不会在事件发生前被执行！
```

2.获取事件对象方法

```
innerEle.onclick = function(event) {
    console.log(event);
}
innerEle.onclick = function(e) {
    console.log(e);
}
innerEle.onclick = function(e) {
    console.log(e.clientX, e.clientY);
}
```

```
输出事件
clientX:    表示鼠标位置相对页面左上角的x轴距离
clientY:    表示鼠标位置相对页面左上角的y轴距离
```

3.preventDefault()方法的使用

```
定义和用法
取消事件的默认动作。
语法
event.preventDefault()
说明
该方法将通知 Web 浏览器不要执行与事件关联的默认动作（如果存在这样的动作）。
例如，如果 type 属性是 "submit"，在事件传播的任意阶段可以调用任意的事件句柄，通过调用该方法，可以阻止提交表单。
注意，如果 Event 对象的 cancelable 属性是 fasle，那么就没有默认动作，或者不能阻止默认动作。
无论哪种情况，调用该方法都没有作用。
```

```
// 使用preventDefault()方法，取消事件的默认动作。用于取消鼠标双击、拖动等动作时会选中内部文本的bug
function removeDefault(e) {
    // 因IE支持的是window.event，所以需要判断，如果是谷歌、火狐浏览器，则赋值e，如果是IE则赋值window.event;
    e = e || window.event;
    // 因IE支持的是e.returnValue = false，所以需要判断如果e.preventDefault为true，则为谷歌、火狐浏览器，执行e.preventDefault();如果为false，则为IE浏览器，执行e.returnValue = false;
    if (e.preventDefault) {
        e.preventDefault();
    } else {
        e.returnValue = false;
    }
}
```

4.事件句柄　(Event Handlers)

```
HTML 4.0 的新特性之一是能够使 HTML 事件触发浏览器中的行为，比如当用户点击某个 HTML 元素时启动一段 JavaScript。
下面是一个属性列表，可将之插入 HTML 标签以定义事件的行为。
```

![这里写图片描述](http://img.blog.csdn.net/20170512130154735?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

5.鼠标 / 键盘属性

![这里写图片描述](http://img.blog.csdn.net/20170512130300818?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

6.IE 属性

除了上面的鼠标/事件属性，IE 浏览器还支持下面的属性：

![这里写图片描述](http://img.blog.csdn.net/20170512130347097?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

7.标准 Event 属性

```
下面列出了 2 级 DOM 事件标准定义的属性。
```

![这里写图片描述](http://img.blog.csdn.net/20170512130440941?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

8.标准 Event 方法

```
下面列出了 2 级 DOM 事件标准定义的方法。IE 的事件模型不支持这些方法：
```

![这里写图片描述](http://img.blog.csdn.net/20170512130517536?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

##### 十一、本地存储

1．什么是本地存储

```
将一些网站信息存储到客户端的技术
```

2．本地存储在网站中的应用

```
a.记住用户名和密码
b.网站的换肤功能
c.用户偏好
```

3．Cookie

```
a.Cookie是浏览器提供的一种机制，不是JavaScript本身的性质，而是把API接口提供给了JavaScript
b.Cookie能跨越一个域名下的多个页面，但不能跨越多个域名使用（也不能跨浏览器使用）
```

4．操作cookie

```
a.设置cookie
    document.cookie = 'className=HTML5-9';
b.设置cookie的时间戳（有效期）
    当前的时间保存13天
```

```
// 获取当前的时间+13天
var date = new Date();
var  expiresDay = 13;
// 利用毫秒数初始化事件
date.setTime(date.getTime() + expiresDay * 24 * 3600 * 1000);
// console.log(date.toGMTString());
document.cookie = 'className=HTML5-9;expires=' + date.toGMTString();
```

```
c.获取cookie
    想要获取某个cookie，则需要使用字符串切割成数组后查找，或者使用正则
    console.log(document.cookie);
d.删除cookie
```

```
// 设置cookie的时间戳为当前时间，即下一秒就过期，立即失效
var delDate = new Date();
document.cookie = 'className=HTML5-9;expires=' + delDate.toGMTString();
```

5．HTML5本地存储

```
a.HTML5本地存储的种类
    1)localStorage：为永久性存储数据，除非用户删除
    2)sessionStorage：临时存储，关掉页面就消失
b.lcoalStorage
    1)支持性检测
        IE8+支持
```

![这里写图片描述](http://img.blog.csdn.net/20170512131121592?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
    if (window.localStorage) {
        var ls = window.localStorage;
    } else  {
        alert('不支持localStorage');
    }
```

```
    2)特点
        按照域名存储，不会和其他域名发生冲突
        存储方式是按照键值对进行存储
    3)保存数据
```

```
    ls.setItem('username', 'Lee');
```

```
    4)获取数据
```

```
    ls.getItem('username')
```

```
    5)根据索引值获取数据
```

```
    // 获取key，通过ls.key(i)获取key的名称，再根据key名称获取对应的值
    for (var i = 0; i < ls.length; i++) {
        console.log(ls.getItem(ls.key(i)));
    }
```

```
    6)清空数据
```

```
    // 删除某一项
    ls.removeItem('username');
    // 清空所有
    ls.clear()
```

```
    7)存储和读取对象
```

```
    // 利用JSON.stringify方法将对象转换成字符串存入
    ls.setItem('blog', JSON.stringify(blog));
    // 读取对象，使用JSON.parse方法将输出值转化为对象提取出来
    var blogObj = JSON.parse(ls.getItem('blog'));
    console.log(blogObj);
    console.log(blogObj.type);
```

```
    8)storage事件
        当一个域名下的本地存储的值被修改后，就会触发该事件。这个事件是跨窗口触发。
```

![img](http://img.blog.csdn.net/20170512131213040?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
c.sessionStorage
    sessionStorage为临时性保存数据，当页面关闭就会消失。其他一切与localStorage一样。
    sessionStorage不能跨页面访问，也不会触发跨标签页的storage事件。它只局限在当前的标签页里。
```

6．HTML5本地存储与cookie的比较

```
a.本地存储
    1)大小最小是5MB，可以向用户申请更大的空间
    2)不会随着HTTP请求发送给服务器
    3)非常容易操作
    4)移动端普及高
    5)sessionStorage与localStorage两者
b.cookie
    1)只能存储4KB
    2)浪费带宽，每次会随着HTTP请求发送给服务器
    3)操作cookie内的数据非常繁琐，没有方便的API
    4)支持程度高
```

##### 十二、视频

1．视频格式

```
a.Theora + Vorbis = Ogg
b.H.264 + ACC = MPEG4
c.Vp8 + Vorbis = Webm
```

2．支持程度

![这里写图片描述](http://img.blog.csdn.net/20170512131252688?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

3．HTML5视频的使用 —— video标签

```
a.video标签属性
    1)src属性 —— 设置视频的链接
    2)width属性 —— 设置元素宽，不好维护，推荐使用样式书写
    3)height属性 —— 设置元素高，不好维护，推荐使用样式书写
b.兼容处理 —— source元素
    浏览器对视音频的格式支持程度不同，使用source标签进行处理
    source标签被视频标签video和音频标签audio所支持，它可以链接不同的媒体文件，浏览器将使用第一个可识别的格式 
c.播放控制 —— 
    1)controls：控制条
    2)autoplay：属性是视频就绪后自动播放自动播放
    3)preload：auto值是表示页面加载后载入视频，none值表示禁用
    4)loop：实现视频播放结束后进行循环播放
    5)poster：将在视频文件开始播放前显示图片
    6)load()方法用于在更改来源（视频地址）后对视频/应聘进行加载
    7)play()方法播放加载完成的视音频文件
    8)pause()方法暂停正在播放的视音频文件
    9)volume属性：控制音量，范围[0-1]
    10)playbackRate属性：设置视音频当前的播放速度，FF最大值为5，IE最大值为8，Chrome不确定
    11)timeupdate事件
    12)duration：视频可播放的总时间
    13)currentTime：当前播放视频的时间，可以读写操作
d.其他属性
```

![这里写图片描述](http://img.blog.csdn.net/20170512131517614?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

##### 十三、硬件调用

1．特殊功能

```
a.电话、短信、邮箱
    1)取消电话号码识别
```

```
<meta name="format-detection" content="telephone=no">
```

```
b.手机相册
    1)调用相册
```

```
<input type="file" accept="image/*" name="" value="" style="background: #faa">
```

```
    2)调用手机摄像头
```

```
<input type="file" accept="image/*" capture="camera" name="" value="" style="background: #aaf">
```

```
c.PC端调用QQ
```

<http://shang.qq.com/v3/widget.html>

d.IP定位

![这里写图片描述](http://img.blog.csdn.net/20170512131700256?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

##### 十四、Canvas

1．Canvas是什么？

```
HTML5新增的一个标签，它的作用是画矢量图和位图
```

2．Canvas能做什么？

```
a.能做游戏、能做特别酷炫的效果等等，主要是为画图而生
b.注意：Canvas元素本身并没有绘制能力，必须使用JavaScript来完成实际的绘图任务
```

3．Canvas设置大小

```
Canvas有默认宽高，如果使用CSS设置Canvas画布的大小，则导致画布按比例缩放到CSS设置的值.
所以Canvas画布宽度的设置需要在标签中，使用标签的属性进行设置。
```

4．Canvas的基本方法

```
a.什么是路径
    1)绘制时产生的线条成为路径。路径由一个或多个直线段或曲线段组成
b.开始和闭合路径
    1)beginPath()
    2)开始和闭合之间进行绘图
    3)closePath()
c.移动画笔与画线
    1)moveTo(x, y)
    2)lineTo(x, y)
d.文本绘制
    1)strokeText(text, x, y); —— 绘制文字轮廓
    2)fillText(text, x, y); —— 填充文字
```

5．Canvas基本属性

```
a.设置填充与描边的颜色
    1)strokeStyle = ‘red’;
    2)fillStyle = ‘red’;
b.线条样式的设置
    1)lineCap设置线条末端线帽的样式（round、square）
    2)lineWidth设置线条粗细，不需要写单位，以像素来计算
c.文字的设置
    1)font跟CSS类似：字体大小、字体
    2)textAlign文字水平对齐（start、end、left、right、center）
    3)textBaseline文字垂直对齐方式（文字基线是普通的字母基线）
```

![这里写图片描述](http://img.blog.csdn.net/20170512153416442?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

6．Canvas快速绘制

```
a.矩形路径的绘制
    1)rect(x, y, width, height);
        参数          描述
        x       矩形左上角的 x 坐标。
        y       矩形左上角的 y 坐标。
        width   矩形的宽度，以像素计。
        height  矩形的高度，以像素计。

2)fillRect(x, y, width, height);
    fillRect() 方法绘制"已填充"的矩形。默认的填充颜色是黑色。
    提示：请使用 fillStyle 属性来设置用于填充绘图的颜色、渐变或模式。

b.圆形路径的绘制
    1)arc(x, y, r, sa, ea, true/false)
```

```
context.arc(x,y,r,sAngle,eAngle,counterclockwise);
```

```
参数                  描述
x                   圆的中心的 x 坐标。
y                   圆的中心的 y 坐标。
r                   圆的半径。
sAngle              起始角，以弧度计（弧的圆形的三点钟位置是 0 度）。
eAngle              结束角，以弧度计。
counterclockwise    可选。规定应该逆时针还是顺时针绘图。False = 顺时针，true = 逆时针。
```

![这里写图片描述](http://img.blog.csdn.net/20170512153520036?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
c.贝赛尔曲线
    1)quadraticCurveTo(kx, ky, ex, ey);
        二次贝塞尔曲线
        ex, ey：终点
    2)bezierCurveTo(kx1, ky1, kx2, ky2, ex, ey)
        三次贝塞尔曲线
```

![这里写图片描述](http://img.blog.csdn.net/20170512153620911?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

7．Canvas绘制思路

```
开始绘制——属性设置——路径变化——关闭路径——填充/描边
```

8．Canvas图形操作

```
a.缩放
    scale(x, y) —— 缩放当前绘图放大与缩小，x为在横坐标轴上的缩放倍数，y为纵坐标轴上的缩放倍数
    b.旋转
    rotate(par) —— 旋转当前绘制的图，par为旋转的量，用弧度制表示
    c.平移
    translate(x, y) —— 为画布水平和垂直的位移
    9．Canvas动画
    a.原理：绘制——清除——绘制——清除……
    b.Canvas动画相关命令
    1)清除画布
    clearRect(x, y, width, height);
    2)save与restore
    保存与恢复
    Canvas绘图上下文（程序之上和之下的意思）属性都是可以保存和回复，也就是说只能保存状态，不能回复所绘制的内容（图像）
    save() —— 用于储存状态，如strokeStyle, fillStyle, lineWidth, lineCap, shadowOffsetX, shadowOffsetY, shadowBlur, shadowColor, 
    font, textAlign, textBaseline.
    restore() —— 将储存的状态取出并赋予新建的图形
    3)上下文和栈
    save()（入栈）
    restore()（出栈）
```

##### 十五、数组

1.数组

```
a.数组的定义
var arr = [1, 2, 3];
arr[数组的下标] 数组下标从0开始
数组名.length属性获取数组的长度

数组概念
数组对象的作用是：使用单独的变量名来存储一系列的值。
定义数组
数组对象用来在单独的变量名中存储一系列的值。
我们使用关键词 new 来创建数组对象。下面的代码定义了一个名为 myArray 的数组对象：
var myArray=new Array()
有两种向数组赋值的方法（你可以添加任意多的值，就像你可以定义你需要的任意多的变量一样）。
1:
```

```
var mycars=new Array()
mycars[0]="Saab"
mycars[1]="Volvo"
mycars[2]="BMW"
也可以使用一个整数自变量来控制数组的容量：
var mycars=new Array(3)
mycars[0]="Saab"
mycars[1]="Volvo"
mycars[2]="BMW"
```

```
2:
```

```
var mycars=new Array("Saab","Volvo","BMW")
```

```
    注意：如果你需要在数组内指定数值或者逻辑值，那么变量类型应该是数值变量或者布尔变量，而不是字符变量。

b.数组中添加内容
```

```
var arr = [];   // 声明（）定义一个空数组
arr.push(allEle[i]);    // 使用push往数组里面添加内容，push为向后添加
```

2.类数组

```
通过getElementsByTagName获取标签
利用for语句优化绑定事件
通过标签名获取标签浮动返回值不是真正的数组，只是与数组类似，是类数组
```

```
// 绑定数组标准写法
var eleArr = document.getElementById("outerEle").getElementsByTagName("div");
for(var i = 0; i < eleArr.length; i++) {
    eleArr[i].onmouseenter = function() {
        this.style.width = "300px";
    }
}
```

##### 十六、数组、字符串和正则

1．arguments.callee回顾

```
a.arguments.callee：表示对函数本身的引用（可以理解为代表的是函数名或函数的地址）.
可用于递归调用，防止函数名变动后由于递归调用时的函数名未手动变更造成错误
```

2．数组

```
a.数组的定义
    1)var arr = []; 简单易懂，实用性强，性能佳
        数据类型为object
```

```
var arr = [];
var newArr = new Array();

console.log(typeof arr);            // object
console.log(typeof newArr);     // object
```

```
    2)var arr = new Array();    性能差，语义性强
        数据类型为object
```

```
var arr = [];
var newArr = new Array();

console.log(typeof arr);            // object
console.log(typeof newArr);     // object
```

```
b.数组的赋值
    var arr = new Array()
    构造函数只有一个参数的时候，如果参数是数值，则定义数组的长度
    构造函数只有一个参数的时候，如果参数是非数值，则表示那个值是数组的第一项

c.数组存储的数据类型
    数组能存储任意类型的数据
    JavaScript不存在真正的二（多）维数组

d.数组操作
    栈和队列操作会改变原来的数组
    1)栈操作
        后进先出
        push(); 入栈
        可添加多个值，添加到数组的尾部，push()方法的返回值为添加后的数组长度。
```

```
var arr = [1, 2, 3];

console.log(arr.push(4, [11, 22, 33], '入栈'));
console.log(arr);
```

```
        pop();  出栈
        pop()方法的返回值是被该方法删除的值。
        该方法不可写入参数，无论写入什么参数都对功能没有影响
        每次运行只能删除最后一个值，如需删除多个值，只能写多次。
```

```
var arr = [1, 2, 3];
console.log(arr.pop());
console.log(arr);

var arr = [1, 2, 3];
console.log(arr.pop(1));
console.log(arr);
```

```
    2)队列操作
        先进先出
        unshift();      入队
        可添加多个值，添加到数组的头部，unshift()方法的返回值为添加后的数组长度。
```

```
var arr = [1, 2, 3];
console.log(arr.unshift('入队'));
console.log(arr);

var arr = [1, 2, 3];
console.log(arr.unshift('入队', '再入队'));
console.log(arr);
```

```
        shift();        出队
        shift()方法的返回值是被该方法删除的值。
        该方法不可写入参数，无论写入什么参数都对功能没有影响
        每次运行只能删除最后一个值，如需删除多个值，只能写多次。
```

```
var arr = ['a', 'b', 'c'];
console.log(arr.shift());
console.log(arr);

var arr = ['a', 'b', 'c'];
console.log(arr.shift(2));
console.log(arr);
```

```
    3)排序
    sort()方法
    4)sort()方法实现数组的排序，如何辨别第一个数和第二个数的大小？
    5)concat( value, .....)连接数组                                                
    6)join（separator）将数组元素连接起来构建成一个字符串       
    7)reverse（）颠倒数组中元素的顺序
    8)slice（starpos, endpos）返回数据的一部分
    9)splice（start，deleteCount，value）插入、删除或替换数据的元素
    10)toString( )将数组转换成一个字符串
```

3．字符串

```
a.定义字符串
    1)var str = ''; 简单易懂，实用性强，性能佳
        数据类型为string
        调用方法时，系统内部会启动一个自动转换的机制，会将数据类型转换为object，才可以使用对象.方法的方式调用方法。
    2)var newStr = new String();    性能差，语义性强
        数据类型为object

b.字符串赋值
    两种字符串赋值方式的数据存储方式不同。
```

```
var str = 'HTML5';
var newStr = new String('HTML5');

console.log(str);           // HTML5
console.log(newStr);        // String {0: "H", 1: "T", 2: "M", 3: "L", 4: "5", length: 5, [[PrimitiveValue]]: "HTML5"}
```

```
c.获取字符串的长度
    .length属性获取字符串长度
```

```
console.log(str.length);        // 5
console.log(newStr.length); // 5
```

```
d.字符串操作
    1)charAt(index);
        根据索引值获取某一个字符
    2)indexOf();
        检索字符串（根据字符获取该字符索引值）
    3).substring(start,stop);
        截取字符串
        start的值获取的索引值是从0开始编号
        stop的值获取的索引值是从1开始编号
    4)split()
        字符串分割成数组，分割位置的字符会被删除，且不会改变原数组的值
```

```
var str = 'HTML5.jpg';
console.log(str.split(5));      // ["HTML", ".jpg"]
console.log(str);           // 'HTML5.jpg'
```

```
    5)字符串转换为小写、大写
```

```
toLowerCase();      // 转换为小写
toUpperCase();      // 转换为大写
```

```
    6)replace();
        替换字符
        只会替换第一个符合替换要求的字符
```

```
var str = 'HTML5-5.jpg';
console.log(str.replace('5', '8'));
console.log(str);
```

```
    7)concat（）连接字符串
    8)lastIndexOf（substring，start）从后向前检索
    9)slice（start，end）抽取一个子串
    10)substr（start，length）抽取一个子串 —— 不是ECMAScript的标准，不推荐使用；在IE6/7/8/9不支持负数的索引
    11)substring（from， to）返回字符串的一个子串
```

##### 十七、正则表达式

1．什么是正则表达式

```
利用某种模式去匹配一类字符串的公式

JavaScript RegExp 对象：
RegExp：是正则表达式（regular expression）的简写。
什么是 RegExp？
    正则表达式描述了字符的模式对象。
    当您检索某个文本时，可以使用一种模式来描述要检索的内容。RegExp 就是这种模式。
    简单的模式可以是一个单独的字符。
    更复杂的模式包括了更多的字符，并可用于解析、格式检查、替换等等。
    您可以规定字符串中的检索位置，以及要检索的字符类型，等等。
```

2．正则表达式的适用范围

```
所有的字符串或者数组的处理，都可以使用正则表达式简化处理
```

3．正则表达式的应用

```
a.表单验证
b.编辑器的查找、替换功能
c.等等
```

4．正则表达式的书写分隔 
a.JavaScript风格 
b.perl风格（较简单，学习此风格）

5．特殊含义字符的处理

```
特殊含义的字符，一律使用转义字符处理
a. .在正则中的应用
    .在正则中可匹配任意字符
```

```
var str = 'HTML5-5.jpg';
var reg = /./;
console.log(str.replace(reg,'*'));          // 输出*TML5-5.jpg，.在正则中可匹配任意字符

// 利用转义字符，将.转换为普通字符
var str = 'HTM.L5.-5.jpg';
var reg = /\./;
console.log(str.replace(reg,'*'));          // 输出*TML5-5.jpg，.在正则中可匹配任意字符，但使用此方法只能匹配第一个

// 使用全局进行替换所有.字符
// g代表全局
var str = 'HTM.L5.-5.jpg';
var reg = /\./g;
console.log(str.replace(reg,'*'));          // 输出HTM*L5*-5*jpg

// 替换全局中无论大写或小写的h
// i 代表不区分大小写
var str = 'HTML5-html与css';
var reg = /\h/gi;
console.log(str.replace(reg,'*'));          // 输出*TML5-*tml与css，.在正则中可匹配任意字符
```

6．正则表达式的区间匹配

```
1)[] 代表区间或范围[a-z]代表字母，[0-9]代表数字，范围必须从小到大，否则会报错
2)^ 表示除了...之外，这个必须写在[]里面才是这个意思
```

7．常用转义字符

```
\d代表[0-9]                   \D表示[^0-9]
\w代表[0-9_a-zA-Z]            \W表示[^0-9_a-zA-Z]
\s表示空白字符                \S非空白字符
\n换行                        \r回车
\t Tab键                     \f换页符
\v垂直制表符                 \b匹配一个单词边界
```

8．匹配内容数量控制

```
只控制书写在其后的那个字符，例如ab+，即只控制b
+       至少重复一次
*       重复0次或者更多次
?       重复0次或者1次
{n}     只能重复n次
{n,}        最小出现n次，最大无限制
{n, m}  n是最小重复几次，m是最多重复几次
```

9．正则表达式匹配字符串

```
^   代表字符串的开始
$  代表字符串的结束
```

10．贪婪匹配与非贪婪匹配

```
a.贪婪匹配：针对+ * ? {n, } {n, m}
    尽可能多的从字符串的开头匹配到末尾，而不是从开始匹配到第一个符合匹配的要求位置为止
b.非贪婪匹配
    从头开始匹配到第一个复合匹配的要求位置为止
```

11．前向声明和反前向声明

```
（类似JavaScript的if语句）
a.前向声明：(?=xxx)
b.反前向声明：(?!xxx)
```

12．正则子表达式

```
(子表达式1)(子表达式2)...
$0 代表整个表达式匹配的结果
$1~$9  代表子表达式，例如第一个子表达式$1
```

13．JavaScript lastIndex 属性

```
定义和用法
lastIndex 属性用于规定下次匹配的起始位置。
注意： 该属性只有设置标志 g才能使用。
上次匹配的结果是由方法 RegExp.exec() 和 RegExp.test() 找到的，它们都以 lastIndex 属性所指的位置作为下次检索的起始点。
这样，就可以通过反复调用这两个方法来遍历一个字符串中的所有匹配文本。
注意：该属性是可读可写的。只要目标字符串的下一次搜索开始，就可以对它进行设置。
当方法 exec() 或 test() 再也找不到可以匹配的文本时，它们会自动把 lastIndex 属性重置为 0。
语法
RegExpObject.lastIndex

例子：
```

```
var idValue = '13wqrwrq123';
var idReg = /^\w{6,12}$/gi;

console.log(idReg.test(idValue));       // true
console.log(idReg.test(idValue));       // false
console.log(idReg.test(idValue));       // true
console.log(idReg.test(idValue));       // false
// 更改lastIndex属性，让每次搜索都重新开始，规避第二次搜索时，因已经查找过该字符串，造成不再查找的问题
console.log(idReg.test(idValue));       // true
idReg.lastIndex = 0;
console.log(idReg.test(idValue));       // true
idReg.lastIndex = 0;
console.log(idReg.test(idValue));       // true
idReg.lastIndex = 0;
console.log(idReg.test(idValue));       // true
```

##### 十八、闭包

1.什么是闭包？ 
在JavaScript中，内部的函数总数可以访问其所在外部函数声明的变量和参数，即使外部函数被返回（销毁）了之后都可以正常访问。 
2.闭包的特性 
如果闭包被赋值给变量，则该变量在运行时，闭包单独开辟一个空间存储闭包函数需要调用的外部变量，且闭包每次被调用时，该外部变量值均会被改变。 
如果闭包没有被赋值，单独被调用运行时，每次调用都会独立开辟一个空间，存储外部变量，且外部变量之间不会互相影响。 
3.如何创建闭包 
函数内部创建另一个函数，并将内部的函数返回给外部函数 
示例1：

```
function outer(num) {
        return function() {
            console.log(num);
        }
}
var result1 = outer(0);
var result2 = outer(1);
var result3 = outer(2);
// result1/2/3即为闭包
console.log(result1);
// 输出
function() {
    console.log(num);
}
result1(); // 输出0
result2(); // 输出1
result3(); // 输出2
```

```
示例2：
```

```
var len = titArr.length;
// 闭包函数
for (var i = 0; i < len; i++) {
    titArr[i].onclick = function(num) {
        return function() {
            handleClass(num);
        }
    }(i);
}
// 函数封装
function handleClass(index) {
    for (var i = 0; i < len; i++) {
        titArr[i].className = "";
        conArr[i].className = "";
    }
    titArr[index].className = "select";
    conArr[index].className = "show"
}
```

4.闭包的运行规则

```
1)同一个函数被赋值给不同变量时，各变量所代表的都是单独的函数，各自之间开辟的空间互相不受影响
    匿名函数也具有相同性质，一旦被赋值给某个变量，在被调用时，就会在该变量下开辟固定的空间来存放变量。
```

```
function outer() {
    var a = 1;
    return function inner() {
        a += 1;
        console.log(a);
    }
}
var f1 = outer();
f1();           // 输出2
f1();           // 输出3
var f2 = outer();
f2();           // 输出2
f2();           // 输出3

function outer() {
    var a = 1;
    return function() {
        a += 1;
        console.log(a);
    }
}
var f1 = outer();
f1();           // 输出2
f1();           // 输出3
var f2 = outer();
f2();           // 输出2
f2();           // 输出3

var f1 = (function() {
    var a = 1;
    return function() {
        a += 1;
        console.log(a);
    }
})();
f1();           // 输出2
f1();           // 输出3
var f2 = (function() {
    var a = 1;
    return function() {
        a += 1;
        console.log(a);
    }
})();
f2();           // 输出2
f2();           // 输出3

var i = 9;
function fo() {
    var i = 0;
    return function(num) {
        return num + (++i);
    }
}
var f = fo();
var a = f(15);
alert(a);
var b = fo()(15);
alert(b);
var c = fo()(20);
alert(c);
var d = f(20);
d = f(20);
alert(d);
// 输出16 16 21 23
```

```
    2)闭包被赋值给其他变量并被调用后，内存无法释放，闭包会一直存储在内存中。
```

```
function outer(num) {
    num++;
    console.log(num);
    return function() {
        num++;
        console.log(num);
    }
    num++;
    console.log(num);
}
var result1 = outer(0);
result1();
result1();
// 输出1 2 3
var result2 = outer(1);
result2();
result2();
// 输出2 3 4
// result1和result2一直被存储在内存中，每次调用时的值都会相应变化
```

```
    3)当将一个带参数的闭包赋值给变量时，只运行外部函数中的语句和将参数传递给闭包，闭包函数不会进行任何操作
```

```
function outer(num) {
    num++;
    console.log(num);
    return function() {
        num++;
        console.log(num);
    }
    num++;              // 不执行
    console.log(num);       // 不执行
}
var result1 = outer(0);     // 输出1
result1();                  // 输出2
result1();                  // 输出3
var result2 = outer(1);     // 输出2
result2();                  // 输出3
result2();                  // 输出4

function outer(num) {
    return function() {
        num++;
        console.log(num);
    }
}
var arr = [];
arr[0] = outer(0);
arr[1] = outer(99);
arr[2] = outer(2);
// 以上语句
arr[0]();       // 1
arr[0]();       // 2
arr[1]();       // 100
arr[2]();       // 3
```

##### 十九、面向对象

1．面向对象的优化目的

```
a.规避全局变量
b.提高代码的复用性
c.提高JavaScript的性能
```

2．代码优化

```
a.复用性空间
b.全局作用域
```

3．创建对象

```
a.工厂模式
工厂模式是先定义一个函数，在其内部定义一个对象，并同时定义其属性、方法，实现所需功能.
属性的值使用函数形参传参的方式传入，最后将定义的对象当做函数的返回值返回。
从而完成整个对象的创建过程。
    1)入口 —— 函数形参
    2)加工 —— 函数处理功能（函数主体）
    3)出口 —— 函数return的值
    4)优势 —— 解决了创建多个相似对象的问题
    5)劣势 —— 功能相同的每个方法都要在每一个对象上重新创建一遍（开辟内存空间），内存空间没有得到优化
b.构造函数模式
    1)构造函数为了与普通函数区别开，所以构造函数首字母大写
    2)构造函数与普通函数本身没有区别，只是调用的方式不同而已
        普通函数 —— 普通函数调用 —— 实现某个功能
        构造函数（生成对象的模板） —— 用new操作符进行调用 —— 生成对象
    3)构造函数中的this的指向，指向实例化的对象（生成的对象）
    4)构造函数模式的书写步骤
        工厂模式 —— 构造函数模式
        修改函数的名称，通过new的实例方法进行调用
        去除显示定义的对象（var people = {}）用this代替原有的对象（this → people）
        构造函数默认会返回this，不需要return
    5)优势 —— 相对工厂模式，语义性更强，代码更精简
    6)劣势 —— 功能相同的每个方法都要在每一个对象上重新创建一遍（开辟内存空间），内存空间没有得到优化
    7)工厂模式与构造函数模式的不同点
        ①　没有显示定义对象
        ②　函数调用方式不同
        ③　属性和方法赋值给了this
        ④　函数没有return
    8)new关键字的应用，实例化对象的过程
        ①　创建新对象，对象类型为object
        ②　将构造函数的作用域赋值给新对象，函数中的this都指向该函数所代表的对象
        ③　执行构造函数中的代码，可用来为新对象添加属性，也可用来执行其他代码，如console.log
        ④　返回新对象，做为函数的返回值，即可通过该返回值，将函数对象赋值给变量
```

```
var peo1 = new CreatePeople('lee1', 25);
```

```
c.原型模式
    1)在JavaScript里面函数是一个对象，每一个函数里面都有一个prototype（原型）属性，是一个指针，指向原型对象，实例化的对象指向原型对象
    2)prototype属性特点：
        ①　每个函数，无论是否构造函数，都包含prototype属性，且其中的constructor属性都指向该函数本身
```

```
function Show() {
    console.log('a');
}
var showFun = new Show();
```

![这里写图片描述](http://img.blog.csdn.net/20170512155042589?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
        ②　函数中存在的prototype属性中的constructor属性指向函数本身，形成一个无限循环
        ③　即使函数被赋值给其他变量，prototype属性下定义的所有属性都同样指向原函数对象的prototype下属性.
            即不会因为函数被赋值给不同变量而单独开辟空间

    3)原型的用途（优点）：共享原型所包含的所有原型属性和方法 —— 多个实例化对象的方法共用一个空间
    4)实例（对象）属性：函数被赋值给变量后，即创建了一个实例（对象）.
        函数内定义的属性，即被成为实例（对象）属性，因实例（对象）属性不在prototype下，所以不会共享。
    5)原型模式的缺点：
        ①　默认情况下，对象所有属性全部相同
        ②　对于属性操作起来不方便，对于应用类型的属性，由于其共享功能，会导致对个实例化对象之间互相影响
    6)原型模式的指向图解
```

![这里写图片描述](http://img.blog.csdn.net/20170512155114933?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![这里写图片描述](http://img.blog.csdn.net/20170512155127268?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
d.混合模式
    1)混合模式 = 构造函数模式 + 原型模式
    2)混合模式的思想：构造函数模式实现每个实例的属性互不影响，原型模式实现共用调用相同功能的方法
    3)构造函数模式 —— 对象属性的创建
    4)原型模式 —— 对象共用同一个方法
```

##### 二十、面向对象继承

1．原型链

```
a.层层指向父原型的关系
b.可以用来查找对象之间的继承关系
```

2．原型链继承（最简单继承）

```
a.实现思路：
    1)通过在子类的原型中使用new进行实例化父类构造函数实现
        Son.prototype = new Parent('lee');
    2)继承的父类在原型中，相当于直接指向父类，会造成一旦对原型进行更改，都会直接更改在父类中，会影响到父类和其他通过该方法继承的子类
b.不足之处：
    1)修改引用类型（对象、数组、函数）属性会影响到每一个对象（实例）相应的属性，即相当于直接修改了父类.
        同时其他通过该方法继承的之类也会受到父类的影响
    2)子类创建的实例无法给父类的构造函数传递长度（属性值）
c.好处：
    可以实现方法继承
```

3．借用构造函数继承

```
a.实现思路：
    1)通过在子类构造函数中，使用call方法调用父类函数，并改变其指向，使其属性改变为子类的属性
```

```
// 子类（孩子）
function Son(age, name) {
    // 继承
    Parent.call(this, name);
}
```

```
    2)但这种方法无法将父类原型中的方法继承到之类中。
b.不足之处：
    子类无法调用父类的方法（方法无法继承）
c.好处：
    1)可以实现属性的继承
    2)子类的实例可以向父类传递参数，且不会改变父类的属性值，相当于之类拥有父类的属性
```

4．组合模式继承

```
a.取原型链继承（最简单的继承）以及构造函数继承（经典继承）的优势， 结合实现组合继承。“组合继承”又名“伪经典继承”，当前最为常用
b.避免原型链和借用构造函数的缺陷
c.基本思路：使用原型链实现原型方法的继承，通过构造函数来实现实例属性的继承
d.实现思路：
    1)利用call的方法进行属性的继承
    2)利用for-in循环，用原型链继承的方式，继承父类的所有方法。
    3)因为只是将父类方法赋值给子类，并不像原型链模式一样，是直接将父类指向之类原型.
        所以子类方法并不指向原型，继承之后子类方法就具备了可以重新书写的特性。
        如果子类所需方法与父级不同，可以直接对子类的方法进行重新书写。
```

```
function Son(age, name) {
    // 属性继承
    Parent.call(this, name);
}

// 方法的继承
for (var i in Parent.prototype) {
    Son.prototype[i] = Parent.prototype[i];
}

// 重写方法
Son.prototype.sayFriends = function() {
}
```

##### 二十一、AJAX

1．AJAX

```
a.AJAX是什么
    Asynchronous（异步） JavaScript And XML（扩展性标记语言）
b.同步与异步的区别
    同步：
        1)同步的请求在同一时刻只会有一个，并且会阻止后续JavaScript代码的执行。
        2)JavaScript必须等待同步请求加载完毕后才能继续完成
        3)需要不断加载页面，加载速度慢，消耗流量较多
    异步：
        1)浏览器可以从服务器同时请求多项内容，而且请求返回的速度会快很多，
        2)只有页面中真正改变的部分得到更新，能够减少服务器的数据流量
        3)用户可以在页面更新的同时继续工作
        4)有些改变无需与服务器往返通信就可以处理

c.之前的AJAX应用
    主要是表单验证

d.当前AJAX的应用
    数据加载
    发送信息给后台
    表单验证等

e.AJAX的使用步骤
    1)创建向后台服务器的一个请求对象
```

```
var xhr = new XMLHttpRequest();
```

```
    2)确定发送的方法
```

```
// 第一个参数：post、get
// 第二个参数：请求的地址
// 第三个参数：同步与异步，true代表异步，false代表同步
// xhr.open('get', 'form.html', true);
// xhr.open('get', 'test.txt', true);
// xhr.open('get', 'test.html', true);
// xhr.open('get', 'test.js', true);
// xhr.open('get', 'test js in html.html', true);   // 只能使用正则查找字符串，找到所需的函数
xhr.open('get', 'images/163bg.png', true);
// xhr.open('get', 'js/index.js', true);
```

![这里写图片描述](http://img.blog.csdn.net/20170512161032036?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
        GET和POST的区别：
        GET：
        更常用，更方便
        性能好
        明文发送数据，没有POST安全
        传输数据大小有限制：数据通过URL传递，但是URL有一定长度限制。
        POST：
        使用相对较少
        性能只有GET的1/3左右
        比GET稍微安全一点
        没有传输数据带下限制
        GET和POST的选择？
        根据后台来选择 —— 后台定义使用方法
        传输数据的安全性 —— POST
        传输数据的易用性 —— GET

    3)发送请求
```

```
// 有一个参数：向服务器发送信息，如果用get的方式，直接为null；
xhr.send(null);

// 4) 确定后台加载完毕，正常书写需要在open方法之前，防止部分浏览器出错
xhr.onload = function  () {
    // 5)获取到请求的返回数据
    console.log(xhr.responseText);
    console.log(typeof xhr.responseText);
    eval(xhr.responseText);
}
```

```
f.AJAX处理的文件类型
    使用.responseText属性获取的数据都为文本，数据类型为string
```

```
console.log(xhr.responseText);          // 文本
console.log(typeof xhr.responseText);       // string
```

```
    1)txt文档
```

```
xhr.open('get', 'test.txt', true);  
xhr.responseText        // 直接输出文本
```

```
    2)html文档
```

```
xhr.open('get', 'test.html', true);
xhr.responseText        // 直接输出文本
xhr.onload = function  () {
    // 获取到请求的返回数据
    wrapEle.innerHTML = xhr.responseText;
}
// 使用innerHTML将文本输入到标签中，让标签的显示在文档中
```

```
    3)JavaScript文档：需要使用eval('字符串');方法才能解析
    eval方法：
    eval方法是在全局运行，性能较差
    eval方法能任意执行代码，安全性差
    在项目中尽量少使用eval方法

    4)无法加载图片，因responseText返回值都为字符串，会将图片转换为字符串。

g.整个页面能否全部采用AJAX进行数据申请？
    不利于SEO，搜索引擎爬虫无法搜索到，爬虫查找的是源代码，此时网页未执行，所以标签内部都没有信息.
    爬虫将会认为网站都为空标签，所以对于网页比较重要的信息，通常采用的是静态。
```

##### 二十二、AJAX高级

1．JSON与XML

```
a.JSON —— 数据格式
    1)文件较小
    2)嵌套层级少，解析速度、查找速度快
    3)IE8-等低端浏览器不支持，需要引入框架（插件库）进行解决。
    4)JSON不能用单引号，只能用双引号
b.XML —— 数据格式，扩展性标记语言
    嵌套层级较深，造成解析速度和查找速度慢
```

2．JSON常见形式

![这里写图片描述](http://img.blog.csdn.net/20170512161525289?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
a.JSON数组
b.JSON对象
```

3．JSON数据转换

```
a.JSON.parse(string);
    将JSON字符串string转换为JS对象
b.JSON.stringify(obj);
    将JS对象转换为JSON字符串
```

4．跨域

```
a.域名是什么？
```

```
http://121.42.XXX.XXX/ → www.h5course.com
```

```
b.跨域
```

```
www.baidu.com   www.h5course.com
www.baidu.com   mp3.baidu.com
主域名             子域名
```

```
c.跨域的种类
    跨不同的域
    跨子域

d.为何不允许跨域？
    若网站可以直接访问其他网站的数据，会对其他网站的安全构成影响。

e.解决跨域的方式
    1)HTML5
    2)JSONP
        动态创建script标签，利用标签的src属性进行数据的请求。
        因src属性没有任何链接的要求。

3)iframe跨域
```

<http://www.h5course.com/a/20160413409.html>

```
4)服务器代由
    利用后台语言做为中间者，即服务器，实际应用为使用php文件实现

5)Flash（基本不用）
```

5．AJAX的兼容问题

```
a.new XMLHttpRequest()兼容问题 —— 扩展
b.onload的问题status与readyState
    1)IE6、7不支持
    2)局限性：由于请求的链接不会经过确认是否有效就提交，有不清晰、不可控的问题
    3)onreadystatechange
        使用AJAX状态和HTTP状态判断数据是否成功请求和资源是否正常
        AJAX的状态 —— AJAX的正常请求
            0：未初始化，尚未调用open方法
            1：启动，已经调用open方法，尚未调用send方法
            2：发送，已经调用send方法，未接收到响应（服务器的反馈）
            3：接收，已经收到部分相应数据
            4：完成，已经接收到全部相应数据，而且已经可以在浏览器客户端中使用

HTTP的状态 —— 保证请求的资源是否有效
    200 OK：表示请求成功 一切正常

    301 Moved Permanently：重定向，客户请求的文档在其他地方，新的URL在Location头中给出，浏览器应该自动地访问新的URL

    302 Found：临时重定向，类似于301，但新的URL应该被视为临时性的替代，而不是永久性的。

    304 Not Modified：客户端有缓冲的文档并发出了一个条件性的请求。服务器告诉客户，原来缓冲的文档还可以继续使用。

    400 Bad Request：请求出现语法错误。

    403 Forbidden：资源不可用。

    404 Not Found：无法找到指定位置的资源。

    405 Method Not Allowed：请求方法（GET、POST、HEAD、Delete、PUT、TRACE等）对指定的资源不适用。

    500 Internal Server Error：服务器遇到了意料不到的情况，不能完成客户的请求。

    501 Not Implemented：服务器不支持实现请求所需要的功能。
```

##### 二十三、jQuery AJAX

1．jQuery AJAX

```
分别请求html文件与json文件，并测试返回数据的数据类型
```

2．jQuery AJAX的其他方法

```
a.get、post是简易版的AJAX，取代复杂的$.ajax()
get、post语法上相同，唯一的不同就是请求方式（$.get —— get，$.post —— post）
b.$.getScript('test.js');
c.$.getJson()
d.$(parent).load(url [, data] [, callback]);
```

```
请求一个HTML页面，并替换为parent的innerHTML
url：请求HTML页面的URL
data：可选，发送至服务器的数据
callback：可选，请求完成时的回调，无论成功失败
```

e.序列化

```
$(dom).serialize();
```



ref:1. [HTML5学习笔记 —— JavaScript基础知识](http://blog.csdn.net/chencl1986/article/details/71698536)