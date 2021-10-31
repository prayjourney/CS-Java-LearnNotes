## SpringBoot大文件上传(大小文件上传皆可)

### 主要思路
在之前，我们给大家介绍了普通文件上传下载的思路，普通的文件其实在Spring体系之中，没有太大的难度，使用Post请求，然后请求设置成为`form-data`的格式，前端的处理就完成了，对于后端而言，一个文件，我们使用一个`MultipartFile`接口接收就行。这个是普通文件上传的思路，对于大文件，它和普通文件的主要区别，就是文件的体积大，体积一大，如果一次性加载，可能会导致占满内存，或者是导致浏览器崩溃，所以就要想办法把一个大文件分开，一部分一部分的传，最后合并成一个完整的文件，而且这个文件还必须与上传之前的文件的内容是一致的。这个就是大文件上传的思路。

上面的大文件上传的思路用简单的话描述了一下，基本上涵盖了所有的重点，但是不是非常直观，简单说，把大文件分开——分片，最后合并就是要的结果，合并之后与原先的文件内容一致，就是需要检测，检测的方法就是对文件提取摘要，一般使用的就是MD5编码。所以整个大文件上传的重点，其实就是文件的分片。这个分片，其实也不用太过忧愁，所有的文件底层都是01代码，既然如此，就可以一块一块切分或者是组装，切分就是分片，组装就是合并。在Java里面，给我们提供了`RandomAccessFile`，我们借助这个类，就可以实现文件的随机存储和读取。


### 开发步骤
1. 前端文件分片
2. 分片上传后端接收
3. 并且存取每一个分片的信息
4. 当是最后一个分片时合并文件，进行摘要检查
5. 返回上传结果


### 构造上传对象
```java
public class MultipartFileParam {
    /**
     * 是否分片
     */
    @NotNull(message = "是否分片不能为空")
    private boolean chunkFlag;

    /**
     * 当前为第几块分片
     */
    private int chunk;

    /**
     * 总分片数量
     */
    private int totalChunk;

    /**
     * 文件总大小, 单位是byte
     */
    private long totalSize;

    /**
     * 文件名
     */
    @NotBlank(message = "文件名不能为空")
    private String name;

    /**
     * 文件
     */
    @NotNull(message = "文件不能为空")
    private MultipartFile file;

    /**
     * md5值
     */
    @NotBlank(message = "文件md5值不能为空")
    private String md5;
```

上面是对应的POJO的类，可以作为一个POJO类对待，也可以当作是一个请求参数对待，其中的`private MultipartFile file`就是用来装载文件的，totalSize是文件的总大小，chunk是当前分片的id。


### 上传分片记录
上传分片记录是用来记录当前上传分片的文件的信息的，我们也要对其记录，其中的md5，就是一个完整的文件对应的，这个需要前端在上传之前，和参数一起，给我们传过来，这个需要保证其正确性，id是这个分片在整个记录之中的排序，chunk就是当前分片的分片的顺序，这个也是上传时的参数决定的，uploadStatus就是记录这个分片是否上传成功的标志，可以按照自己的实际情况进行设置。其中两个重要的参数，就是md5和chunk，我们使用md5建立了和上传文件的唯一联系，使用chunk记录了这个分片和这个文件的位置的关系，也就是我这个分片存在于这个文件之中的到底什么位置location。

```java
public class FileChunkRecord implements Serializable {
    
    private static final long serialVersionUID = 1L;
    private Long id;
    private String md5;
    private Integer chunk;
    /**
     * 0-fail, 1-okay
     */
    private Integer uploadStatus;

}

public class FileRecord implements Serializable {

    private static final long serialVersionUID = 1L;
    private Long id;
    private String fileName;
    private String fileMd5;
    private String filePath;
    private String fileSize;
    /**
     * 0-fail, 1-okay
     */
    private Integer uploadStatus;
    private Date createTime;
    private Date updateTime;

}
```


