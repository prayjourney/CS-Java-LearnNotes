### Java IO

***

##### IO流的方向
Java的IO分为传统的io和new io, 传统io是阻塞性的, 而new io是非阻塞性的. **io的方向以内存为判断标准, 往内存中走, 就是输入, 从内存中出来就是输出**. Java中使用IO(输入输出)来读取和写入, 读写设备上的数据, 硬盘文件, 内存, 键盘......根据数据的走向可分为输入流和输出流, **这个走向是以内存为基准的, 即往内存中读数据是输入流, 从内存中往外写是输出流**. *输入也就是input, input有read方法, 输出也就是output, output有write方法*.
![iodefangxiang](../../../images/iodefangxiang.jpg)



##### IO流的分类
**字节流可以处理所有数据类型的数据, 在java中以Stream结尾, 字符流处理文本数据, 在java中以Reader和Writer结尾**.
Java分为字节流(Stream结尾)和字符流(Reader, Writer结尾)，再分为输入流(InputStream, Reader)和输出流(OutputStream, Write), 输入输出相对于内存而言. 在读字符的时候用字符流, 如文本文件, XML; 在读二进制文件时候用字节流, 如RAR, EXE等不是文本以外的文件(图片). *Buffered开头的流只是加了缓冲区, 为了读写提高效率*. **字符流不能直接输出, 需要转换成字节流才能输出**
)
![inandout](../../../images/inandout.jpg)
![iotixi](../../../images/iotixi.png)



主要的类如下：
1. 文件管理
   File(文件特征与管理) : 用于文件或者目录的描述信息, 例如生成新目录, 修改文件名, 删除文件, 判断文件所在路径等.

2. 字节流
   InputStream(二进制格式操作) : 抽象类, 基于字节的输入操作, 是所有输入流的父类. 定义了所有输入流都具有的共同特征.
   OutputStream(二进制格式操作) : 抽象类. 基于字节的输出操作. 是所有输出流的父类. 定义了所有输出流都具有的共同特征.

3. 字符流
   > Java中字符是采用Unicode标准，一个字符是16位, 即一个字符使用两个字节来表示. 为此, JAVA中引入了处理字符的流. 

   Reader(文件格式操作) : 抽象类，基于字符的输入操作.
   Writer(文件格式操作) : 抽象类，基于字符的输出操作.

4. RandomAccessFile(随机文件操作) : 它的功能丰富, **可以从文件的任意位置进行存取（输入输出）操作**
![iotixi2](../../../images/iotixi2.png)



##### IO流的细分

**InputStream**为字节输入流, 它本身为一个抽象类, 必须依靠其子类实现各种功能, 此抽象类是表示字节输入流的所有类的超类.  继承自InputStream的流都是向程序中输入数据的,且数据单位为字节(8bit); 下面是InputStream所属的子类：
![input1](../../../images/input1.jpg)

`FileInputStream：` 从文件系统中的某个文件中获得输入字节. 哪些文件可用取决于主机环境. `FileInputStream` 用于读取诸如图像数据之类的原始字节流.

**OutputStream**为字节输出流, 是整个IO包中字节输出流的最大父类, OutputStream类也是一个抽象类, 要使用此类必须通过子类实例化对象.其子类有
:![output1](../../../images/output1.jpg)

**Writer**写入字符流的抽象类, 子类必须实现的方法仅有 write(char[], int, int), flush() 和 close(). 但是, 多数子类将重写此处定义的一些方法, 以提供更高的效率和/或其他功能. 其子类如下:
![writer1](../../../images/writer1.jpg)
`BufferedWriter:`将文本写入字符输出流, 缓冲各个字符, 从而提供单个字符, 数组和字符串的高效写入. 可以指定缓冲区的大小, 或者接受默认的大小. 在大多数情况下, 默认值就足够大了.

**Reader**用于读取字符流的抽象类, 子类必须实现的方法只有 read(char[], int, int) 和 close(). 但是, 多数子类将重写此处定义的一些方法, 以提供更高的效率和/或其他功能.  子类有：
![reader1](../../../images/reader1.jpg)



##### IO的操作
1.文件操作(创建文件和文件夹, 查看文件)

