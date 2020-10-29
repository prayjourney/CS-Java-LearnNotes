# Springboot生成二维码整合
我们使用两种方式，去生成二维码，但是其实，二维码的生成基础，都是zxing包，这是Google开源的一个包，第一种是使用原始的zxing方式去实现，第二种是使用hutool来实现，hutool其实也是对于zxing的一个封装，但是封装前后，确实比较简单了。

## **Zxing原生方式**
###  **添加依赖**
```xml
<!-- zxing生成二维码 -->
<dependency>
    <groupId>com.google.zxing</groupId>
    <artifactId>core</artifactId>
    <version>3.3.3</version>
</dependency>

<dependency>
    <groupId>com.google.zxing</groupId>
    <artifactId>javase</artifactId>
    <version>3.3.3</version>
</dependency>
```



### **二维码生成工具类**
下面是把生成二维码的方法，封装到了QRCodeUtil的类之中，这个方法看起来还是比较多的，但是也谈不上太复杂，主要是对于BufferedImage生成图片，然后就是ImageIO.write()方法，write的位置，可以是普通的磁盘文件，也可以是web的流，我们使用web流的时候，就需要添加`com.google.zxing-javase`的依赖。
```java
@Component
@Slf4j
public class QRCodeUtil {
    /**
     * CODE_WIDTH：二维码宽度，单位像素
     * CODE_HEIGHT：二维码高度，单位像素
     * FRONT_COLOR：二维码前景色，0x000000 表示黑色
     * BACKGROUND_COLOR：二维码背景色，0xFFFFFF 表示白色
     * 演示用 16 进制表示，和前端页面 CSS 的取色是一样的，注意前后景颜色应该对比明显，如常见的黑白
     */
    private static final int CODE_WIDTH = 400;
    private static final int CODE_HEIGHT = 400;
    private static final int FRONT_COLOR = 0x000000;
    private static final int BACKGROUND_COLOR = 0xFFFFFF;


    /**
     * @param codeContent        二维码参数内容，如果是一个网页地址，如 https://www.baidu.com/ 则 微信扫一扫会直接进入此地址， 如果是一些参数，如
     *                           1541656080837，则微信扫一扫会直接回显这些参数值
     * @param codeImgFileSaveDir 二维码图片保存的目录,如 D:/codes
     * @param fileName           二维码图片文件名称，带格式,如 123.png
     */
    public static void createCodeToFile(String codeContent, File codeImgFileSaveDir, String fileName) {
        try {
            if (codeContent == null || "".equals(codeContent)) {
                log.info("二维码内容为空，不进行操作...");
                return;
            }
            codeContent = codeContent.trim();
            if (codeImgFileSaveDir == null || codeImgFileSaveDir.isFile()) {
                codeImgFileSaveDir = FileSystemView.getFileSystemView().getHomeDirectory();
                log.info("二维码图片存在目录为空，默认放在桌面...");
            }
            if (!codeImgFileSaveDir.exists()) {
                codeImgFileSaveDir.mkdirs();
                log.info("二维码图片存在目录不存在，开始创建...");
            }
            if (fileName == null || "".equals(fileName)) {
                fileName = new Date().getTime() + ".png";
                log.info("二维码图片文件名为空，随机生成 png 格式图片...");
            }

            BufferedImage bufferedImage = getBufferedImage(codeContent);

            /*
             * javax.imageio.ImageIO：java扩展的图像IO
             * write(RenderedImage im, String formatName, File output)
             *       im：待写入的图像， formatName：图像写入的格式，output：写入的图像文件，文件不存在时会自动创建
             */
            File codeImgFile = new File(codeImgFileSaveDir, fileName);
            ImageIO.write(bufferedImage, "png", codeImgFile);

            log.info("二维码图片生成成功：" + codeImgFile.getPath());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 生成二维码并输出到输出流, 通常用于输出到网页上进行显示
     * 输出到网页与输出到磁盘上的文件中，区别在于最后一句 ImageIO.write
     * write(RenderedImage im,String formatName,File output)：写到文件中
     * write(RenderedImage im,String formatName,OutputStream output)：输出到输出流中
     *
     * @param codeContent  ：二维码内容
     * @param outputStream ：输出流，比如 HttpServletResponse 的 getOutputStream
     */
    public static void createCodeToOutputStream(String codeContent, OutputStream outputStream) {
        try {
            if (codeContent == null || "".equals(codeContent.trim())) {
                log.info("二维码内容为空，不进行操作...");
                return;
            }
            codeContent = codeContent.trim();

            BufferedImage bufferedImage = getBufferedImage(codeContent);
            /*
             * 区别就是以一句，输出到输出流中，如果第三个参数是 File，则输出到文件中
             */
            ImageIO.write(bufferedImage, "png", outputStream);
            log.info("二维码图片生成到输出流成功...");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("发生错误: {}!", e.getMessage());
        }
    }


    private static BufferedImage getBufferedImage(String codeContent) throws WriterException {
        /*
         * com.google.zxing.EncodeHintType：编码提示类型,枚举类型
         * EncodeHintType.CHARACTER_SET：设置字符编码类型
         * EncodeHintType.ERROR_CORRECTION：设置误差校正
         * ErrorCorrectionLevel：误差校正等级，L = ~7% correction、M = ~15% correction、Q = ~25% correction、H = ~30% correction
         *   不设置时，默认为 L 等级，等级不一样，生成的图案不同，但扫描的结果是一样的
         * EncodeHintType.MARGIN：设置二维码边距，单位像素，值越小，二维码距离四周越近
         */
        Map<EncodeHintType, Object> hints = new HashMap();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.MARGIN, 1);

        /*
         * MultiFormatWriter:多格式写入，这是一个工厂类，里面重载了两个 encode 方法，用于写入条形码或二维码
         *      encode(String contents,BarcodeFormat format,int width, int height,Map<EncodeHintType,?> hints)
         *      contents:条形码/二维码内容
         *      format：编码类型，如 条形码，二维码 等
         *      width：码的宽度
         *      height：码的高度
         *      hints：码内容的编码类型
         * BarcodeFormat：枚举该程序包已知的条形码格式，即创建何种码，如 1 维的条形码，2 维的二维码 等
         * BitMatrix：位(比特)矩阵或叫2D矩阵，也就是需要的二维码
         */
        MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
        BitMatrix bitMatrix = multiFormatWriter.encode(codeContent, BarcodeFormat.QR_CODE, CODE_WIDTH, CODE_HEIGHT, hints);

        /*
         * java.awt.image.BufferedImage：具有图像数据的可访问缓冲图像，实现了 RenderedImage 接口
         * BitMatrix 的 get(int x, int y) 获取比特矩阵内容，指定位置有值，则返回true，将其设置为前景色，否则设置为背景色
         * BufferedImage 的 setRGB(int x, int y, int rgb) 方法设置图像像素
         *      x：像素位置的横坐标，即列
         *      y：像素位置的纵坐标，即行
         *      rgb：像素的值，采用 16 进制,如 0xFFFFFF 白色
         */
        BufferedImage bufferedImage = new BufferedImage(CODE_WIDTH, CODE_HEIGHT, BufferedImage.TYPE_INT_BGR);
        for (int x = 0; x < CODE_WIDTH; x++) {
            for (int y = 0; y < CODE_HEIGHT; y++) {
                bufferedImage.setRGB(x, y, bitMatrix.get(x, y) ? FRONT_COLOR : BACKGROUND_COLOR);
            }
        }
        return bufferedImage;
    }


    /**
     * 根据本地二维码图片解析二维码内容 注：图片必须是二维码图片，但也可以是微信用户二维码名片，上面有名称、头像也是可以的）
     *
     * @param file 本地二维码图片文件,如 E:\\logs\\2.jpg
     * @return
     * @throws Exception
     */
    public static String parseQRCodeByFile(File file) {
        String resultStr = null;
        if (file == null || file.isDirectory() || !file.exists()) {
            return resultStr;
        }
        try {
            /*
             * ImageIO的BufferedImage read(URL input)方法用于读取网络图片文件转为内存缓冲图像
             * 同理还有：read(File input)、read(InputStream input)、、read(ImageInputStream stream)
             */
            BufferedImage bufferedImage = ImageIO.read(file);
            /*
             * com.google.zxing.client.j2se.BufferedImageLuminanceSource：缓冲图像亮度源
             * 将 java.awt.image.BufferedImage 转为 zxing 的 缓冲图像亮度源
             * 关键就是下面这几句：HybridBinarizer 用于读取二维码图像数据，BinaryBitmap 二进制位图
             */
            BufferedImageLuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
            Hashtable hints = new Hashtable();
            hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
            /*
             * 如果图片不是二维码图片，则 decode 抛异常：com.google.zxing.NotFoundException
             * MultiFormatWriter 的 encode 用于对内容进行编码成 2D 矩阵
             * MultiFormatReader 的 decode 用于读取二进制位图数据
             */
            Result result = new MultiFormatReader().decode(bitmap, hints);
            resultStr = result.getText();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NotFoundException e) {
            e.printStackTrace();
            log.error("图片非二维码图片, 路径是: {}!", file.getPath());
        }
        return resultStr;
    }


    /**
     * 根据网络二维码图片解析二维码内容, 区别仅仅在于 ImageIO.read(url); 这一个重载的方法）
     *
     * @param url 二维码图片网络地址，如 https://res.wx.qq.com/mpres/htmledition/images/mp_qrcode3a7b38.gif
     * @return
     * @throws Exception
     */
    public static String parseQRCodeByUrl(URL url) {
        String resultStr = null;
        if (url == null) {
            return resultStr;
        }
        try {
            /*
             * ImageIO 的 BufferedImage read(URL input) 方法用于读取网络图片文件转为内存缓冲图像
             * 同理还有：read(File input)、read(InputStream input)、、read(ImageInputStream stream)
             * 如果图片网络地址错误，比如不能访问，则 read 抛异常：javax.imageio.IIOException: Can't get input stream from URL!
             */
            BufferedImage bufferedImage = ImageIO.read(url);
            /*
             * com.google.zxing.client.j2se.BufferedImageLuminanceSource：缓冲图像亮度源
             * 将 java.awt.image.BufferedImage 转为 zxing 的 缓冲图像亮度源
             * 关键就是下面这几句：HybridBinarizer 用于读取二维码图像数据，BinaryBitmap 二进制位图
             */
            BufferedImageLuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
            Hashtable hints = new Hashtable();
            /*
             * 如果内容包含中文，则解码的字符集格式应该和编码时一致
             */
            hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
            /*
             * 如果图片不是二维码图片，则 decode 抛异常：com.google.zxing.NotFoundException
             * MultiFormatWriter 的 encode 用于对内容进行编码成 2D 矩阵
             * MultiFormatReader 的 decode 用于读取二进制位图数据
             */
            Result result = new MultiFormatReader().decode(bitmap, hints);
            resultStr = result.getText();
        } catch (IOException e) {
            e.printStackTrace();
            log.error("二维码图片地址错误, 地址是: {}!", url);
        } catch (NotFoundException e) {
            e.printStackTrace();
            log.error("图片非二维码图片, 地址是: {}!", url);
        }
        return resultStr;
    }
```



