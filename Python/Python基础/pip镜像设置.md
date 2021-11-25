### pip镜像设置
---

#### 推荐的镜像
默认的pip源, 在国内访问很慢, 可以将其改成国内的源, 以下是国内的镜像:
```shell
阿里云 http://mirrors.aliyun.com/pypi/simple/
中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
豆瓣(douban) http://pypi.douban.com/simple/
清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
中国科学技术大学 http://pypi.mirrors.ustc.edu.cn/simple/
```



#### 不同系统的设置
##### Mac
mac先找一下.pip文件件，如果没有则需要手动创建.
```shell
cd ~/
ls -a
发现没有这个.pip文件件，手动创建：
mkdir .pip
cd .pip/
vi pip.conf
```

推荐清华大学的镜像, 加入以下内容:
```shell
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn
```

或者阿里云的镜像:
```shell
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```

或者使用豆瓣的镜像:
```shell
[global]
index-url = http://pypi.douban.com/simple
[install]
trusted-host=pypi.douban.com
```

##### Linux
需要创建或修改配置文件(一般都是创建), linux的文件在~/.pip/pip.conf, 添加的内容和mac相同


##### Windows
windows在%HOMEPATH%\pip\pip.ini修改, 添加的内容和mac相同



---
ref:
1.[安装python模块的时候，报错](https://www.jianshu.com/p/1f00e47298f1),   2.[python中安装包出现Retrying](https://blog.csdn.net/qq_25964837/article/details/80295041)