### 功能实现
#### 项目配置
```yaml
server.port=10015
# 开启上传和下载
spring.servlet.multipart.enabled=true
#文件上传大小限制50M
spring.servlet.multipart.max-file-size=50MB
spring.servlet.multipart.max-request-size=-1
server.tomcat.max-swallow-size=-1

# db
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.url=jdbc:mysql://localhost:3306/bigfile?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.platform=mysql

# druid
spring.datasource.type=com.alibaba.druid.pool.DruidDataSource
spring.datasource.druid.initial-size=5
spring.datasource.druid.min-idle=5
spring.datasource.druid.max-active=20
## 单位是毫秒，此处设置为2分钟
spring.datasource.druid.max-wait=120000
spring.datasource.druid.time-between-eviction-runs-millis=60000
spring.datasource.druid.min-evictable-idle-time-millis=300000
spring.datasource.druid.validationQuery=SELECT 1 FROM DUAL
spring.datasource.druid.testWhileIdle=true
spring.datasource.druid.test-on-borrow=false
spring.datasource.druid.test-on-return=false
spring.datasource.druid.pool-prepared-statements=true
## 配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙
spring.datasource.druid.filters=stat,wall
spring.datasource.druid.maxPoolPreparedStatementPerConnectionSize=20
spring.datasource.druid.seGlobalDataSourceStat=true
spring.datasource.druid.connectionProperties=druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500

# mybatis-plus
mybatis-plus.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
# 配置逻辑删除, 配置删除为1，没有删除为0
mybatis-plus.global-config.db-config.logic-delete-value=1
mybatis-plus.global-config.db-config.logic-not-delete-value=0
mybatis-plus.configuration.map-underscore-to-camel-case=true
#mybatis-plus.mapper-locations=classpath*:/mapper/**/*.xml
mybatis-plus.mapper-locations=classpath:com/zgy/learn/bigfileupzipdown/mapper/*.xml
mybatis-plus.type-aliases-package=com.zgy.learn.bigfileupzipdown.pojo
mybatis-plus.global-config.db.type=MYSQL

# 文件存储路径
file.upload.dir=d:/test
# 文件存储临时路径
file.download.tmp.dir=d:/test/tmp
# 1M=1024*1024B
file.upload.chunkSize=10485760
```


#### 对应的Controller
```java
@RestController
@RequestMapping("file")
public class FileUploadController {
    @Resource
    private FileUploadService fileUploadService;

    /**
     * 文件上传
     *
     * @param fileParam
     * @return
     */
    @PostMapping(value = "upload")
    public String upload(MultipartFileParam fileParam) throws IOException {
        return fileUploadService.fileUpload(fileParam);
    }

}
```

