### JavaScript语句
***

##### 一、代码优化方法

1.函数封装 
2.函数位置的调整

```
主功能函数 → 辅助函数 → 事件 → 依赖函数（核心库）（外部引入需要优先于主功能函数，放在head部分）
```

3.变量 —— 统一提前放在上面 
4.空行 —— 变量与函数之间、各函数之间、各事件之间、函数内部的变量部分与循环判断语句等部分之间添加空行，增加可读性 
5.注释 —— 变量注释、函数功能注释、代码块注释

##### 二、判断语句

1.if语句

```
需要进行逻辑判断，并根据逻辑判断的真假结果，选择不同代码运行时，选择if语句

if语句相关问题
    a.else不是必须要出现
    b.else与if匹配：else会自动寻找在它之前的无匹配的if来匹配
    c.else和if之间不能有任何内容
    d.if语句运行规则
        1)判断语句中的条件遵循数据类型的布尔值关系来进行判断
```

2.switch语句

```
switch(表达式A) {
    case 表达式1 : 代码段1;
    break;
    case 表达式2 : 代码段2;
    break;
    case 表达式3 : 代码段3;
    break;
    default : 代码段4;
}
```

```
a.表达式A是要进行判断/比对的表达式，让每个case后面的表达式与表达式A相比较，如果两者全等，则执行相应case后面的语句。
b.表达式A必须是一个已定义的值，若未定义，则会报错。
c.表达式A的值，为true、false、null时，不会被当做数字1、0、0进行判断。
d.break关键字可以结束switch语句。break语句并非必须存在的，如果没有break，则从符合条件的case开始一直往下执行到switch结束或者遇到break。
e.default，一般用在最后，表示非以上的任何情况下而发生的情况。
    switch最后执行default语句，如果default后面带有break，那么程序就会正常跳出switch，否则，程序会继续向后执行switch语句。
    也就是说，在存在break语句时，不管default放在什么位置，它总是在最后一个处理，然后继续向下处理。
f.若不存在break语句时，default则不会在最后一个被处理，而是按照现在的语句顺序进行输出。
g.如果没有定义default，如果表达式A与其余表达式都不相同，则不会返回任何值
h.此外，可以有多个case的语句。(加入两种case要执行同样的内容，可以书写为 case 表达式1: case 表达式2: 代码段)
```

```
var count = 3;
switch(count) {
    case 0: console.log(0);
    case 1: console.log(1);
    case 2: console.log(2);
    case 3: console.log(3);
    default: console.log(5);
    case 4: console.log(4);
}
// 输出3、5、412345678910
```

```
var count = 3;
switch(count) {
    case 1: console.log(1);break;
    case 2: console.log(2);break;
    case 3: console.log(3);break;
    case 4: console.log(4);break;
    default: console.log(5);break;
}
// 输出3123456789
```

3.if与switch的选择

```
a.从视觉层面上来说，对于一部分功能，选用switch语句可以精简代码，提升视觉效果。
b.从性能角度来说，由于switch的条件简单，编译器会为它做二分法优化(或跳转表)，平均性能相对会高一些。
    而if else所比较的条件会远远比switch的复杂，编译器通常不会做过多的优化。
    简言之就是对于常量方面的条件判断，switch性能略胜于if语句。
4.扩展知识
switch语句以及与if的比较
```

<http://www.h5course.com/plus/view.php?aid=375>

##### 三、循环语句

1．for循环

```
需要循环执行某段代码，或者一次输出一组函数的时候，可以选择使用for循环代码。
```

```
for(初始化表达式; 控制表达式; 循环后表达式) {
    //书写代码
}
```

```
a.何时使用for循环
    1)for语句用于实现相同动作或者有规律可循的动作（for语句可以实现，但是也有其他语句可以实现）
b.三个表达式可否删除
    可以删除，但是“;”不可删除
```

```
//原代码
var sum = 0;
for (var i = 1; i <= 100; i++) {
    sum = sum + i;
}
console.log(sum); 
```

```
// 1)第一个表达式可省略，变量定义到外部
var sum = 0;
    var i = 1
for (; i <= 100; i++) {
    sum = sum + i;
}
console.log(sum);
```

```
// 2)第二个语句可以省略，但是要在代码中加入if语句判断何时break
var sum = 0;
for (var i = 1;; i++) {
    sum = sum + i;
    if (i >100) {
        break;
    }
}
console.log(sum);
```

```
// 3)第三个语句可以省略，但是表达式要放在内部
var sum = 0;
for (var i = 1; i <= 100;) {
    sum = sum + i;
    i++;
}
console.log(sum);
```

```
// 4)三个语句都可以省略，但需要语句来控制循环与退出循环。否则可能造成语句被无限循环
var sum = 0;
var i = 0;
for ( ; ; ) {
    if (i >= 10) {
        break;
    }
    sum = sum + i;
    i++;
}
console.log(sum);
```

2．while循环

```
语法：while(判断条件){}
while循环满足条件后执行大括号内的内容,下面我们来直接看下demo只有当达到条件时累加才会被执行
demo:
```

```
var sum = 0;        //声明变量sum用于累加求和
var i = 1;          //声明变量i用于条件判断
while(i<=100) {
    sum = sum +i;
    i++;
}
console.log(sum);//5050
console.log(i);//10112345678
```

```
可以看到当大于100的时候while不满足条件因此没有执行累加，最后结果就为1加到100的结果
```

