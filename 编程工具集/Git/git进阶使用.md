### git 进阶使用
---

##### 工作区, 暂存区, 版本库
**工作区**: 工作区是用户能够直接使用和操作的部分, 也就是我们IDE之中可以直接操作的内容, 这部分就是工作区.
**暂存区**: `git add xxx.txt` 这部分的内容, 存储在.git文件夹下的index文件之中, 也就是说暂存区可以理解成是(stage/index).
**版本库**: 版本库是使用了`git commit -m"xxx"`指令之后, 这部分的修改已经在git仓库之中做了修改了, 修改的内容, 存储在.git文件夹下面的objects文件夹下面.



##### HEAD的概念
**HEAD**: 是**游标**或者说是**指针**, *它一般是指向当前的分支的指针*, 可以将它与当前分支等同(其实它是指向当前分支).`.git`目录中有一个为HEAD的文件，它记录着HEAD的内容，查看其中内容代码如下:
```shell
$ cat .git/HEAD
ref: refs/heads/abc-stage
```
继续查看`refs/heads/abc-stage`之中的内容, 显示如下:
```shell
cat .git/refs/heads/abc-stage
c69d81475574316226b92ad2c268505857f845cc
```
表明abc-stage分支也只是一个存放40位sha-1值的文件而已，正是当前的abc-stage分支所指向commit的sha-1值.
除了`HEAD`, 还有`ORIG_HEAD`和`detached HEAD`, `ORIG_HEAD`在`.git`文件夹下面有一个`ORIG_HEAD`文件,`detached HEAD`也有一个对应的文件, 二者之中记录的内容都是commit的sha-1值, 也就是commit id. **ORIG_HEAD在merge, rebase, reset等危险操作的时候记录生成**, 生成的是这个危险操作之前的一个commit id, 可以用以恢复,回滚等操作. HEAD是一个指针, 通常情况下, 它指向当前所在分支, 而分支又指向一个commit提交. **HEAD并不总指向一个分支**, *某些时候仅指向某个commit提交, 这就形成detached HEAD*. **也就是说不指向当前分支, 仅仅指向某个提交, 就形成了游离HEAD**.



##### `git stage` 和`git stash`
`git stash`的内容, 在`.git`目录下的refs的文件夹下的stash文件之中, 也就是`.git/refs/stash`文件, 由此可以看出, stash所使用的空间和stage完全不同, 二者虽然很相似, 但是实际含义是不一样的! git stage和git stash很相似, 都是暂存的意思, 但是发生的位置不一样, `git stage`是为了提交到仓库, 也就是说`git stage`就已经是进入了暂存区, 从工作区到暂存区, 这一动作是`git add filename/filepath`. 而`git stash`, 是**把所有未提交到仓库的, 修改了的文件暂存起来**, 二者的目的不一样. 简单的说, *git stage为了把当前修改的文件从工作区暂存到暂存区, git stash是把所有没有提交到仓库之中的文件临时保存, 去做其他的操作, 而进行的操作*. 下面是git stash的相关命令:

|        命令          |                          作用                   |
|---------------------|------------------------------------------------|
|git stash --help     | git stash 命令的帮助文档                          |
|git stash            | 能够将所有未提交的修改（工作区和暂存区）保存至堆栈中，用于后续恢复当前工作目录                           |
|git stash save       |作用等同于git stash，区别是可以加一些注释, 如 git stash save "test1", 相当于起了个名字给stash, 叫test1  |
|git stash list       | 查看当前stash中的所有内容                                                                           |
|git stash pop        | 将当前stash中的内容弹出, 并应用到当前分支对应的工作目录上.注:该命令将堆栈中最近保存的内容删除(栈是先进后出)|
|git stash apply      | 将堆栈中的内容应用到当前目录, 不同于git stash pop, 该命令不会将内容从堆栈中删除, 也就说该命令能够将堆栈的内容多次应用到工作目录中, 适应于多个分支的情况.                                                                                                  |
|git stash drop + 名称 | 从堆栈中移除某个指定的stash                                                                         |
|git stash clear       |清除堆栈中的所有stash                                                                               |
|git stash show        | 查看堆栈中最新保存的stash和当前目录的差异                                                            |
|git stash branch      | 从最新的stash创建分支                                                                             |



##### `git log` 常用命令

|          命令           |       作用    |     例子                     |
|------------------------|---------------|------------------------------|
|git log --help          | 查看git log 相关的命令     |                   |
|git log -n              | 查看当前分支10条提交的历史  |  git log -10      |
|git log -p filepath(file) | 查看这个路径或者文件的提交历史, 还有before, after同样的用法 | git log -p ./abc<abc是文件夹>, git log -p myfile.txt<文件> |
|git log --since =<date> | 查看自从这个date以来的日志  | git log --since =2019-4-1  |
| git log --author=<peoplename>| 查看这个代码作者的提交日志        | git log --author=zuiguangyin                       |
|git log --committer=<peoplename>    | 查看这个代码提交者的日志    | git log --committer=zuiguangyin                    |



##### `git diff`常用命令