#### 对应的Service
```java
@Service
@Slf4j
public class FileUploadService {
    @Value("${file.upload.dir}")
    private String FILE_UPLOAD_DIR;
    @Value("${file.upload.chunkSize}")
    private Integer CHUNK_SIZE;

    @Resource
    private FileChunkRecordMapper fileChunkRecordMapper;
    @Resource
    private FileRecordMapper fileRecordMapper;

    public String fileUpload(MultipartFileParam fileParam) throws IOException {
        boolean chunkFlag = fileParam.isChunkFlag();
        if (!chunkFlag) {
            return singleUpload(fileParam);
        }
        return chunkUpload(fileParam);
    }

    private String singleUpload(MultipartFileParam fileParam) {
        MultipartFile file = fileParam.getFile();
        File baseFile = new File(FILE_UPLOAD_DIR);
        if (!baseFile.exists()) {
            baseFile.mkdirs();
        }
        try {
            file.transferTo(new File(baseFile, fileParam.getName()));
            Date now = new Date();
            FileRecord fileRecord = new FileRecord();
            String filePath = FILE_UPLOAD_DIR + File.separator + fileParam.getName();
            long size = FileUtil.size(new File(filePath));
            String sizeStr = size / (1024 * 1024) + "Mb";
            fileRecord.setFileName(fileParam.getName()).setFilePath(filePath).setUploadStatus(1)
                    .setFileMd5(fileParam.getMd5()).setCreateTime(now).setUpdateTime(now).setFileSize(sizeStr);
            fileRecordMapper.insert(fileRecord);
        } catch (IOException e) {
            log.error("单独上传文件错误, 问题是:{}, 时间是:{}", e.getMessage(), DateUtil.now());
        }

        return "success";
    }

    private String chunkUpload(MultipartFileParam fileParam) throws IOException {
        // 是否为最后一片
        boolean lastFlag = false;

        int currentChunk = fileParam.getChunk();
        int totalChunk = fileParam.getTotalChunk();
        long totalSize = fileParam.getTotalSize();
        String fileName = fileParam.getName();
        String fileMd5 = fileParam.getMd5();
        MultipartFile multipartFile = fileParam.getFile();

        String parentDir = FILE_UPLOAD_DIR + File.separator + fileMd5 + File.separator;
        String tempFileName = fileName + "_tmp";

        // 写入到临时文件
        File tmpFile = tmpFile(parentDir, tempFileName, multipartFile, currentChunk, totalSize, fileMd5);
        // 检测是否为最后一个分片
        QueryWrapper<FileChunkRecord> wrapper = new QueryWrapper<>();
        wrapper.eq("md5", fileMd5);
        Integer count = fileChunkRecordMapper.selectCount(wrapper);
        if (count == totalChunk) {
            lastFlag = true;
        }

        if (lastFlag) {
            // 检查md5是否一致
            if (!checkFileMd5(tmpFile, fileMd5)) {
                cleanUp(tmpFile, fileMd5);
                throw new RuntimeException("文件md5检测不符合要求, 请检查!");
            }
            // 文件重命名, 成功则新增文件的记录
            if (!renameFile(tmpFile, fileName)) {
                throw new RuntimeException("文件重命名失败, 请检查!");
            }
            recordFile(fileName, fileMd5, parentDir);
            log.info("文件上传完成, 时间是:{}, 文件名称是:{}", DateUtil.now(), fileName);
        }

        return "success";
    }

    public String check(String md5) {
        QueryWrapper queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("file_md5", md5);
        FileRecord record = fileRecordMapper.selectOne(queryWrapper);
        if (Objects.nonNull(record)) {
            return "文件已经上传过";
        }
        List<FileChunkRecord> records = fileChunkRecordMapper.queryByMd5(md5);
        StringBuilder result = new StringBuilder();
        records.stream().forEach(x -> result.append(x.getChunk()));
        return result.toString();

    }

    private File tmpFile(String parentDir, String tempFileName, MultipartFile file,
                         int currentChunk, long totalSize, String fileMd5) throws IOException {
        log.info("开始上传文件, 时间是:{}, 文件名称是:{}", DateUtil.now(), tempFileName);
        long position = (currentChunk - 1) * CHUNK_SIZE;
        File tmpDir = new File(parentDir);
        File tmpFile = new File(parentDir, tempFileName);
        if (!tmpDir.exists()) {
            tmpDir.mkdirs();
        }

        RandomAccessFile tempRaf = new RandomAccessFile(tmpFile, "rw");
        if (tempRaf.length() == 0) {
            tempRaf.setLength(totalSize);
        }

        // 写入该分片数据
        FileChannel fc = tempRaf.getChannel();
        MappedByteBuffer map = fc.map(FileChannel.MapMode.READ_WRITE, position, file.getSize());
        map.put(file.getBytes());
        clean(map);
        fc.close();
        tempRaf.close();

        // 记录已经完成的分片
        FileChunkRecord fileChunkRecord = new FileChunkRecord();
        fileChunkRecord.setMd5(fileMd5).setUploadStatus(1).setChunk(currentChunk);
        fileChunkRecordMapper.insert(fileChunkRecord);
        log.info("文件上传完成, 时间是:{}, 文件名称是:{}", DateUtil.now(), tempFileName);
        return tmpFile;
    }

    private static void clean(MappedByteBuffer map) {
        try {
            Method getCleanerMethod = map.getClass().getMethod("cleaner");
            Cleaner.create(map, null);
            getCleanerMethod.setAccessible(true);
            Cleaner cleaner = (Cleaner) getCleanerMethod.invoke(map);
            cleaner.clean();
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    private boolean checkFileMd5(File file, String fileMd5) throws IOException {
        FileInputStream fis = new FileInputStream(file);
        String checkMd5 = DigestUtils.md5DigestAsHex(fis).toUpperCase();
        fis.close();
        if (checkMd5.equals(fileMd5.toUpperCase())) {
            return true;
        }
        return false;
    }

    private void cleanUp(File file, String md5) {
        if (file.exists()) {
            file.delete();
        }
        // 删除上传记录
        QueryWrapper queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("md5", md5);
        fileChunkRecordMapper.delete(queryWrapper);
    }

    private boolean renameFile(File toBeRenamed, String toFileNewName) {
        // 检查要重命名的文件是否存在，是否是文件
        if (!toBeRenamed.exists() || toBeRenamed.isDirectory()) {
            log.info("File does not exist: " + toBeRenamed.getName());
            return false;
        }
        String parentPath = toBeRenamed.getParent();
        File newFile = new File(parentPath + File.separatorChar + toFileNewName);
        // 如果存在, 先删除
        if (newFile.exists()) {
            newFile.delete();
        }
        return toBeRenamed.renameTo(newFile);
    }

    public void recordFile(String fileName, String fileMd5, String parentDir) {
        Date now = new Date();
        String filePath = parentDir + fileName;
        long size = FileUtil.size(new File(filePath));
        String sizeStr = size / (1024 * 1024) + "Mb";
        // 更新文件记录
        FileRecord record = new FileRecord();
        record.setFileName(fileName).setFileMd5(fileMd5).setFileSize(sizeStr).setFilePath(filePath)
                .setUploadStatus(1).setCreateTime(now).setUpdateTime(now);
        fileRecordMapper.insert(record);
        // 删除分片文件的记录
        fileChunkRecordMapper.deleteByMd5(fileMd5);
    }

}
```