### **添加Controller**
```java
public class QRCodeController {

    @GetMapping("qrCode")
    public void getQRCode(String codeContent, HttpServletResponse response) {
        System.out.println("codeContent=" + codeContent);
        try {
            /*
             * 调用工具类生成二维码并输出到输出流中
             */
            QRCodeUtil.createCodeToOutputStream(codeContent, response.getOutputStream());
            log.info("成功生成二维码!");
        } catch (IOException e) {
            log.error("发生错误， 错误信息是：{}！", e.getMessage());
        }
    }

}
```



### **添加测试页面**
```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>二维码生成器</title>
        <style type="text/css">
            textarea {
                font-size: 16px;
                width: 300px;
                height: 100px;
            }

            .hint {
                color: red;
                display: none;
            }

            .qrCodeDiv {
                width: 200px;
                height: 200px;
                border: 2px solid sandybrown;
            }

            .qrCodeDiv img {
                max-height: 100%;
                max-width: 100%;
            }
        </style>
        <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

        <script type="text/javascript">
            $(function () {
                $("button").click(function () {
                    var codeContent = $("textarea").val();
                    console.log(codeContent);
                    if (codeContent.trim() == "") {
                        $(".hint").text("二维码内容不能为空").fadeIn(500);
                    } else {
                        $(".hint").text("").fadeOut(500);
                        $("#codeImg").attr("src", "/qrCode?codeContent=" + codeContent);
                    }
                });
            });
        </script>
    </head>
    <body>
        <textarea placeholder="二维码内容..."></textarea><br>
        <button>生成二维码</button>
        <span class="hint"></span>
        <div class="qrCodeDiv">
            <img src="" id="codeImg">
        </div>
    </body>
</html>
```



