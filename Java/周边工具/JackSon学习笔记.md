## JackSon学习笔记

Jackson是当下最灵活，最可靠的Json处理工具之一，本文将给出Jackson的功能概览。

<hr/>
#### JSON的三种处理方式
Jackson提供了三种可选的JSON处理方法（一种方式及其两个变型）：

- [数据绑定](http://www.yiidian.com/jackson/jackson-simple-data-binding.html)： JSON和POJO相互转换，基于属性访问器规约或注解。
  - 有两种模式： *简单* 和 *完整* 的数据绑定：
    - **简单数据绑定：** 是指从Java Map、List、String、Numbers、Boolean和空值进行转换
    - **完整数据绑定** ：是指从任何 Java bean 类型 （及上文所述的"简单"类型） 进行转换
  - `com.fasterxml.jackson.databind.ObjectMapper`对两个变种，进行写JSON和读JSON。
  - 这种方式可以方便的进行对象的序列化和反序列化。
  - [JAXB](http://www.microsofttranslator.com/bv.aspx?from=&to=zh-CHS&a=http%3A%2F%2Fwww.jcp.org%2Fen%2Fjsr%2Fdetail%3Fid%3D222)激励下的基于注释的 （代码优先）变种。
  
- [树型结构](http://www.yiidian.com/jackson/jackson-tree-model.html) ：提供一个 JSON 文档可变内存树的表示形式。
  - `com.fasterxml.jackson.databind.ObjectMapper`生成树 ；JsonNode是树的成员，树通过JsonNode处理, JsonNode的位置在`com.fasterxml.jackson.databind.JsonNode`。
  - 树模型类似于 XML 或者是HTML的DOM 树。
  
- [流式API](http://www.yiidian.com/jackson/jackson-streaming-api.html)：（也称为"增量分析/生成"） 读取和写入 JSON 内容作为离散事件。
  - `com.fasterxml.jackson.core.JsonParser`读， `com.fasterxml.jackson.core.JsonGenerator`写。

从使用的角度来看，总结这些3 种方法的用法如下：

- [数据绑定](http://www.yiidian.com/jackson/jackson-simple-data-binding.html)：使用最方便的方式。
- [树模型](http://www.yiidian.com/jackson/jackson-tree-model.html) ： 最灵活的方式。
- [流式API](http://www.yiidian.com/jackson/jackson-streaming-api.html)： 性能最佳的方式 （最低开销、 速度最快的读/写； 其它二者基于它实现）。


<hr/>

#### 处理JSON的三种方式的特点
Jackson提供了三种处理JSON的方法, 特点和功能如下：
- **数据绑定**: 使用属性访问器或使用注解在JSON与POJO（普通Java对象）之间进行转换。它有两种类型。
- **简单数据绑定**：在List集合，String，数值，布尔值和NULL对象之间来回转换JSON。
  - **完全数据绑定**：将JSON与任何Java类型相互转换。

- **数据流API**: 读取和写入JSON内容作为离散事件。JsonParser读取数据，而JsonGenerator写入数据。这是这三种方法中功能最强大的一种，开销最低，读/写操作最快。它类似于XML的Stax解析器。

- **JSON树模型**: 把JSON在内存构建成为树状结构。JsonNode节点的ObjectMapper构建树。这是最灵活的方法。它类似于XML的DOM解析器。

ObjectMapper提供了读取/写入以上两种数据类型绑定的JSON的方法。**数据绑定是最方便的方法**，类似于XML的JAXB解析器。鉴于这些特性，让我们考虑以相反的顺序，以Java开发人员最自然和方便的方法开始使用： [Jackson数据绑定 API](http://www.yiidian.com/jackson/what-is-jackson.html)。


<hr/>

#### 使用ObjectMapper处理

对于对象，如果我们需要进行对象和字符串之间的转换，那么我们就可以使用ObjectMapper进行转换，这是最简单的方式，主要的方法如下, 需要说明的是，我们在处理json和Object的时候，我们所说的json, 都是指json的字符串，下面使用jsonStr代替：

```java
// 读取字符串，jsonStr -> obj
com.fasterxml.jackson.databind.ObjectMapper#readValue
// 写字符串，obj -> jsonStr，此处的字符串可以是JavaBean，Map, List或者其他的对象  
com.fasterxml.jackson.databind.ObjectMapper#writeValueAsString
```
上面是obj和jsonStr之间的转化, 下面主要是obj序列化和反序列化的API

```java
// obj 序列化为json文件
com.fasterxml.jackson.databind.ObjectMapper#writeValue(java.io.File, java.lang.Object)
// obj 反序列化，从json文件中获取对象
com.fasterxml.jackson.databind.ObjectMapper#readValue(java.io.File, java.lang.Class<T>)
```

代码例子如下：

```java
//================================================================================//
//========================使用ObjectMapper, 来完成解析和转换===========================//
//================================================================================//

private static ObjectMapper mapper = new ObjectMapper();

// jsonStr -> obj
public static Object str2Obj(String str, Class cls) throws JsonProcessingException {
    Object obj = mapper.readValue(str, cls);
    return obj;
}

// obj -> jsonStr
public static String obj2Str(Object obj) throws JsonProcessingException {
    String str = mapper.writeValueAsString(obj);
    return str;
}

// obj 序列化为json文件
public static void objWrite2JSON(Object obj, String fileName) throws IOException {
    ObjectMapper mapper = new ObjectMapper();
    mapper.writeValue(new File(fileName), obj);
}

// obj 反序列化，从json文件中获取对象
public static Object readJSON2Obj(File file, Class cls) throws IOException {
    Object object = mapper.readValue(file, cls);
    return object;
}
```

正如上述的例子和上述的API，使用ObjectMapper来操作，最方便的是直接转化，把jsonStr转换为obj，把obj转换为jsonStr, 以及后续的obj的序列化和反序列化，这都是ObjectMapper最方便的地方，而对于我们直接去创建一个jsonStr, 使用ObjectMapper并不是非常的方便，当然这样也是可以的，操作办法就是把我们需要的类型，转换成一个Java Bean, 这样的话，创建一个对象，然后使用`writeValueAsString`就可以得到他对应的字符串了，这种对于比较规则的或者层次结构比较浅的对象来说，是比较方便的，但是对于层次比较深，或者不规则的结构，就是比较麻烦的。

另一方面，如果使用过`fastjson`的同学常常可能会有一个疑问，那就是在`jackson`之中难道就没有直接可以创建`JSONObject`或者是`JSONArray`的方法，或者是直接创建的对象吗？这个时候，如果我们仅仅掌握了ObjectMapper的话，那就会有点捉襟见肘了，因为就目前来看，`jackson`之中，确实是没有直接创建JSONObject和JSONArray的方法的，而且，在`jackson`之中，其实最重要的概念，在我看来，就是三个，~~obj~~，~~jsonStr~~，~~Node~~， 在我看来，这就是转换的关系，obj和jsonStr是常规的转换关系，`代表的是存在的东西的转换`，不管是已经存在的对象，或者是已经存在的字符串，都是存在的，所以这个时候，我们不必去构建，通过这些转换，我们就可以拿到他们的不同形态的值，但是这些如果对于一个需要创建出来的东西而言，那就是比较复杂的，所以这个时候我们需要的不仅仅是转换，更多的是创建，这就是jackson树形结构的存在意义, 比如, 如下的这种字符串，不管是从构造Java Bean或者是直接构造，都是比较复杂的。

```java
String str ="{\"city\":{\"name\":\"成都\",\"province\":\"四川省\",\"postCode\":\"232341\",\"area\":476522.0}," +
                "\"ls\":[\"张三\",\"李四\",\"Lily\",\"小明\"],\"name\":\"hello\"}";

String jsonArrayStr = "[{\"name\":\"张三\",\"age\":22},{\"name\":\"李四\",\"age\":22,\"school\":\"清华大学\"," +
                "\"home\":\"洛阳\",\"gender\":\"男\"},{\"city\":\"天水\"}]";
```


<hr/>

#### 使用树型结构处理

使用树形结构处理json, 最关键的问题就是要把我们处理的obj或者是jsonStr，都当做是一棵树，所以，`读树`，`写树`就是这种处理方式的重点。树型处理的常用类和方法：

```java
/**
  * 常用的类
  */
// 节点
com.fasterxml.jackson.databind.JsonNode
// 节点工厂
com.fasterxml.jackson.databind.node.JsonNodeFactory
// Json生成器
com.fasterxml.jackson.core.JsonGenerator
    
// 对象节点
com.fasterxml.jackson.databind.node.ObjectNode
// 数组节点
com.fasterxml.jackson.databind.node.ArrayNode
    
/**
  * 常用的方法
  */
// 读取
com.fasterxml.jackson.databind.ObjectMapper#readTree(java.lang.String)
// 写入    
com.fasterxml.jackson.databind.ObjectMapper#writeTree(com.fasterxml.jackson.core.JsonGenerator, com.fasterxml.jackson.databind.JsonNode)

// 获取JsonNodeFactory， 全局可用
JsonNodeFactory jsonNodeFactory = JsonNodeFactory.instance;
// 生成JsonFactory
JsonFactory jsonFactory = new JsonFactory();
// 写入流
StringWriter writer = new StringWriter();
// JsonGenerator生成器
JsonGenerator generator = jsonFactory.createGenerator(writer);
```

##### 简单的使用

```java
// 创建 jsonArray的String
public static void createJsonArrayString() throws IOException {
    JsonNodeFactory jsonNodeFactory = JsonNodeFactory.instance;
    // 当做根节点
    ArrayNode arrayNode = jsonNodeFactory.arrayNode();
    ObjectNode rootNode1 = jsonNodeFactory.objectNode();
    ObjectNode rootNode2 = jsonNodeFactory.objectNode();
    ObjectNode rootNode3 = jsonNodeFactory.objectNode();
    rootNode1.put("name", "张三");
    rootNode1.put("age", 22);
    rootNode2.put("name", "李四");
    rootNode2.put("age", 22);
    rootNode2.put("school", "清华大学");
    rootNode2.put("home", "洛阳");
    rootNode2.put("gender", "男");
    rootNode3.put("city", "天水");
    arrayNode.add(rootNode1);
    arrayNode.add(rootNode2);
    arrayNode.add(rootNode3);
    JsonFactory jsonFactory = new JsonFactory();
    StringWriter writer = new StringWriter();
    JsonGenerator generator = jsonFactory.createGenerator(writer);
    mapper.writeTree(generator, arrayNode);
    System.out.println(writer.toString());
    // [{"name":"张三","age":22},{"name":"李四","age":22,"school":"清华大学","home":"洛阳","gender":"男"},{"city":"天水"}]
}

// 解析 jsonArray的String
public static void readJsonArrayString(String str) throws JsonProcessingException {
    // 使用ObjectMapper的readValue方法将json字符串解析到JsonNode实例中
    JsonNode rootNode = mapper.readTree(str);
    // 直接从rootNode中获取某个键的值, 这种方式在如果我们只需要一个长json串中某个字段值时非常方便
    if (rootNode.isArray()){
        int size = rootNode.size();
        for (int i = 0; i < size; i++){
            // 获取每一个子node下面的所有的节点，包括key和value
            Iterator<Map.Entry<String, JsonNode>> fields = rootNode.get(i).fields();
            while(fields.hasNext()){
                Map.Entry<String, JsonNode> nodeKey = fields.next();
                System.out.print("key: " + nodeKey.getKey() + ",  value: " + nodeKey.getValue() + "  . ");
            }
            System.out.println("  第" + i + "个节点遍历完毕！");
        }
    }
}
```

##### 封装的方法

```java
//================================================================================//
//========================使用树形模型, 读写与转换jsonString内容=========================//
//================================================================================//

// 从list(map) -> jsonArray的String
public static <K, V> String list2JsonArrayStr(List<Map<K, V>> list) throws IOException {
    JsonNodeFactory jsonNodeFactory = JsonNodeFactory.instance;
    // 当做根节点
    ArrayNode arrayNode = jsonNodeFactory.arrayNode();
    for (int i = 0; i < list.size(); i++) {
        ObjectNode rootNode = jsonNodeFactory.objectNode();
        Set<Map.Entry<K, V>> entries = list.get(i).entrySet();
        Iterator<Map.Entry<K, V>> iterator = entries.iterator();
        while(iterator.hasNext()){
            Map.Entry<K, V> kvEntry = iterator.next();
            rootNode.put(kvEntry.getKey().toString(), kvEntry.getValue().toString());
        }
        arrayNode.add(rootNode);
    }
    JsonFactory jsonFactory = new JsonFactory();
    StringWriter writer = new StringWriter();
    JsonGenerator generator = jsonFactory.createGenerator(writer);
    mapper.writeTree(generator, arrayNode);
    return writer.toString();
}

// 从jsonArray的String -> list(map)
public static <K, V> List<Map<K, V>> jsonArrayStr2List(String str) throws JsonProcessingException {
    List<Map<K, V>> list = new ArrayList<>();
    JsonNode rootNode = mapper.readTree(str);
    if (rootNode.isArray()) {
        int size = rootNode.size();
        for (int i = 0; i < size; i++) {
            // 获取每一个子node下面的所有的节点，包括key和value
            Iterator<Map.Entry<String, JsonNode>> fields = rootNode.get(i).fields();
            Map<K, V> map = new HashMap<>();
            while (fields.hasNext()) {
                Map.Entry<String, JsonNode> nodeKey = fields.next();
                map.put((K) nodeKey.getKey(), (V) nodeKey.getValue().asText());
            }
            list.add(map);
        }
    }
    return list;
}
```

需要说明的是，我们在使用树形处理的时候，仍然是需要`ObjectMapper`对象的，在读的第一道工序和写的最后一道工序，都由其来进行相关的处理。
<hr/>

#### 使用流式API处理

其实上述的树模型处理，已经涉及到了流式处理，纯粹的[树模型处理](https://www.yiibai.com/jackson/jackson_tree_model.html), 主要集中的点在于`从jsonStr到树的转换`和`树的遍历`这两个点，所以，只是使用树模型处理的情况，就应该让我已经写好原始的jsonStr, 比如有如下的：

```java
ObjectMapper mapper = new ObjectMapper();	
String jsonString = "{\"name\":\"Mahesh Kumar\", \"age\":21,\"verified\":false,\"marks\": [100,90,85]}";
JsonNode rootNode = mapper.readTree(jsonString);
JsonNode nameNode = rootNode.path("name");
System.out.println("Name: "+ nameNode.getTextValue());
 
JsonNode marksNode = rootNode.path("marks");
Iterator iterator = marksNode.getElements();

// 然后我们便可以去遍历，处理，转换，进行obj， 序列换之间的转换
```

但是，如果是仅仅上面的情况，那如果我们要处理自定义的情况，自己去任意的写一些JSONArray，JSONObject的话，还是比较难以实现，所以在`写树`的方法之中，就需要使用流式API。流式API的常用类和方法：

```java
/**
  * 常用的类
  */
// JsonFactory
com.fasterxml.jackson.core.JsonFactory
// 节点
com.fasterxml.jackson.databind.JsonNode
// 节点工厂
com.fasterxml.jackson.databind.node.JsonNodeFactory
// Json生成器
com.fasterxml.jackson.core.JsonGenerator
// Json解析器
com.fasterxml.jackson.core.JsonParser
    
// 对象节点
com.fasterxml.jackson.databind.node.ObjectNode
// 数组节点
com.fasterxml.jackson.databind.node.ArrayNode
    
/**
  * 常用的方法
  */
// 读取
com.fasterxml.jackson.databind.ObjectMapper#readTree(java.lang.String)
// 写入    
com.fasterxml.jackson.databind.ObjectMapper#writeTree(com.fasterxml.jackson.core.JsonGenerator, com.fasterxml.jackson.databind.JsonNode)

// 获取JsonNodeFactory， 全局可用
JsonNodeFactory jsonNodeFactory = JsonNodeFactory.instance;
// 生成JsonFactory
JsonFactory jsonFactory = new JsonFactory();
// 写入流
StringWriter writer = new StringWriter();
// JsonGenerator生成器
JsonGenerator generator = jsonFactory.createGenerator(writer);
// JsonParser解析器
JsonParser jsonParser = jsonFactory.createParser(str);
// 当前节点的名称
String fieldName = jsonParser.getCurrentName();
```

##### 简单的使用

```java
// 使用jackson的JsonParser来解析JSON对象, 可以从字符串解析，也可以从文件解析
public static void parse4String(String str) throws IOException {
    JsonFactory jsonFactory = new JsonFactory();
    JsonParser jsonParser = jsonFactory.createParser(str);
    while (jsonParser.nextToken()!= JsonToken.END_OBJECT){
        String fieldName = jsonParser.getCurrentName();

        if ("name".equals(fieldName)) {
            jsonParser.nextToken();
            System.out.println(jsonParser.getText());
        }
        if("age".equals(fieldName)){
            jsonParser.nextToken();
            System.out.println(jsonParser.getNumberValue());
        }
        if("verified".equals(fieldName)){
            jsonParser.nextToken();
            System.out.println(jsonParser.getBooleanValue());
        }
        if("marks".equals(fieldName)){
            //move to [
            jsonParser.nextToken();
            // loop till token equal to "]"
            while (jsonParser.nextToken() != JsonToken.END_ARRAY) {
                System.out.println(jsonParser.getNumberValue());
            }
        }
    }
}

// 使用jackson的JsonGenerator来构建JSON对象, 写入到字符串
public static void generate2String() throws IOException {
    StringWriter sw = new StringWriter();
    JsonFactory jsonFactory = new JsonFactory();
    JsonGenerator jsonGenerator = jsonFactory.createGenerator(sw);
    // 开始写入
    jsonGenerator.writeStartObject();
    // 写入字段和值
    jsonGenerator.writeStringField("name", "eric");
    jsonGenerator.writeNumberField("age", 21);
    jsonGenerator.writeBooleanField("verified", false);
    jsonGenerator.writeStringField("name", "eric");

    // 写入Array
    jsonGenerator.writeFieldName("marks");
    jsonGenerator.writeStartArray();
    jsonGenerator.writeNumber(100);
    jsonGenerator.writeNumber(90);
    jsonGenerator.writeNumber(85);
    jsonGenerator.writeEndArray();

    // 结束写入
    jsonGenerator.writeEndObject();
    jsonGenerator.close();
    System.out.println(sw.toString());
}
```
上面两个方法，正好一个是解析，一个是生成，是成对出现的。

##### 树型处理和流式API对比
流式API的重点，在于`JsonFactory`,创建`JsonFactory`的对象，然后就可以创建解析器和生成器，`JsonParser`,`JsonGenerator`。

```java
// Json工厂，JsonFactory
JsonFactory jsonFactory = new JsonFactory();
// 解析器， 解析jsonStr，进一步可以 jsonStr -> obj
JsonParser jsonParser = jsonFactory.createParser(str);

// 生成器，生成jsonStr，读取之后转换成jsonStr， 进一步可以 obj->jsonStr
StringWriter sw = new StringWriter();
JsonGenerator jsonGenerator = jsonFactory.createGenerator(sw);
```

树型处理之中使用的Factory是`JsonNodeFactory`，流式API之中使用的Factory是`JsonFactory`,`JsonNodeFactory`管理的是Node，而`JsonFactory`管理的是`JsonGenerator`和`JsonParser`。

```java
// JsonNodeFactory
JsonNodeFactory jsonNodeFactory = JsonNodeFactory.instance;
// arrayNode是根Node
ArrayNode arrayNode = jsonNodeFactory.arrayNode();
ObjectNode rootNode1 = jsonNodeFactory.objectNode();
ObjectNode rootNode2 = jsonNodeFactory.objectNode();
rootNode1.put("name", "张三");
rootNode1.put("age", 22);
rootNode2.put("name", "李四");
rootNode2.put("school", "清华大学");
rootNode2.put("city", "天水");
arrayNode.add(rootNode1);
arrayNode.add(rootNode2);

// JsonFactory
JsonFactory jsonFactory = new JsonFactory();
StringWriter writer = new StringWriter();
JsonGenerator generator = jsonFactory.createGenerator(writer);
// 使用到了arrayNode
mapper.writeTree(generator, arrayNode);
// 装载到了writer之中
System.out.println(writer.toString());
```

参考：

> https://www.jb51.net/article/77972.htm
> http://www.yiidian.com/jackson/jackson-quick-start.html
> https://blog.csdn.net/zzti_erlie/article/details/79779253
> https://www.yiibai.com/jackson/jackson_objectmapper.html
> https://www.cnblogs.com/Anidot/articles/9015143.html
> https://www.cnblogs.com/lee0oo0/articles/2652528.html
> https://www.cnblogs.com/turbosha/p/9960432.html
> https://www.cnblogs.com/miaosj/p/10936451.html
> https://www.sxt.cn/jackson/jackson_first_application.html
> http://www.studytrails.com/tag/jackson/
> https://blog.csdn.net/hujkay/article/details/97040048
> https://www.cnblogs.com/zhao1949/p/8191828.html