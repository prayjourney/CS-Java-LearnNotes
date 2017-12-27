## pro git读书笔记

### 起步

##### 三种区域以及三种状态

Git 项目有*~~三个工作区域~~*的概念：**工作目录**，**暂存区域**以及**Git 仓库**

- 工作目录是我们用来**修改文件**的目录，是对项目的某个版本独立提取出来的内容
- 暂存区域是用来**记录快照**的地方，暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中，但是有必要单独提出来，因为其和仓库又有明显的区别， 也被称作`‘索引’'
- Git仓库是**存储文件**的地方，这个地方有一系列的快照，记录了文件的状态，是 Git 用来保存项目的元数据和对象数据库的地方

Git之中的文件有三种状态，文件可能处于其中之一：**已提交（committed）**、**已修改（modified）**和**已暂存（staged）**。*已提交表示数据已经安全的保存在本地数据库中*。 已修改表示修改了文件，但还没保存到数据库中。 这三种状态其实并不重要，重要的是三个工作区域的概念，已提交表示`git commit -m'xxx'`，文件保存到仓库了，已暂存表示文件已经执行了`git add file`，**已暂存表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中**，已修改表示对于本地工作目录之中的文件，进行了修改，是我们普通创作的基本操作

![工作目录、暂存区域以及 Git 仓库](https://git-scm.com/book/en/v2/images/areas.png)

##### 基本的 Git 工作流

- 在工作目录中修改文件
- 暂存文件，将文件的快照放入暂存区域
- 提交更新，找到暂存区域的文件，将快照永久性存储到 Git 仓库目录

##### 初次运行 Git 前的配置

成功安装git后，会有一个 `git config` 的文件控制 Git 外观和行为的配置变量

##### 用户信息

当安装完 Git 应该做的第一件事就是设置你的用户名称与邮件地址。 **每一次 Git 提交都会使用这些信息**，并且它会写入到每一次提交中，不可更改，需要说明的是，**如下的配置都是在bash命令行之中执行的，而不是在`git config`文件之中**

```cmake
$ git config --global user.name "prayjourney"
$ git config --global user.email johndoe@example.com
```

如果使用了 `--global` 选项，那么该命令只需要运行一次，这样是一种全局配置，如果要针对特定项目使用不同的用户名称与邮件地址时，可以在那个项目目录下运行没有 `--global` 选项的命令来配置

##### 文本编辑器

Git 会使用操作系统默认的文本编辑器，通常是 Vim。 如果你想使用不同的文本编辑器，例如 Emacs，可以使用如下配置：

```cmake
$ git config --global core.editor emacs
```

##### 检查配置信息

如果想要检查你的配置，可以使用 `git config --list` 命令来列出所有 Git 当时能找到的配置。

```cmake
$ git config --list
user.name=John Doe
user.email=johndoe@example.com
color.status=auto
color.branch=auto
color.interactive=auto
color.diff=auto
...
```

可以通过输入 `git config <key>`： 来检查 Git 的某一项配置

```cmake
$ git config user.name
prayjourney
```

##### 获取帮助

若使用 Git 时需要获取帮助，有三种方法可以找到 Git 命令的使用手册：

```cmake
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```

例如，要想获得 config 命令的手册，执行

```cmake
$ git help config
```

### Git 基础



### Git 分支



ref:

1.[1.3 起步 - Git 基础](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-Git-%E5%9F%BA%E7%A1%80),   2.[1.6 起步 - 初次运行 Git 前的配置](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%88%9D%E6%AC%A1%E8%BF%90%E8%A1%8C-Git-%E5%89%8D%E7%9A%84%E9%85%8D%E7%BD%AE#_first_time),   3.[1.7 起步 - 获取帮助](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E8%8E%B7%E5%8F%96%E5%B8%AE%E5%8A%A9)