#### Mapper接口与Mapper.xml
```java
@Repository
public interface FileChunkRecordMapper extends BaseMapper<FileChunkRecord> {

    List<FileChunkRecord> queryByMd5(@Param("md5") String md5);

    @Delete("delete from file_chunk_record where md5 = #{md5}")
    int deleteByMd5(@Param("md5") String md5);

}

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zgy.learn.bigfileupzipdown.mapper.FileChunkRecordMapper">

    <select id="queryByMd5" resultType="com.zgy.learn.bigfileupzipdown.pojo.FileChunkRecord">
        SELECT
            id,
            md5,
            chunk,
            upload_status
        FROM
            file_chunk_record
        WHERE
            md5 = #{md5};
    </select>
</mapper>
        
@Repository
public interface FileRecordMapper extends BaseMapper<FileRecord> {
}

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.zgy.learn.bigfileupzipdown.mapper.FileRecordMapper">

</mapper>
```

完成了上述的功能，我们大文件上传的功能就完成了。


### 秒传检测与断点续传
上述的代码，完成了大文件上传，逻辑就是上传大文件，我就分片，然后分片我就记录每一个分片，收集齐所有分片，我就合并，然后记录，者其实就是上面两个类，`FileChunkRecord`和`FileRecord`的作用，前者记录分片的信息，后者记录文件的信息，当所有的分片记录完成之后，相当于整个上传完成，我再去记录文件的存储信息。

那么就有一个问题，如果某一个文件，我上传过，但是忘记了是否上传，或者说我是一个网盘项目，有很多人存储相同的电影，那么，我就可以使用秒传检测，去检测这个文件是否已经存在，如果存在我就不用去再次上传了，这样既节省宽带，也可以节省存储空间（这个需要设置一些映射，以及文件的存在的检测，考虑是否删除，文件的移动等情况）。按照上面的代码，其实我们已经具备了这个能力，流程就是我上传一个文件，先去用Md5查询，查询FileRecord表，如果有这个对应的文件，返回已经存在或者上传成功，这个具体的显示情况由前端决定，如果没有查询到，就去FileChunkRecord里面按照Md5查询，如果有部分的分片，我们返回已有的分片的序号，让前端在上传的时候，只传送没有上传的分片，这样就可以实现断点续传的功能了。如果没有那就表明这个文件确实是没有上传的，那么我们完全重新上传即可。

```java
    /**
     * 秒传检测
     *
     * @param md5
     * @return
     */
    @GetMapping(value = "check")
    public String check(String md5) {
        return fileUploadService.check(md5);
    }
```

==需要特别注意，就是我们的分片的大小，前后端必须保持一致==。