## **Hutool的方式**
Hutool的是非强制依赖性，因此zxing需要用户自行引入，我们需要加入依赖。使用hutool的时候，`com.google.zxing-javase`的依赖可以不需要。
### **添加依赖**
```xml
<dependency>
    <groupId>cn.hutool</groupId>
    <artifactId>hutool-all</artifactId>
    <version>5.3.10</version>
</dependency>
<dependency>
    <groupId>com.google.zxing</groupId>
    <artifactId>core</artifactId>
    <version>3.3.3</version>
</dependency>
```



### **创建QRCodeService**
`QRCodeService`其实就是对`QrCodeUtil`的功能的封装，`QrCodeUtil`此处的类是hutool工具提供的，和我们在上面与自己与自己提供的`QRCodeUtil`类，不是同一个，这个需要注意一下。`QrCodeUtil`的功能此处主要使用到了的是生成二维码，到文件或者流之中，`QrConfig`是Hutool工具QrCodeUtil的配置类。
```java
@Service
@Slf4j
public class QRCodeService {
    // 自定义参数，这部分是Hutool工具封装的
    private static QrConfig initQrConfig() {
        QrConfig config = new QrConfig(300, 300);
        // 设置边距，既二维码和背景之间的边距
        config.setMargin(3);
        // 设置前景色，既二维码颜色（青色）
        config.setForeColor(Color.CYAN.getRGB());
        // 设置背景色（灰色）
        config.setBackColor(Color.GRAY.getRGB());
        return config;
    }

    /**
     * 生成到文件
     *
     * @param content
     * @param filepath
     */
    public void createQRCode2File(String content, String filepath) {
        try {
            QrCodeUtil.generate(content, initQrConfig(), FileUtil.file(filepath));
            log.info("生成二维码成功, 位置在：{}！", filepath);
        } catch (QrCodeException e) {
            log.error("发生错误！ {}！", e.getMessage());
        }
    }

    /**
     * 生成到流
     *
     * @param content
     * @param response
     */
    public void createQRCode2Stream(String content, HttpServletResponse response) {
        try {
            QrCodeUtil.generate(content, initQrConfig(), "png", response.getOutputStream());
            log.info("生成二维码成功!");
        } catch (QrCodeException | IOException e) {
            log.error("发生错误！ {}！", e.getMessage());
        }
    }
}
```



