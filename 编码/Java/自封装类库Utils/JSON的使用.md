###JSON的使用

***

##### Fastjson

是一个Java语言编写的高性能功能完善的JSON库，主要特性主要体现在以下几个方面:

1.高性能

fastjson采用独创的算法，将parse的速度提升到极致，超过所有json库，包括曾经号称最快的jackson。并且还超越了google的二进制协议protocol buf。

2.功能强大

支持各种JDK类型。包括基本类型、JavaBean、Collection、Map、Enum、泛型等。

3.无依赖

不需要例外额外的jar，能够直接跑在JDK上。

4.支持范围广

5.开源



##### 常用情况

1.String 转 Json
```java
@Test
public void test(){
    String str = "{\"age\":\"24\",\"name\":\"cool_summer_moon\"}";  
    JSONObject  jsonObject = JSONObject.parseObject(str);
    System.out.println("json对象是：" + jsonObject);
    Object object = jsonObject.get("name");
    System.out.println("name值是："+object);
}
```

运行结果：
`json对象是：{"name":"cool_summer_moon","age":"24"}`
 `name值是：cool_summer_moon123`


2.Json 转 String
```java
@Test
public void test(){
    String str = "{\"age\":\"24\",\"name\":\"cool_summer_moon\"}";
    JSONObject  jsonObject = JSONObject.parseObject(str);
    //json对象转字符串
    String jsonString = jsonObject.toJSONString();
    System.out.println("json字符串是：" + jsonString);
}
```

运行结果：
`json字符串是：{"name":"cool_summer_moon","age":"24"}`


3.String 转 Map
```java
@Test
public void test(){
    String str = "{\"age\":\"24\",\"name\":\"cool_summer_moon\"}";
    JSONObject  jsonObject = JSONObject.parseObject(str);
    //json对象转Map
    Map<String,Object> map = (Map<String,Object>)jsonObject;
    System.out.println("map对象是：" + map);
    Object object = map.get("age");
    System.out.println("age的值是"+object);
}
```

运行结果：
`map对象是：{"name":"cool_summer_moon","age":"24"}`
`age的值是24123`


4.Map 转 String
```java
@Test
public void test(){
    Map<String,Object> map = new HashMap<>();
    map.put("age", 24);
    map.put("name", "cool_summer_moon");
    String jsonString = JSON.toJSONString(map);
    System.out.println("json字符串是："+jsonString);
}
```

运行结果：
`json字符串是：{"name":"cool_summer_moon","age":24}`


5.Map 转 Json
```java
@Test
public void test(){
    Map<String,Object> map = new HashMap<>();
    map.put("age", 24);
    map.put("name", "cool_summer_moon");
    JSONObject json = new JSONObject(map);
    System.out.println("Json对象是：" + json);
}
```

运行结果：
`Json对象是：{"name":"cool_summer_moon","age":24}`


6.Json 转 Map
见示例3



##### 例子

```java
import com.alibaba.fastjson.JSONObject;
import java.util.HashMap;

public class Test
{
    public static void main(String[] args)
    {
        //map->json
        HashMap<String,Object> jsonMap=new HashMap<>();
        jsonMap.put("markId",1231312);
        JSONObject json = new JSONObject(jsonMap);
        System.out.println("Json对象是：" + json);
        
        //str->json
        String str = "{\"age\":\"24\",\"name\":\"cool_summer_moon\"}";
        JSONObject  jsonObject = JSONObject.parseObject(str);
        System.out.println("json对象是：" + jsonObject);
        Object object = jsonObject.get("name");
        System.out.println("name值是："+object);
    }
}
```



##### 转换例子

###### 序列化