```java
//创建一个文件路径
File file = new File("D:\\testData.txt");
if(file.exists()){
//得到文件路径
System.out.println(file.getAbsolutePath());
//得到文件大小
System.out.println("文件大小："+file.length());
}
//创建文件和创建文件夹
File file1 = new File("d:\\iotest.txt");
if(!file1.exists())
{
    try {
        file1.createNewFile();
    } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
}else{
    System.out.println("文件已存在");
}
//创建文件夹
File file2 = new File("d:\\testIO");
if(file2.isDirectory())
{
    System.out.println("文件夹存在");
}else{
    file2.mkdir();
}
 
//列出一个文件夹下的所有文件
File f = new File("d:\\testIO");
if(f.isDirectory())
{
    File lists[] = f.listFiles();
    for(int i=0;i<lists.length;i++)
    {
        System.out.println(lists[i].getName());
    }
}
```

2.Fileinput和Fileoutput
```java
FileInputStream fis = null;
        try {
            fis = new FileInputStream("D:\\testData.txt");
            byte bytes[]=new byte[1024];
            int n=0;
            while((n=fis.read(bytes))!= -1){
                String str = new String(bytes,0,n);
                System.out.print(str);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
FileOutputStream fos = null;
        try {
            fos = new FileOutputStream("D:\\testData.txt");
            String str = "报效国家，舍生忘死";
            byte bytes[] = str.getBytes();
            fos.write(bytes);
        } catch (Exception e) {
            e.printStackTrace();    
        } finally {
            try {
                fos.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
```

3.BufferedInputStream和BufferedouttputStream
```java
/*read=input, write=output*/
@Slf4j
public class UseBufferStream {
    public static void main(String[] args) {
        try {
            String path1 = "D:/poem.txt";
            String path2 = "D:/test.txt";
            String path3 = "F:/我的音乐/日文歌/そばにいるね.mp3";
            String path4 = "D:/そばにいるね.mp3";
            //inputBufferFromConsole();
            //inputBuffer(path1);
            //outputBufferFromConsole(path2);
            outputBuffer(path3, path4);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * 从键盘输入
     *
     * @throws IOException
     */
    public static void inputBufferFromConsole() throws IOException {
        BufferedInputStream bis = new BufferedInputStream(System.in);//从键盘输入
        System.out.println("请输入内容, 换行意味着结束输入:");
        byte[] b = new byte[256];//用一个数组来承接这个流之中的内容

        while (bis.read(b) != -1) {//read, write依旧返回的是数字, 表示当前操作的位置所在, 如果为-1, 则表示
            String s = new String(b);
            System.out.println("我来自内存:");
            System.out.println(s);
            if (s == "q") {//退出, 退出暂时没有作用
                break;
            }
        }
        bis.close();
    }

    /**
     * 从文件输入到内存, 然后显示在console之中
     *
     * @param path
     * @throws IOException
     */
    public static void inputBuffer(String path) throws IOException {
        File file = new File(path);
        if (!file.exists()) {
            log.info("file不存在! path:{}", path);
            try {
                throw new IOException("file不存在!");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));//用file构造一个buffer流
        byte[] s = new byte[1024];
        try {
            while (bis.read(s) != -1) {
                String str = new String(s);
                System.out.println(str);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            bis.close();
        }
    }

    /**
     * 从键盘输入, 然后写入到另一个文件
     *
     * @param path
     * @throws IOException
     */
    public static void outputBufferFromConsole(String path) throws IOException {
        BufferedInputStream bis = new BufferedInputStream(System.in);//从键盘输入
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(path));
        System.out.println("请输入内容, 换行意味着结束输入:");
        try {
            byte[] b = new byte[1024];//用一个数组来承接这个流之中的内容
            while (bis.read(b) != -1) {//将bis的内容读到byte之中
                bos.write(b);//写入到文件之中, 还是不能停止, 这需要想想
                bos.flush();
            }
        } catch (Exception e) {
            log.info("输入输出有问题!", e);
        } finally {
            bis.close();
            bos.close();
        }
    }

    /**
     * 将文件1写入到文件2之中
     *
     * @param path1
     * @param path2
     */
    public static void outputBuffer(String path1, String path2) {
        try {
            File file1 = new File(path1);
            File file2 = new File(path2);//此文件是复制的目的文件, 不存在, 需要创建
            file2.createNewFile();
            BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file1));
            BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file2));
            byte[] temp = new byte[1024];
            while (bis.read(temp) != -1) {
                bos.write(temp);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

```

