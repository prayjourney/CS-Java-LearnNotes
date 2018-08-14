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


ref:
1.[使用FastJSON 对Map/JSON/String 进行互转](https://blog.csdn.net/cool_summer_moon/article/details/78722623)