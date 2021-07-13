### HashMap的遍历

***

总的来说, 有5种遍历, 其中1种是仅遍历了values, 4种完全遍历了整个的map, 分类和原理介绍如下



##### 划分
Map的遍历: 
**遍历方式**: 分为**foreach**和**iterator**两种, *foreach效率好一点*. 这是方式上面的区别, 还有在使用的遍历因子的不同;
**遍历因子**: 按照遍历因子来划分,  则有**keySet()**和**entrySet()**两种, map的内部功能有Map.Entry接口实现, keySet()是直接取到keys, entrySet是首先取到每一个entry, 然后使用entry的getKey() 和 getValue()来完整的实现遍历, 速度要更好.



##### CreateTraversal.java(使用例子)

```java
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * @Author: renjiaxin
 * @Despcription:
 * @Date: Created in 2018/8/17 9:52
 * @Modified by:
 */
@Slf4j
public class CreateTraversal {
    public static Map<String, Object> createMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("天海翼", "36C");
        map.put("小泽玛利亚", "42F");
        map.put("", "");//可以的, 这样定义也可以
        map.put(null, null);/*key可以为null, 但是只能有一个, 只有一个起作用*/
        map.put(null, null);
        map.put("波多野结衣", "36C");
        map.put("苍井空", "28B");
        map.put(" ", " ");//可以的, 这样定义也可以
        map.put("小仓优子", "26A");
        map.put("深田恭子", null);
        map.put("雨宫琴音", "36C");
        map.put("北条麻妃", null);//value为null, 资料暂空, value为null可以有多个
        map.put("青山葵", "43F");

        return map;
    }

    public static void traversalMap(Map<String, Object> map, int type) {
        if (type < 0 || type > 4) {
            log.warn("错误的遍历类型, type:{}", type);
        }
        switch (type) {
            case 0:
                partForEachTraversal(map);
                break;
            case 1:
                forEachKeySetTraversal(map);
                break;
            case 2:
                forEachEntrySetTraversal(map);
                break;
            case 3:
                iteratorKeySetTraversal(map);
                break;
            case 4:
                System.out.println("推荐map.entrySet()+iterator");
                iteratorEntrySetTraversal(map);
                break;
            default:
                iteratorEntrySetTraversal(map);

        }
    }

    /*只是遍历了values, 没有遍历keys*/
    private static void partForEachTraversal(Map<String, Object> map) {
        System.out.println("\n使用values来循环, 只能遍历values, 无法遍历keys");
        long start = System.currentTimeMillis();
        for (Object value : map.values()) {
            System.out.print(value + " ");
        }
        long end = System.currentTimeMillis();
        long time = start - end;
        System.out.println("\nmap的大小n: " + map.values().size());
        System.out.println("运行时间为: " + time + "ms");
        System.out.println("");

    }

    /*map.keySet()+foreach*/
    private static void forEachKeySetTraversal(Map<String, Object> map) {
        System.out.println("map.keySet()+foreach, 完成遍历, 速度慢!");
        long start = System.currentTimeMillis();
        for (String key : map.keySet()) {
            System.out.print("key: " + key + ", values: " + map.get(key) + "; ");
        }
        long end = System.currentTimeMillis();
        long time = start - end;
        System.out.println("\nmap的大小n: " + map.values().size());
        System.out.println("运行时间为: " + time + "ms");
        System.out.println("");
    }

    /*map.entrySet()+foreach*/
    private static void forEachEntrySetTraversal(Map<String, Object> map) {
        System.out.println("map.entrySet()+foreach, 完成遍历, 速度快!");
        System.out.println("Map.Entry是Map类内部的一个接口,提供了Map类的主体方法和功能");
        long start = System.currentTimeMillis();
        Set<Map.Entry<String, Object>> entrySet = map.entrySet();//把这个set取出来
        for (Map.Entry<String, Object> entry : entrySet) {/*---*/
            System.out.print("key= " + entry.getKey() + " and value= " + entry.getValue() + "; ");
        }
        long end = System.currentTimeMillis();
        long time = start - end;
        System.out.println("\nmap的大小n: " + map.values().size());
        System.out.println("运行时间为: " + time + "ms");
        System.out.println("");
    }


    /*map.keySet()+iterator*/
    private static void iteratorKeySetTraversal(Map<String, Object> map) {
        System.out.println("map.keySet()+iterator, 完成遍历");
        long start = System.currentTimeMillis();
        Iterator<String> it = map.keySet().iterator();/**/
        while (it.hasNext()) {
            System.out.print("key :" + it.next() + " , value: " + map.get(it.next()));
        }
        long end = System.currentTimeMillis();
        long time = start - end;
        System.out.println("\nmap的大小n: " + map.values().size());
        System.out.println("运行时间为: " + time + "ms");
        System.out.println("");
    }

    /*map.entrySet()+iterator*/
    private static void iteratorEntrySetTraversal(Map<String, Object> map) {
        System.out.println("map.entrySet()+iterator, 完成遍历, 推荐的做法!");
        long start = System.currentTimeMillis();
        //Iterator it = map.entrySet().iterator();/*---*/
        Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();//上下相同, 这个清晰一些
        while (it.hasNext()) {
            System.out.print("key :" + it.next() + " , value: " + map.get(it.next()));
        }
        long end = System.currentTimeMillis();
        long time = start - end;
        System.out.println("\nmap的大小n: " + map.values().size());
        System.out.println("运行时间为: " + time + "ms");
        System.out.println("");
    }

    public static void main(String[] args) {
        System.out.println("由于map使用key-value形式的数据结构,所以没有使用数字形式的位置,不可使用for(int i=0;i<n;i++形式)");
        Map<String, Object> mp = createMap();
        traversalMap(mp, 0);
        traversalMap(mp, 1);
        traversalMap(mp, 2);
        traversalMap(mp, 3);
        traversalMap(mp, 4);
    }
}
```



ref:

1.[遍历HashMap的四种方法](https://www.cnblogs.com/Berryxiong/p/6144086.html),   2.[HashMap遍历和使用](https://blog.csdn.net/zhangfengBX/article/details/76783348),   3.[Java中如何遍历Map对象的4种方法](https://blog.csdn.net/tjcyjd/article/details/11111401),   4.[Java中遍历Map的各种方式](https://www.jianshu.com/p/3d1fb84b2b63),   5.[HashMap遍历的两种方式，推荐使用entrySet()](https://blog.csdn.net/xueyepiaoling/article/details/5217709),   6.[HashMap循环遍历方式及其性能对比](http://www.trinea.cn/android/hashmap-loop-performance/),   7.[JCFInternals](https://github.com/prayjourney/JCFInternals)