```java
package com.cqu.rjx.utils.json.fastjson;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: renjiaxin
 * @Despcription:
 * @Date: Created in 2018/8/14 10:57
 * @Modified by:
 */

/**
 * JSON序列化
 */
public class JsonSerialization {

    public static void main(String[] args) {
        /*定义JsonObject*/
        JSONObject jsonObject = new JSONObject();
        //自己初始化
        jsonObject.put("jsonObj", "我是一个json对象");
        //使用map初始化
        Map<String, Object> map1 = new HashMap<>();
        map1.put("map-fill-json", "hello, map-fill-json");
        JSONObject jsonObjectFromMap = new JSONObject(map1);

        /*定义JsonArray*/
        JSONArray jsonArray1 = new JSONArray();
        JSONArray jsonArray2 = new JSONArray(3);
        Map<String, Object> map2 = new HashMap<>();
        map2.put("map2", "map2");
        Map<String, Object> map3 = new HashMap<>();
        map3.put("map3", "map3");
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        list.add(map1);
        list.add(map2);
        list.add(map3);
        jsonArray1.add(0, 123);
        jsonArray1.add(1, "hello");
        jsonArray1.add(2, "mgk");
        jsonArray2.add(list);
        //JSONArray jsonArray3 = new JSONArray(list);//现在还不可将map直接放到jsonArray之中, 没有这种类型的构造函数
        JSONArray jsonArray3 = new JSONArray(2);
        List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
        Map<String, Object> map4 = new HashMap<>();
        Map<String, Object> map5 = new HashMap<>();
        map4.put("hello mpa", "helllomap");
        map5.put("zgy", "zuiguangyin");
        list2.add(map4);
        list2.add(map5);
        jsonArray3.add(0, list);
        jsonArray3.add(1, list2);

        /**序列化, 将其他的格式转换成为jsonstr(json字符串),最好统一使用JSON来转换**/
        //jsonObject--->json字符串;
        System.out.println("\njsonObject--->json字符串");
        String jsonObjectStr = JSON.toJSONString(jsonObject);
        System.out.println("jsonObject的json字符串: " + jsonObjectStr);

        //jsonArray--->json字符串;
        System.out.println("\njsonArray--->json字符串");
        String jsonArrayStr1 = JSON.toJSONString(jsonArray1);
        System.out.println("jsonArrayStr1的json字符串: " + jsonArrayStr1);
        String jsonArrayStr2 = JSON.toJSONString(jsonArray2);
        System.out.println("jsonArrayStr2的json字符串: " + jsonArrayStr2);
        String jsonArrayStr3 = JSON.toJSONString(jsonArray3);
        System.out.println("jsonArrayStr3的json字符串: " + jsonArrayStr3);


        //java对象--->json字符串
        PersonJson personJson1 = new PersonJson();
        PersonJson personJson2 = new PersonJson();
        personJson1.setName("张三");
        personJson1.setAge(24);
        personJson2.setAge(29);
        personJson2.setName("junliang lee");
        System.out.println("\njava对象--->json字符串");
        String javaObjectStr1 = JSON.toJSONString(personJson1);
        System.out.println("java对象personJson1的json字符串: " + javaObjectStr1);
        String javaObjectStr2 = JSON.toJSONString(personJson2);
        System.out.println("java对象personJson2的json字符串: " + javaObjectStr2);
    }

    static class PersonJson {
        @Getter
        @Setter
        private int age;
        @Getter
        @Setter
        private String name;
    }
}
```

###### 反序列化