### **添加Controller**
```java
@RestController
@Slf4j
public class QRCodeController {
    @Autowired
    private QRCodeService qrCodeService;

    @GetMapping("qrCode")
    public void getQRCode(String codeContent, HttpServletResponse response) {
        try {
            qrCodeService.createQRCode2Stream(codeContent, response);
            log.info("成功生成二维码！");
        } catch (Exception e) {
            log.error("发生错误， 错误信息是：{}！", e.getMessage());
        }
    }

}
```



#### **效果测试**
我们使用的页面和上述相同，所以，页面的情况是一样的，效果展示如下：
![效果测试](https://i.loli.net/2020/10/29/Z51AfwRbcaOsgTj.png)



### **总结**
综合来说，还是使用hutool的这种方式吧，更加方便简洁。源代码在本人`springboot2.x-integration`项目之中，qrcode分支是二维码生成的整合分支，欢迎[fork](https://github.com/prayjourney/springboot2.x-integration.git)和star。



#### **参考**
https://blog.csdn.net/xm526489770/article/details/83651555, https://www.cnblogs.com/haha12/p/11457716.html, https://blog.csdn.net/wangmx1993328/article/details/83856391, https://blog.csdn.net/qq_39313596/article/details/103564238, https://www.cnblogs.com/qingmuchuanqi48/p/12079417.html, https://www.bookstack.cn/read/hutool/18a69dd68fd334c8.md