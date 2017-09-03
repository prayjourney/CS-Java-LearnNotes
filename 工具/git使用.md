### Git使用
***
###### Git安装
Windows版的Git，下载完成之后，按默认选项安装即可。
安装完成后，在开始菜单里找到"Git"->"Git Bash"，弹出一个命令行窗口，就说明Git安装成功！
![gitinit](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitinit.png)
安装完成后，一般都会对本机的Git进行一些基本的配置。下面的命令就是给Git环境配置全局的用户名和邮箱地址，这样每一个从这台机器上提交的更新都会标上这些用户信息。

```python
git config --global user.name “your user name”
git config --global user.email “your email address”
```

######Git命令流
在Git中支持上百个命令，每个命令又有很多的选项，所以初学者看到这些就会有一些恐惧。
其实，真正接触过Git一段时间后，会慢慢的发现我们会经常使用的命令也就十几二十个，掌握了这些命令之后就可以满足我们大部分的日常工作了。
下面是我根据日常使用整理的一个Git命令流图，包括了一些常用的命令，可以方便自己查阅。
不要被密密麻麻的箭头吓到，其实都是比较初级、常用的命令，后面的文章会详细介绍图中命令的用法以及Git中的一些基本概念。注意，图中没有涉及branch、patch等信息，但是后面的文章会进行介绍。
![gitcmd](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitcmd.png)


######Git基本概念
在Git中，每个版本库都叫做一个**仓库（repository）**，每个仓库可以简单理解成一个**目录**，这个目录里面的所有文件都通过Git来实现版本管理，Git都能跟踪并记录在该目录中发生的所有更新。每当我们建立一个仓库（repo），==那么在建立仓库的这个目录中会有一个"**.git**"的文件夹==。++这个文件夹非常重要，所有的版本信息、更新记录，以及Git进行仓库管理的相关信息全都保存在这个文件夹里面。所以，不要修改/删除其中的文件，以免造成数据的丢失++。
![gitrepo](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitrepo.png)
根据上面的图片，下面给出了每个部分的简要说明：
**Directory**：使用Git管理的一个目录，也就是一个仓库；包含我们的工作空间和Git的管理空间。
**WorkSpace**：从仓库中checkout出来的，需要通过Git进行版本控制的目录和文件；这些目录和文件组成了工作空间。
**.git**：存放Git管理信息的目录，初始化仓库的时候自动创建。
**Index/Stage**：**暂存区**，或者叫做待提交更新区；在提交进入repo之前，我们可以把所有的更新放在暂存区。
**Local Repo**：**本地仓库**，++一个存放在本地的版本库；HEAD会指示当前的开发分支（branch）++。
**Stash**：是一个工作状态保存栈，用于保存/恢复WorkSpace中的临时状态。
**Head**：<font color="red">指向当前分支之中最新提交的指针</font>
![head](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_head.png)
>*绿色的5位字符表示提交的ID，分别指向父节点。分支用橘色显示，分别指向特定的提交。当前分支由附在其上的HEAD标识。 这张图片里显示最后5次提交，ed489是最新提交。 master分支指向此次提交，另一个maint分支指向祖父提交节点*。

######Git基本操作
1.在工作目录、暂存目录(也叫做索引)和仓库之间复制文件

| 命令 | 含义 | 其他 |
|--------|--------|--------|
|  git add files  |  把当前文件放入暂存区域  |  **git add .** 表示添加全部修改   |
|  git commit     |  快照并提交            |  -  |
|  git reset -- files    | 用来撤销最后一次git add files，你也可以用git reset 撤销所有暂存区域文件|  -  |
|  git checkout -- files | 把文件从暂存区域复制到工作目录，用来丢弃本地修改|  -  |
*也可以用 git reset -p, git checkout -p, or git add -p进入交互模式*。
![gitbasic](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitbasic.png)
2.跳过暂存区域直接从仓库取出文件或者直接提交代码。

