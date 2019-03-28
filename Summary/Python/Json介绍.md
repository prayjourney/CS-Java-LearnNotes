### JSON

***

##### JSON介绍
**JSON**(JavaScript Object Notation, JS 对象标记) 是一种轻量级的数据交换格式。它基于 **ECMAScript** (w3c制定的js规范)的一个子集，采用完全独立于编程语言的文本格式来存储和表示数据。简洁和清晰的层次结构使得 JSON 成为理想的数据交换语言。 易于人阅读和编写，同时也易于机器解析和生成，并有效地提升网络传输效率。JSON 文件的文件类型是 ".json"，JSON 文本的 MIME 类型是 "application/json"



##### JSON值类型
**键值对**(key/value)是JSON中最基本的数据结构，JSON键值对中的值(key-value中的value)可以是以下任意一种，而key值，都是string类型的，JSON的key值必须加双引号(**"**，其他的都不行

|   Value类型   |                    形式                    |                    例子                    |
| :---------: | :--------------------------------------: | :--------------------------------------: |
| **Object**  |    JSON 对象在花括号中书写，对象可以包含多个key/value对     | **{** "firstName":"John" , "lastName":"Doe" **}** |
|  **Array**  |        JSON 数组在方括号中书写， 数组可包含多个对象         | {"employees":**[**{ "firstName":"John" , "lastName":"Doe" },{ "firstName":"Anna" , "lastName":"Smith" },{ "firstName":"Peter" , "lastName":"Jones" }**]**} |
| **String**  |                   字符串                    |           {“name” : **Jhon**}            |
| **Number**  |                    数字                    |             {“age” : **18**}             |
| **Boolean** |                true/false                |      {“emailValidated” : **true**}       |
|  **null**   | 严格来说null并不是一个数据类型，但它非常重要，它表示一个属性或元素没有值。因此请注意 ' ' 表示的是空字符串，而null表示的才是空值 |             {“name” : null}              |



##### JSON 语法
**JSON 语法是 JavaScript 语法的子集**，JSON 文本格式在语法上与创建 JavaScript 对象的代码相同。由于这种相似性，无需解析器，JavaScript 程序能够使用内建的 eval() 函数，用 JSON 数据来生成原生的 JavaScript 对象。在 JavaScript 之中一切都是对象，**所以JSON文本也都是对象**，所有的JSON 文本都要使用**{}**包装起来

- 数据在名称/值对中*(key:value)*
  ```json
  "name" : "菜鸟教程"
  ```
  等价于如下的JavaScript 语句
  ```javascript
  name = "菜鸟教程"
  ```
- 数据由逗号分隔*(,)*
  ```json
  { "age":30,"name":"Jhon" }
  ```
- 大括号保存对象*({})*
  ```json
  { "key1":"python教程" , "key2":"大数据" }
  ```
- 中括号保存数组*([])*
  ```json
  {
      "people" : [
          { “firstName”: “John”, “lastName”: “Smith”, “age”: 35 },
          { “firstName”: “Jane”, “lastName”: “Smith”, “age”: 32 }
      ]
  }
  ```



##### JSON和JavaScript
因为 JSON 使用 JavaScript 语法，所以无需额外的软件就能处理 JavaScript 中的 JSON

```javascript
//使用javascript
var sites = [
  { "name":"baidu" , "url":"www.baidu.com" }, 
  { "name":"google" , "url":"www.google.com" }, 
  { "name":"微博" , "url":"www.weibo.com" }
];
//可以像这样访问 JavaScript 对象数组中的第一项（索引从 0 开始）
sites[0].name;
//返回的内容是
runoob
//可以像这样修改数据
sites[0].name="菜鸟教程";
```

```json
//使用JSON,操作JSON对象
var myObj, x
myObj = { "name":"runoob", "alexa":10000, "site":null };
//访问对象值
x = myObj.name;
//循环对象
for (x in myObj) {
    document.getElementById("demo").innerHTML += x + "<br>";
}
for (x in myObj) {
    document.getElementById("demo").innerHTML += myObj[x] + "<br>";
}

//嵌套JSON对象
myObj = {
    "name":"jhon",
    "alexa":10000,
    "sites": {
        "site1":"www.baidu.com",
        "site2":"m.baidu.com",
        "site3":"c.baidu.com"
    }
}
//可以使用点号(.)或者中括号([])来访问嵌套的 JSON 对象。
x = myObj.sites.site1;
x = myObj.sites["site2"];
//修改值
myObj.sites.site1 = "www.google.com";
myObj.sites["site1"] = "www.google.com";
//删除对象属性
delete myObj.sites.site1;
delete myObj.sites["site1"];
```

```json
//使用JSON,操作JSON数组
myObj = {
  "name":"网站",
  "num":3,
  "sites":[ "Google", "Runoob", "Taobao" ]
}
//访问JSON数组
x = myObj.sites[0];
//循环数组
for (i in myObj.sites) {
    x += myObj.sites[i] + "<br>";
}
for (i = 0; i < myObj.sites.length; i++) {
    x += myObj.sites[i] + "<br>";
}
//嵌套JSON对象中的数组
myObj = {
    "name":"网站",
    "num":3,
    "sites": [
        { "name":"Google", "info":[ "Android", "Google 搜索", "Google 翻译" ] },
        { "name":"Runoob", "info":[ "菜鸟教程", "菜鸟工具", "菜鸟微信" ] },
        { "name":"Taobao", "info":[ "淘宝", "网购" ] }
    ]
}
//循环嵌套数组
for (i in myObj.sites) {
    x += "<h1>" + myObj.sites[i].name + "</h1>";
    for (j in myObj.sites[i].info) {
        x += myObj.sites[i].info[j] + "<br>";
    }
}
//修改数组值
myObj.sites[1] = "Github";
//删除数组元素
delete myObj.sites[1];
```



**JSON.parse()**
JSON 通常用于与服务端交换数据。在**接收服务器数据**时是**(JSON)字符串**时，可以**使用 JSON.parse() 方法将(JSON)字符串**换为 *JavaScript 对象*。函数签名如`JSON.parse(text[, reviver])`，**text:**必需， 一个有效的 JSON 字符，**reviver:** 可选，一个转换结果的函数， 将为对象的每个成员调用此函数。
```json
//从服务器接收了以下数据：
{ "name":"baidu", "alexa":10000, "site":"www.baidu.com" }
//使用 JSON.parse() 方法处理以上数据，将其转换为 JavaScript 对象
var obj = JSON.parse('{ "name":"baidu", "alexa":10000, "site":"www.baidu.com" }');
//注意：JSON 不能存储 Date 对象，如果需要存储Date对象，需要将其转换为字符串，之后再将字符串转换为 Date 对象
```

```html
<!--接上-->
<!--解析完成后，我们就可以在网页上使用 JSON 数据了-->
<!--实例-->
<p id="demo"></p>
<script>
var obj = JSON.parse('{ "name":"baidu", "alexa":10000, "site":"www.baidu.com" }');
document.getElementById("demo").innerHTML = obj.name + "：" + obj.site;
</script>
```



**JSON.stringify()**
JSON 通常用于与服务端交换数据。在**向服务器发送数据**时是**(JSON)字符串**时，可以使用**JSON.stringify() 方法将JavaScript对象**转换为*(JSON)字符串*。函数签名如`JSON.stringify(value[, replacer[, space]])`，**value**:必需， 一个有效的 JSON 字符串。**replacer**:可选。用于转换结果的函数或数组。*如果 replacer 为函数，则 JSON.stringify 将调用该函数，并传入每个成员的键和值。使用返回值而不是原始值。如果此函数返回 undefined，则排除成员。根对象的键是一个空字符串：""。如果 replacer 是一个数组，则仅转换该数组中具有键值的成员。成员的转换顺序与键在数组中的顺序一样。当 value 参数也为数组时，将忽略 replacer 数组*。**space**:可选，文本添加缩进、空格和换行符，如果 space 是一个数字，则返回值文本在每个级别缩进指定数目的空格，如果 space 大于 10，则文本缩进 10 个空格。space 有可以使用非数字，如：\t。
```json
//例如我们向服务器发送以下数据：
var obj = { "name":"baidu", "alexa":10000, "site":"www.baidu.com"};
//使用 JSON.stringify() 方法处理以上数据，将其转换为字符串：
var myJSON = JSON.stringify(obj);
//myJSON 为字符串,可以将 myJSON 发送到服务器：
//实例
var obj1 = { "name":"baidu", "alexa":10000, "site":"www.baidu.com"};
var myJSON1 = JSON.stringify(obj1);
document.getElementById("demo").innerHTML = myJSON1;
```

| 函数签名                                     | 作用                | 方向                 |
| ---------------------------------------- | ----------------- | ------------------ |
| JSON.parse(text[, reviver])              | 将**接收**的字符串转为JS对象 | (JSON)字符串---->JS对象 |
| JSON.stringify(value[, replacer[, space]]) | 将**发送**的JS对象转为字符串 | JS对象---->(JSON)字符串 |



ref:
1.[JavaScript JSON](http://www.runoob.com/js/js-json.html),  2.[JS操作JSON总结](http://www.cnblogs.com/worfdream/articles/1956449.html),  3.[【简明教程】JSON](http://www.jianshu.com/p/8b428e1d1564),  4.[JSON 语法](http://www.runoob.com/json/json-syntax.html),  5.[JSON 对象](http://www.runoob.com/json/js-json-objects.html),  6.[JSON 数组](http://www.runoob.com/json/js-json-arrays.html),  7.[JSON.parse()](http://www.runoob.com/json/json-parse.html),  8.[JSON.stringify()](http://www.runoob.com/json/json-stringify.html)