```java
package com.cqu.rjx.utils.json.fastjson;

/**
 * @Author: renjiaxin
 * @Despcription:
 * @Date: Created in 2018/8/14 14:05
 * @Modified by:
 */

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;

/**
 * JSON反序列化
 */
public class JsonDeserialization {
    public static void main(String[] args) {
        /*定义json字符串的方法*/
        /*最外面需要用双引号包围, 所有的双引号都需要用'\"'来转义, ":"冒号不需要转义,
         *定义jsonarray字符串时, 内层的[,],{,}不需要转义, 只转义"双引号
         **/

        //定义一个json的字符串
        String guanyu = "{\"name\":\"关羽\", \"age\":\"24\"}";


        //定义两个jsonArray的字符串
        String starsWest = "[{\"name\":\"justin biber\", \"age\":\"22\"}, {\"name\":\"mike\", \"age\":\"17\"}, "
                + " {\"国籍\":\"美国\"}, {\"name\":\"bulanni\",\"age\": 36, ,\"nation\":\"uk\"}]";

        String starsJapan = "[{\"name\":\"大桥未久\", \"age\":\"24\"}, {\"name\":\"天海翼\", \"age\":\"24\"}, {\"国籍\":\"日本\"}]";

        String mapKeyValue = "[{\"key1\":\"One\",\"key2\":\"Two\"},{\"key3\":\"Three\",\"key4\":\"Four\"}]";


        //定义两个java对象的字符串
        String lionAl = "{\"name\":\"非洲狮\",\"territory\":\"尼日利亚\"}";
        String lionSl = "{\"name\":\"美洲狮\",\"territory\":\"巴西\"}";


        //json字符串--->jsonObject;
        /*JSONObject相当于一个Map<String , Object>*/
        System.out.println("\njson字符串--->jsonObject");
        System.out.println("原先的json字符串: " + guanyu);
        JSONObject jsonObject1 = JSON.parseObject(guanyu);
        System.out.println("转换后获取其中的name值: " + jsonObject1.get("name"));


        //json字符串--->jsonArray;
        System.out.println("\njson字符串--->jsonArray");
        System.out.println("原先的jsonArray字符串starsWest: " + starsWest);
        System.out.println("原先的jsonArray字符串starsJapan: " + starsJapan);
        System.out.println("原先的jsonArray字符串mapKeyValue: " + mapKeyValue);

        /*JSONArray相当于JsonObject的数组, 对应的是List<Map>*/
        List<Map> jsonArray1 = JSON.parseArray(starsWest, Map.class);//转换的时候, 需要用相应的类型来盛下
        List<Map> jsonArray2 = JSON.parseArray(starsJapan, Map.class);
        List<Map> jsonArray3 = JSON.parseArray(mapKeyValue, Map.class);
        System.out.println("starsWest的情况: " + jsonArray1.get(1));
        System.out.println("starsJapan的情况: " + jsonArray2.size() + jsonArray2.get(1));
        System.out.println("mapKeyValue的情况: " + jsonArray3.size() + ", " + jsonArray3.get(1));
        // 循环获取map的值
        for (Map<String, Object> map : jsonArray2) {
            System.out.println(map.get("name"));
            System.out.println(map.get("age"));
        }

        //json字符串--->java对象
        System.out.println("\njson字符串--->java对象");
        System.out.println("原先的json字符串: " + lionAl);
        System.out.println("原先的json字符串: " + lionSl);
        Lion lionA = JSON.parseObject(lionAl, Lion.class);
        Lion lionS = JSON.parseObject(lionSl, Lion.class);
        System.out.println("转换后获取其中的name和territory值: " + lionA.getName() + ", " + lionA.getTerritory());
        System.out.println("转换后获取其中的name和territory值: " + lionS.getName() + ", " + lionS.getTerritory());

    }

    static class Lion {
        @Getter
        @Setter
        private String name;
        @Getter
        @Setter
        private String territory;//领地
    }
}
```

###### 使用经验小结

> JSON的序列化和反序列化
> *JSONObject相当于一个Map\<String , Object\>*
> *JSONArray相当于JsonObject的数组, 对应的是List\<Map\>*
> 反序列化的时候, 转换的时候, 需要用相应的类型来盛下
>
> ###### 转换
>
> 1. String--->Map 和Map--->String 其实就是 json字符串str<--->json object的转换
>
> 2. String<--->JSONArray的转换(反序列化的时候, 转换的时候, 需要用相应的类型来盛下)
>
>      
>
> **转换的时候,一般使用JSON来操作**



ref:
1.[使用FastJSON 对Map/JSON/String 进行互转](https://blog.csdn.net/cool_summer_moon/article/details/78722623)