| 命令 | 含义 | 其他 |
|--------|--------|--------|
|git commit -a |相当于运行 git add 把所有当前目录下的文件加入暂存区域再运行|等价于**git commit.**|
|git commit files| 进行一次包含最后一次提交加上工作目录中文件快照的提交。并且文件被添加到暂存区域|  -  |
|git checkout HEAD -- files | 回滚到复制最后一次提交|  -  |
![gitbasic2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitbasic2.png)
######Git使用
1.**创建仓库**
通过"Git Bash"命令行窗口进入到想要建立版本仓库的目录，通过"git init"就可以轻松的建立一个仓库。++这时，我们的仓库目录中会自动的产生一个".git"文件夹，这个就是我们前面提到的Git管理信息的目录（此文件夹是隐藏状态）++。

2.**添加**
现在我们在仓库中新建一个"calc.py"的文件，文件内容如下。
```python
def add(a, b):
    print (a + b)
if __name__ == "__main__":
    add(2, 3)
```
通过++"**git status**"可以查看WorkSpace的状态++，看到输出显示"calc.py"没有被Git跟踪，并且提示我们可以使用"git add <file>..."把该文件添加到待提交区（暂存区）。**这时的更新只是在WorkSpace中**。
![gitnoadd](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitnoadd.png)
使用"**git add calc.py**"或者"**git add .**"，然后继续查看WorkSpace的状态，**这时发现文件已经被放到暂存区，++这时的更新已经从WorkSpace保存到了Stage中++**。
![gitadd](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitadd.png)
最后，我们就可以通过"**git commit -m**"来提交更新了。++-m后面跟的是对commit的描述（message）++。**这时的更新已经又从Stage保存到了Local Repo中**。
![gitcommit](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitcommit.png)
通过上面的操作，文件"calc.py"就成功的被添加到了仓库中。

3.**更新**
假设现在需要对"calc.py"进行更新，++修改文件后，查看WorkSpace的状态，会发现提示文件有更新，但是更新只是在WorkSpace中，没有存到暂存区中++。
```python
def add(a, b):
    print (a + b)

def sub(a, b):
    print  (a - b)

if __name__ == "__main__":
    add(2, 3)
```
![gitupnoadd](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitupnoadd.png)
同样，**通过add、commit的操作，我们可以把文件的更新先存放到暂存区，然后从暂存区提交到repo中**。
![gitupdate](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitupdate.png)
注意，**只有被add到暂存区的更新才会被提交进入repo**。比如下面的一系列操作，操作结束后只有"multi"函数的更新会被提交到repo中，"div"函数的更新还在WorkSpace中。这点应该也是比较容易理解的。
```python
def multi(a, b):
    print(a * b)

def div(a, b):
    if b != 0:
        print(a / b)
```
![gitaddcom](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitaddcom.png)
**git diff**
"git diff"是一个很有用，而且会经常用到的命令。基于上面的例子，**我们通过"git diff"来查看WorkSpace和Stage的diff情况**，当我们把更新add到Stage中，diff就不会有任何输出了。
![gitdiff](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitdiff.png)
**我们也可以把WorkSpace中的状态跟repo中的状态进行diff，命令如下，关于HEAD，将在后面解释**。
`git diff HEAD~n`

4.**撤销更新**
根据前面对基本概念的了解，更新可能存在三个地方，**WorkSpace中、Stage中和repo中**。下面就分别介绍一下怎么撤销这些更新。
  1. **撤销WorkSpace中的更新**
  接着上面的例子，我们想撤销WorkSpace中的"div"函数的更新，可以看到"git status"的输出中有提示，**我们可以使用"git checkout -- <file>…"（注意一定不要漏掉--）来撤销WorkSpace中的更新**。
*注意，在使用这种方法撤销更新的时候一定要慎重，因为通过这种方式撤销后，更新将没有办法再被找回*，<font color=red>这种方式适用的情况是，我们在workspace之中修改了内容，但是还没有提交到缓存区，这样可以通过checkout来将修改过的内容**复原**</font>。
![gitworkspace](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitworkspace.png)
  2. **撤销Stage中的更新**
  假如我们在WorkSpace中重新添加了"div"函数的更新，++并且使用了"git add"把这个更新提交到了暂存区++。这时，"git status"的输出中提示我们可以通过"**git reset HEAD <file>...**"把暂存区的更新移出到WorkSpace中。如果想继续撤销WorkSpace中的更新，可以使用上面一步的方法。