4.FileReder和FileWriter
```java
public class UseReaderWriter {
    public static void main(String[] args) throws IOException {
        String path1 = "D:/poem.txt";
        String path2 = "D:/poem1.txt";
        inputReader(path1);
        outputWriter(path1, path2);
    }

    /**
     * 输入文件到内存
     *
     * @param path
     */
    public static void inputReader(String path) throws IOException {
        File f = new File(path);
        FileReader fr = new FileReader(f);//中文乱码
        char[] ch = new char[1024];// stream用byte[], reader/writer用char[], 流(二进制)用字节承载, 文件用字符承载
        while (fr.read(ch) != -1) {
            System.out.println("从文件之中读取字符, 使用char[]承接...");
            String str = new String(ch);
            System.out.println(str);
        }
        fr.close();
    }

    /**
     * 读取一个文件, 然后写入到另一个文件
     */
    public static void outputWriter(String path1, String path2) throws IOException {
        FileReader fr = new FileReader(path1);
        FileWriter fw = new FileWriter(path2);
        char[] ch = new char[1024];// stream用byte[], reader/writer用char[], 流(二进制)用字节承载, 文件用字符承载
        while (fr.read(ch) != -1) {
            System.out.println("从文件之中读取字符, 使用char[]承接, 然后写入到另一个文件之中...");
            fw.write(ch);
            fw.write("123456789");//还是有字符格式乱码的问题
        }
        fr.close();
        fw.close();
    }
}
```

5.BufferedReder和BufferedWriter
```java
public class UseBufferReaderWriter {
    public static void main(String[] args) throws IOException {
        String path1 = "D:/poem.txt";
        String path2 = "D:/poem2.txt";
        //inputFromConsole();
        inputBuffer(path1);
        input2OutputBuffer(path1, path2);
    }

    /**
     * 从console输入
     *
     * @throws IOException
     */
    public static void inputFromConsole() throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("请输入内容...");
        char[] ch = new char[1024];
        while (br.read(ch) != -1) {
            String sss = new String(ch);
            if (sss.equals("quit")) {//控制输入输出条件, 不起作用
                return;
            }
            System.out.println(sss);
        }
        br.close();
    }

    /**
     * 从文件读取, 然后输出到console
     *
     * @param path
     * @throws IOException
     */
    public static void inputBuffer(String path) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path));//从此处读取
        char[] ch = new char[1024];
        while (br.read(ch) != -1) {
            String s = new String(ch);
            System.out.println(s);
        }
        br.close();
    }

    /**
     * 从文件读取, 然后输出到另一个文件
     *
     * @param path1
     * @param path2
     * @throws IOException
     */
    public static void input2OutputBuffer(String path1, String path2) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(path1));//从此处读取
        BufferedWriter bw = new BufferedWriter(new FileWriter(path2));//写入此文件
        char[] ch = new char[1024];
        while (br.read(ch) != -1) {
            bw.write(ch);
            bw.write("你好...再见...");
        }
        br.close();
        bw.close();
    }
}
```

![javafiles](../../../images/javafiles.png)

![IO流](../../../images/IO流.gif)

ref:
1.[Java IO基础总结](https://www.cnblogs.com/dreamyu/p/6551137.html),   2.[JAVA IO](https://www.cnblogs.com/kakaisgood/p/6553581.html),   3.[Java之IO类的体系结构](http://353588249-qq-com.iteye.com/blog/780343),   4.[Java学习IO篇](https://www.cnblogs.com/hxsyl/p/3302852.html),   5.[Java学习IO篇](https://www.cnblogs.com/hxsyl/p/3302852.html),   6.[Java IO File (一)](https://www.cnblogs.com/zhanfuxing/p/3648306.html),   7.[Java IO（二）](https://www.cnblogs.com/zhanfuxing/p/3649248.html),   8.[Java IO (三)](https://www.cnblogs.com/zhanfuxing/p/3662304.html),   9.[java中的IO操作总结（一）](https://www.cnblogs.com/nerxious/archive/2012/12/15/2818848.html),   10.[java中的IO操作总结（二）](https://www.cnblogs.com/nerxious/archive/2012/12/16/2820310.html),   11.[java中的IO操作总结（三）](https://www.cnblogs.com/nerxious/archive/2012/12/17/2821545.html),   12.[java中的IO操作总结（四）](https://www.cnblogs.com/nerxious/archive/2012/12/17/2822365.html),   13.[java中的IO整理](https://www.cnblogs.com/rollenholt/archive/2011/09/11/2173787.html),   14.[Java 持久化之 -- IO 全面整理（看了绝不后悔）](https://www.cnblogs.com/lsy131479/p/9266481.html),   15.[java IO](https://www.cnblogs.com/baixl/p/4170599.html)