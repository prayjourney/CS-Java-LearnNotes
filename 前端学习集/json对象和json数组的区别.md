### json对象和json数组的区别
---
##### 简单区别
```js
var infoJson = {
    "name":"JSON","address":"北京市西城区","age":25
} //普通json对象
var sss =[
    {"name":"JSON1","address":"北京市西城区1","age":25},
    {"name":"JSON2","address":"北京市西城区2","age":33},
    {"name":"JSON3","address":"北京市西城区3","age":22}
];//数组对象

// 就我的感觉，json数组和普通json对象的区别就是，json对象是单个的，
// 而json数组是里面包含多个元素的， 此外，json对象里面可以包含数组，
var infoJsonAddress = {
    "name":"JSON",
    "address":["北京","上海","深圳"],
    "age":25
} //普通json对象包含数组
```



##### 在MongoDB之中的简单操作
```js
use test;

db.info.insert({
    name: "zhangsan",
    age: 28,
    info: [{
        movie: "hero"
    }, {
        address: "beijin"
    }, {
        lover: "marry"
    }]
})
db.hello.insert({
    name: ["mm1", "mw", "gt"]
})
db.hello.find()
var sss = db.info.findOne().age;
sss
# https://www.runoob.com/mongodb/mongodb-insert.html
```

---
ref：
1.[json对象和json字符串](https://blog.51cto.com/11871779/2105308),   2.[javascript中json对象、json数组、json字符串互转及取值](https://blog.csdn.net/ITYang_/article/details/79611952),   3.[JSON数组，JSON对象，数组的区别](https://blog.csdn.net/gao_sl/article/details/81699063)