3．do…while循环

```
语法：do {执行} while(条件)

do while循环在字面上就能与while循环区分开来，do while不管结果如何，先do了再进行判断。
典型的先斩后奏型，因此第一次执行时无论是否满足条件do里面的代码都将被执行

例如以下demo
```

```
var i = 1;
do {
    console.log(i); // 1
    i++;
} while (i < 0);
console.log(i); // 2
```

```
可以看得出来，i不小于0，但是do内的代码还是执行了一次，最终i变为2，因此do while在执行过程中do内代码必定被执行至少一次。
```

4．扩展知识

```
while和do while、for循环语句
```

<http://www.h5course.com/a/20160103369.html>

##### 四、break以及continue语句

1.break语句

```
a.用来中断当前循环。
b.若达到break语句的条件时，break语句之前的语句将会执行，之后的语句以及整个循环都停止执行。
c.通常在switch语句和while、for、for...in、或do...while循环中使用break语句。
```

```
var sum = 0;
for (var i = 0; i < 5; i++) {
    console.log(i);
    if (i == 2) {
        break;
    }
    sum += i;
}
console.log(sum);
// 输出 0, 1, 2, 1(sum的值)12345678910
```

2.continue语句

```
a.用来结束本次循环
b.若达到continue语句的条件时，continue语句之前的语句将会执行，之后的语句将不执行，但整个循环不会停止，即停止当前循环。
```

```
var sum = 0;
for (var i = 0; i < 5; i++) {
    console.log(i);
    if (i == 2) {
        continue;
    }
    sum += i;
}
console.log(sum);
// 输出0, 1, 2, 3, 4, 8(sum的值)12345678910
```

3.break与continue的区别

```
a.break语句可以用于循环语句，也可以用于分支语句（switch），而continue语句只能用于循环语句（需要注意。
    不要说是for语句，是针对所有的循环语句，break和continue都是可以使用的）。
b.break语句用于跳出全部循环，而continue用于结束本次循环。
```

4.扩展知识

```
break以及continue语句
```

<http://www.h5course.com/a/20150709247.html>

##### 五、for-in语句

<http://www.h5course.com/a/20150527189.html>

1.JavaScript获取对象.属性、对象.方法的方式

```
当我们知道对象中有确定属性或者方法的时候，我们可以通过对象.属性和对象.方法这样的方式来获取该对象的属性和方法。
我们在获取对象的属性值时，通常使用的是对象.属性这种方式来获取对象的属性值。
如下例子：
```

```
var obj = {};
obj.name = "HTML5学堂";
obj.fn = function(){
    console.log("http://www.h5course.com");
}
console.log(obj.name);    // "HTML5学堂"
obj.fn();    // "http://www.h5course.com"1234567
```

```
但如果我们的属性是一个变量，这个时候我们就不能使用对象.属性这种方式来获取我们的属性值，这个时候，可以使用对象["属性"]的方式来获取。
如下例子：
```

```
var obj = {
    "name": "HTML5学堂",
    "url": "http://www.h5course.com"
}
console.log(obj["name"]);    // "HTML5学堂"
var prop = "url";
console.log(obj[prop]);    // "http://www.h5course.com"1234567
```

2.类似JSON数据格式

```
在使用for-in语句时，需要遍历的对象的属性及其属性值，需要以类似JSON的数据格式进行编写，如下例子：
```

```
var properVal = {
    "width" : "200px",
    "height" : "300px",
    "opacity" : "1"
}
console.log(properVal.width);
console.log(properVal.height);
console.log(properVal.opacity);
console.log(properVal["width"]);
console.log(properVal["height"]);
console.log(properVal["opacity"]);
for (var proval in properVal) {
    console.log(proval);
    console.log(proval, properVal[proval]);
}123456789101112131415
```

3.for-in语句的基本语法

```
在项目开发的过程中，当需要获取对象中的属性时，由于对象中属性不确定，这时需要使用for-in语句来获取对象里面的属性。
for-in语句的基本语法如下：
for(变量 in 对象){
    语句
}
下面是一个示例：
```

```
var obj = {
    "name": "HTML5学堂",
    "url": "http://www.h5course.com"
}
var prop;
for(prop in obj){
    console.log(prop);    // "name"    "url"
}
```

```
每次循环，我们的变量prop都会获取到obj的一个新属性，直到遍历到obj中的所有的属性，结束for循环语句。
我们既然可以获得obj的所有的属性，那个就可以得到obj所有的属性值。
```

```
var obj =  {
    "name": "Baidu",
    "url": "http://www.baidu.com"
}
var prop;
for(prop in obj){
    console.log(obj[prop]);    // "Baidu"    "http://www.baidu.com"
}
```

```
我们通过for-in语句，遍历获取到了obj中所有的属性值。但需要注意一点的是，for-in语句无法保证遍历顺序，应尽量避免依赖对象属性顺序的代码。
```

4.for-in与for语句的比较

```
a.for-in主要用于遍历对象的属性
b.for按照设置的条件循环for语句里面包含的语句块（代码块）—— 有下标值等
c.for-in语句无法保证遍历的顺序
for-in语句在遍历时，会有随机性，并不能保证都是从上到下遍历。但实际上较少出现随机的情况

```


ref:1.[HTML5学习笔记 —— JavaScript语句](http://blog.csdn.net/chencl1986/article/details/71773560)