![gitstage](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitstage.png)
  3. **撤销repo中的更新**
介绍撤销repo中的更新之前，我们先看一下"**git log**"这个命令，++通过这个命令我们可以查看commit的历史记录++。可以看到我们进行的三次提交。其中"WilberTian"和"Wilber\*\*\*com"就是我们在前面一片文章中配置的用户名和邮箱。
撤销主要使用**git reset**命令。**git reset -- files 用来撤销最后一次git add files，也可以用git reset 撤销所有暂存区域文件**。
![gitlog](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitlog.png)
假设我们现在要撤销"add mulit function in calc.py"这个提交，**有两种方式：1使用HEAD指针，2使用commit id**。**在Git中，有一个HEAD指针指向当前分支中最新的提交**，在上面的例子中HEAD就是对应1a72f49ae49c1716e52c12f2b93fdcef6aac0886(commit id)这次提交。所以可以使用下面的命令来撤销"add mulit function in calc.py"这个提交。**注意，当前版本，我们使用"HEAD\~"，那么再前一个版本可以使用"HEAD\~\~"，如果想回退到更早的提交，可以使用"HEAD\~n"。（也就是，HEAD\~=HEAD\~1，HEAD\~\~=HEAD\~2）**
`git rest --hard HEAD^`
等价于
`git rest --hard 1a72f49ae49c1716e52c12f2b93fdcef6aac0886`
再次查看，发现"add mulit function in calc.py"的commit已经被撤销了，查看"calc.py"文件，"multi函数"也已经被删除了。
![gitrepoundo](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitrepoundo.png)
下面来看看"**git reflog**"这个命令。"**git log**"++只是包括了当前分支中的commit记录++，而"**git reflog**"中会++记录这个仓库中所有分支的所有更新记录，包括已经撤销的更新++。
![gitreflog](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitreflog.png)
有了这个，我们就可以查找到"add mulit function in calc.py"提交，然后可以通过下面命令来恢复对"add mulit function in calc.py"的撤销操作。
`git reset --hard HEAD@{1}`
等价于
`git reset --hard 1a72f49`
再次查看，发现我们的"add mulit function in calc.py"更新已经回来了。
![gitback](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitback.png)
**git reset --hard**和**git reset --soft**
前面在使用reset来撤销更新的时候，我们都是使用的"--hard"选项，其实与之对应的还有一个"--soft"选项，区别如下：
**--hard**：*撤销并删除相应的更新*
**--soft**：*撤销相应的更新，把这些更新的内容放的Stage中*

5.**删除文件**
  在Git中，如果我们要删除一个文件，可以使用下面的命令,"**git rm**"相比"rm"只是多了一步，把这次删除的更新发到Stage中。
`rm <file>`
`git rm <file>`

6.**总结**
此文首先介绍了Git的一些基本概念，然后介绍了Git中常用的命令来操作本地repo，内容比较多，但是都是基本的，只要自己动手操作一遍就清楚了。到这里，下面命令流图中的命令都已经被介绍到了。相信通过这些命令，我们已经可以对自己的本地repo进行Git的版本管理了。
![gitcmd2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_gitcmd2.png)

######Git帮助
使用**git \-\-help**即可在bash之中获得相关命令使用以及其含义的帮助
![githelp](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_githelp.png)
(**命令和功能待更新...**)

| 命令 | 功能 |
|--------|--------|
|  git add ./file      |  添加文件到缓存状态     |
|  git commit -m "XXX"      |  提交到本地仓库     |
ref:
[图解Git](http://marklodato.github.io/visual-git-guide/index-zh-cn.html), [Git Step by Step – (1) Git 简介](http://www.cnblogs.com/wilber2013/p/4185643.html), [Git Step by Step – (2) 本地Repo](http://www.cnblogs.com/wilber2013/p/4189920.html), [沉浸式学 Git](http://igit.linuxtoy.org/contents.html)