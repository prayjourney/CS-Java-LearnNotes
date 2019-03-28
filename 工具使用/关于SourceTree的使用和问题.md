### 关于SourceTree的使用和问题

***
#### sourceTree 添加 ssh key 方法

##### 1.使用 git 客户的生成公私钥：id_rsa、id_rsa.pub

1.1 设置Git的user name和email：

```
$ git config --global user.name "xxx"
$ git config --global user.email "xxx.mail@xxx.com"
```

1.2.生成SSH密钥过程：

  - 1.2.1.检查是不是已经存在密钥（能进去说明已经存在，就删掉文件夹，重新创建）：
    - cd ~/.ssh

1.3.生成 SSH 密钥：
  - $ ssh-keygen -t rsa -C “xxx.mail@xxx.com”
  - 按3个回车，密码为空。

- 1.4.文件存放位置 ~/.ssh，如果是window的话就在：C:\Users\Administrator.ssh 下面，当然如果你不是 Administrator 用户的话，需要换成对应的用户。



##### 2.设置 SourceTree 的 SSH客户端

1.配置SourceTree 的 SSH 客户的为：OpenSSH

  - 1.1.工具->选项 

![这里写图片描述](../images/stree1.png)
  - 1.2.设置 OpenSSH,这时候，SSH 密钥这一栏自然会去选择当前用户下的 .ssh 目录下的 id_rsa 这个私钥： 

![这里写图片描述](../images/stree2.png)



##### 3.添加 ~/.ssh/id_rsa.pub 文件内容到 git 服务器里面去

- 3.1.比如你的 git 服务是 github，那么你需要在 <https://github.com/settings/keys> 里面添加 SSH key 

![这里写图片描述](../images/stree3.png)

![这里写图片描述](../images/stree4.png)

- 3.2.SourceTree 来下载 git 项目
  - 3.2.1.复制你的 git 地址：git@github.com:ztd770960436/justgame.git
  - 3.2.2.从 SourceTree 里面新建一个地址，这时候你发现你本地已经可以下载远程的 git 代码了 

![这里写图片描述](../images/stree5.png)

##### 4.解释：
- 1.ssh-keygen 是公钥私钥的非对称加密方式：
  - 1.1.公钥：用于向外发布，任何人都能获取。
  - 1.2.私钥：要自己保存，切勿给别人

- 2.公钥私钥加解密的原理
  - 2.1.客户端把自己的公钥存放到要链接的远程主机上（相当于我们把自己的 id_rsa.pub 存放到 git 服务器上）
  - 2.2.客户端要链接远程主机的时候，远程主机会向客户的发送一条随机的字符串，客户的收到字符串之后使用自己的私钥对字符串加密然后发送到远程主机，远程主机根据自己存放的公钥对这个字符串进行解密，如果解密成功证明客户端是可信的，直接允许登录，不在要求登录。



#### SourceTree推送时一直提示输入密码

SourceTree 推送代码到 GitHub 时一直提示输入密码，并且不管输入多少次密码还是不行，始终提示要求输入密码。解决办法如下

打开该仓库，选择右上角的 Settings 设置按钮：

![stree6](../images/stree6.png)

选中远程仓库路径，点击 Edit 编辑按钮：

![stree7](../images/stree7.png)

首先选择 Host Type，确保选中的是 GitHub：

![stree8](../images/stree8.png)

如果你本来选择的就是 GitHub，或者选择完以后还是不行的话，在 URL / path: 中的 github.com 前面添加你的 GitHub 名字和@：

![stree9](../images/stree9.png)

需要说明的是,现在其实不太推荐使用https的方式, 而推荐使用git专用的协议,一般如下

![stree9](../images/stree10.png)

现在应该可以解决问题了,马上用source tree push一下


ref:
1.[sourceTree 添加 ssh key 方法](https://blog.csdn.net/tengdazhang770960436/article/details/54171911),   2.[SourceTree推送时一直提示输入密码](https://blog.csdn.net/qq_18425655/article/details/51281088)