|        命令          |                                       作用                                                       |
|---------------------|---------------------------------------------------------------------------------------------------|
|比较不同分支                                                                                                              |
|git diff branch1 branch2            | 比较branch1和branch2之间的详细差别, 例子:git diff master dev                         |
|git diff branch1 branch2 --stat     | 显示出所有有差异的文件(不详细,没有对比内容)                                            |
|比较同一分支                                                                                                              |
|git diff                            |工作区 vs 暂存区, 工作区和暂存去比较差别                                               |
|git diff head                       |工作区 vs 版本库, 工作区和版本库比较差别                                               |
|git diff --cached                   |暂存区 vs 版本库, 暂存区和版本库比较差别                                               |
|git diff --cached  filename         |比较暂存区和库版本之间的差别                                                           |
|git diff commit-id commit-id        |比较两个commit id的差别                                                              |

`git diff`同一个分支的时候, 默认的是工作区, 如果有`--cached`则表示为认为是默认的是暂存区, 比较的时候, 有一个参数, 或者一个参数都没有, 那么默认的就是和"相邻的区"比较, 而且是向上的, 朝稳定的一个方向比, 稳定的方向是从`工作区--->暂存区--->版本库`, 相邻的区有:`工作区<--->暂存区<--->版本库`.



##### `git tag`和`git branch`
`git branch`和`git tag`非常相似, 但是区别也很明显, 最明显的区别就是, branch, HEAD的位置, 或者说它提交的最新的commit id是一直改变的, 而tag的话, 是一个固定值, 是不变了的, 一个用来开发, 一个用来查看, 这样很好.
git tag存在的位置在于.git目录下的refs的文件夹下的tags文件之中 .git/refs/tags文件, 由此可以看出, tag和branch之间没有影响, tag 对应某次 commit, 是一个点，是不可移动的, branch 对应一系列 commit，是很多点连成的一根线，有一个HEAD 指针，是可以依靠 HEAD 指针移动的. 所以，**两者的区别决定了使用方式，改动代码用 branch, 不改动只查看用 tag**. 需要说明的是, 创建 tag 是基于本地分支的 commit, 而且*分支的推送和tag的推送是两回事*, 就是说分支已经推送到远程了, 但是tag并没有, 如果把 tag 推送到远程分支上, 需要另外执行tag的推送命令. 一个疑问: ~~tag是基于分支的呢?还是和分支无关的?~~~ 下面是git tag的相关命令:

|      命令                         |                   作用                    |
|-----------------------------------|-------------------------------------------|
|git tag --help                     |     tag的help                             |
|git tag                            |     查看tag                               |
|git tag [name]                     |     创建tag, name不可重复                  |
|git tag -d [name]                  |     删除名为name的tag                      |
|git tag -D [name]                  |     强制删除名为name的tag                  |
|git push origin [name]             |     创建远程版本(本地版本push到远程)        |
|git push origin :refs/tags/[name]  |     删除远程tag                            |
|git pull origin --tags             |     合并远程仓库的tag到本地                 |
|git push origin --tags             |     上传本地tag到远程仓库                   |
|git tag -a [name] -m 'yourMessage' |     创建带注释的tag                        |

---
ref:
1.[Git HEAD详解](http://www.softwhy.com/article-8499-1.html),   2.[Git ORIG_HEAD用法介绍](http://www.softwhy.com/article-8502-1.html),   3.[detached HEAD详解](http://www.softwhy.com/article-8500-1.html),   4.[git 理解 HEAD^与HEAD~](https://blog.csdn.net/claroja/article/details/78858411),   5.[git 中 HEAD 概念](https://blog.csdn.net/u011011827/article/details/79808379),   6.[git diff 的用法](https://www.cnblogs.com/chenfulin5/p/8674565.html),   7.[git diff的最全最详细的4大主流用法](https://blog.csdn.net/wq6ylg08/article/details/88798254),   8.[Git diff 常见用法](https://www.cnblogs.com/qianqiannian/p/6010219.html),   9.[Git之——Git工作区、版本库和暂存区](https://blog.csdn.net/u012150179/article/details/19409597),   10.[Git 工作区、暂存区和版本库](http://www.worldhello.net/2010/11/30/2166.html),   11.[图解Git工作区、暂存区、版本库之间的关系](https://segmentfault.com/a/1190000017053187),   12.[工作区、版本库和暂存区第6篇](https://www.jianshu.com/p/a308acded2ce),   13.[Git三大特色之Stage(暂存区)](https://blog.csdn.net/qq_32452623/article/details/78417609),   14.[git stash详解](https://blog.csdn.net/stone_yw/article/details/80795669),   15.[git stash的详细讲解](https://www.jianshu.com/p/14afc9916dcb),   16.[git stash 用法](https://www.cnblogs.com/yanghaizhou/p/5269899.html),   17.[git-stash用法小结](https://www.cnblogs.com/tocy/p/git-stash-reference.html),   17.[git-stash用法小结](https://www.cnblogs.com/tocy/p/git-stash-reference.html),   18.[Git 处理tag和branch的命令](https://blog.csdn.net/u011619283/article/details/53229936),   19.[Git的tag作用和使用场景以及branch的区别](https://blog.csdn.net/lcgoing/article/details/86241784),   20.[git中branch与tag](https://blog.csdn.net/zwwjs/article/details/8162475),   21.[Git仓库分支(Branch)和标签(Tag)](https://blog.csdn.net/iprettydeveloper/article/details/53944125),   22.[Git 常用命令详解（二）](https://www.oschina.net/question/565065_86025),   23.[Git tag标签与branch分支的区别](http://www.softwhy.com/article-8549-1.html),   24.[git中tag和branch简单的介绍](https://www.jianshu.com/p/65cca7bbea50)