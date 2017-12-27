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

##### 获取 Git 仓库

有两种取得 Git 项目仓库的方法。 第一种是在现有项目或目录下导入所有文件到 Git 中； 第二种是从一个服务器克隆一个现有的 Git 仓库。

###### 在现有目录中初始化仓库

使用 Git 来对现有的项目进行管理，需要进入该项目目录并输入：

```cmake
$ git init
```

该命令将创建一个名为 `.git` 的子目录，这个子目录含有初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。此时仅仅是做了一个初始化的操作，项目里的文件还没有被跟踪。在一个已经存在文件的文件夹（而不是空文件夹）中初始化 Git 仓库来进行版本控制的话，**应该开始跟踪这些文件并提交**。 可通过 `git add` 命令来实现对指定文件的跟踪，然后执行 `git commit` 提交

```cmake
$ git add *.c
$ git add LICENSE
$ git commit -m 'initial project version'
```

###### 克隆现有的仓库

如果想获得一份已经存在了的 Git 仓库的拷贝，比如说github上面的某一个项目，这时就要用到 `git clone` 命令。 **Git 克隆的是该 Git 仓库服务器上的几乎所有数据，而不是仅仅复制完成你的工作所需要文件**。 *当执行 `git clone` 命令的时候，默认配置下远程 Git 仓库中的每一个文件的每一个版本都将被拉取下来*。 克隆仓库的命令格式是 `git clone [url]` 。 比如，要克隆 Git 的可链接库 libgit2，可以用下面的命令

```cmake
$ git clone https://github.com/libgit2/libgit2
```

这会在当前目录下创建一个名为 “libgit2” 的目录，并在这个目录下初始化一个 `.git` 文件夹，从远程仓库拉取下所有数据放入 `.git` 文件夹，然后从中读取最新版本的文件的拷贝。 以上命令得到的本地仓库和远程仓库名称相同，如果想在克隆远程仓库的时候，**自定义本地仓库的名字**，可以使用如下命令

```cmake
$ git clone https://github.com/libgit2/libgit2 mylibgit
```

这将执行与上一个命令相同的操作，不过在本地创建的仓库名字变为 `mylibgit`。

##### 文件状态

工作目录下的每一个文件都不外乎这两种状态：**已跟踪**或**未跟踪**。 **已跟踪的文件是指那些被纳入了版本控制的文件，在上一次快照中有它们的记录**，在工作一段时间后，它们的状态可能处于未修改，已修改或已放入暂存区。 工作目录中除已跟踪文件以外的所有其它文件都属于**未跟踪文件，它们既不存在于上次快照的记录中，也没有放入暂存区**。 *初次克隆某个仓库的时候，工作目录中的所有文件都属于已跟踪文件，并处于未修改状态*。编辑过某些文件之后，由于自上次提交后对它们做了修改，Git 将它们标记为已修改文件。 我们逐步将这些修改过的文件放入暂存区，然后提交所有暂存了的修改，如此反复。所以使用 Git 时文件的生命周期如下：

![Git 下文件生命周期图。](https://git-scm.com/book/en/v2/images/lifecycle.png)

要查看哪些文件处于什么状态，可以用 `git status` 命令。 如果在克隆仓库后立即使用此命令，会看到类似这样的输出

```cmake
$ git status
On branch master
nothing to commit, working directory clean
```

**这说明所有已跟踪文件在上次提交后都未被更改过。 此外，上面的信息还表明，当前目录下没有出现任何处于未跟踪状态的新文件**，该命令还显示了当前所在分支，分支名是 “master”，这是默认的分支名。 

现在在项目下创建一个新的 README 文件。 如果之前并不存在这个文件，使用 `git status` 命令，你将看到一个新的**未跟踪文件**

```cmake
$ echo 'My Project' > README
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

    README

nothing added to commit but untracked files present (use "git add" to track)
```

在状态报告中可以看到新建的 README 文件出现在 `Untracked files` 下面。 **未跟踪的文件意味着 Git 在之前的快照（提交）中没有这些文件**；*Git 不会自动将之纳入跟踪范围，除非使用`git add README`来说明我需要跟踪该文件*， 次吃才会将此文件纳入到跟踪范围之中，并且，此时此文件在暂存区，是一个快照，并未保存到Git 本地仓库之中永久存储

**通常，我们使用`git status`得到的文件状态比较复杂，我们可以使用`git status -s`来获取简略的信息，通常有`A`和`M`两种，`A`表示新添加的文件，`M`表示修改过的文件**

##### 跟踪/暂存新文件

使用命令 `git add` 开始跟踪一个文件。 所以，要跟踪 README 文件，可以运行如下命令行

```cmake
$ git add README
```

此时再运行 `git status` 命令，会看到 README 文件已被跟踪，并处于暂存状态

```
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README
```

**只要在 `Changes to be committed` 这行下面的，就说明是已暂存状态**。 如果此时提交，那么该文件此时此刻的版本将被留存在历史记录中。**`git add`后文件存放在暂存区**， `git add`是个多功能命令：*可以用它开始跟踪新文件，或者把已跟踪的文件放到暂存区，还能用于合并时把有冲突的文件标记为已解决状态等*。**这个命令可以理解为“添加内容到下一次提交中”**。

##### 查看已暂存/未暂存已修改的文件

现在我们来修改一个已被跟踪的文件。 如果**修改**了一个名为 `CONTRIBUTING.md` 的**已被跟踪的文件**，然后运行 `git status` 命令，就可实现对已经暂存的文件的状态查看

```
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

文件 `CONTRIBUTING.md` 出现在 `Changes not staged for commit` 这行下面，说明已跟踪文件的内容发生了变化，但还没有放到暂存区。 要暂存这次更新，需要运行 `git add` 命令

###### 查看已暂存

然后运行 `git add` 将"CONTRIBUTING.md"放到暂存区，输入 `git status` 可看到

```
$ git add CONTRIBUTING.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README
    modified:   CONTRIBUTING.md
```

现在两个文件都已暂存，下次提交时就会一并记录到仓库。

######查看未暂存已修改的文件 

假设此时，需要在 `CONTRIBUTING.md` 里加条注释， 然后保存，再运行 `git status` ，则有如下输出

```
$ vim CONTRIBUTING.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README
    modified:   CONTRIBUTING.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

**此时的 `CONTRIBUTING.md` 文件同时出现在暂存区和非暂存区**。 此时的操作是**1.刚`git add`过一次，2.然后立即又修改了文档，3.再又运行`git status`命令**。实际上此时的 Git 只不过暂存了运行 `git add` 命令时的版本（**1处的版本**）， 如果此时提交，`CONTRIBUTING.md` 的版本是你最后一次运行 `git add` 命令时的那个版本（**1处的版本**），而不是在工作目录中的当前版本（**2处的版本**）。 所以，**运行了 `git add` 之后又作了修订的文件，需要重新运行 `git add` 把最新版本重新暂存起来**

```
$ git add CONTRIBUTING.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    new file:   README
    modified:   CONTRIBUTING.md
```

###### 查看已暂存和未暂存的修改

虽然，现在我们可以使用`git status`来查看文档的状态，但是这只是针对与文档的，也就是说，我们可以看见那些文档是新增的，那些是修改的，但是具体文档之中修改了什么，新增了什么，我们无法知道，这种情况下，我们需要使用`git diff`命令来完成查看，**尽管 `git status` 已经通过在相应栏下列出文件名的方式回答了这个问题，`git diff` 将通过文件补丁的格式显示具体哪些行发生了改变**

- `git status`:   文件的增减，修改
- `git diff`:   文件内容的增加和修改
  - 查看**未暂存**修改：`git diff`
  - 查看**已暂存**修改：`git diff --cached`

假如再次修改 README 文件后暂存，然后编辑 `CONTRIBUTING.md` 文件后先不暂存， 运行 `status` 命令将会看到：

```
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    modified:   README

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

**要查看尚未暂存的文件更新了哪些部分，不加参数直接输入 `git diff`**

```
$ git diff
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 8ebb991..643e24f 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -65,7 +65,8 @@ branch directly, things can get messy.
 Please include a nice description of your changes when you submit your PR;
 if we have to read the whole diff to figure out why you're contributing
 in the first place, you're less likely to get feedback and have your change
-merged in.
+merged in. Also, split your changes into comprehensive chunks if your patch is
+longer than a dozen lines.

 If you are starting to work on a particular area, feel free to submit a PR
 that highlights your work in progress (and note in the PR title that it's
```

**此命令比较的是工作目录中当前文件和暂存区域快照之间的差异， 也就是修改之后还没有暂存起来的变化内容**

若要查看已暂存的将要添加到下次提交里的内容，可以用 `git diff --cached` 命令。（Git 1.6.1 及更高版本还允许使用 `git diff --staged`，效果是相同的，但更好记些。）

```
$ git diff --staged
diff --git a/README b/README
new file mode 100644
index 0000000..03902a1
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+My Project
```

请注意，git diff 本身只显示尚未暂存的改动，而不是自上次提交以来所做的所有改动。 所以有时候你一下子暂存了所有更新过的文件后，运行 `git diff` 后却什么也没有，就是这个原因。

像之前说的，暂存 `CONTRIBUTING.md` 后再编辑，运行 `git status` 会看到暂存前后的两个版本。 如果我们的环境（终端输出）看起来如下：

```
$ git add CONTRIBUTING.md
$ echo '# test line' >> CONTRIBUTING.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    modified:   CONTRIBUTING.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md
```

现在运行 `git diff` 看暂存前后的变化：

```
$ git diff
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 643e24f..87f08c8 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -119,3 +119,4 @@ at the
 ## Starter Projects

 See our [projects list](https://github.com/libgit2/libgit2/blob/development/PROJECTS.md).
+# test line
```

然后用 `git diff --cached` 查看已经暂存起来的变化：（--staged 和 --cached 是同义词）

```
$ git diff --cached
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 8ebb991..643e24f 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -65,7 +65,8 @@ branch directly, things can get messy.
 Please include a nice description of your changes when you submit your PR;
 if we have to read the whole diff to figure out why you're contributing
 in the first place, you're less likely to get feedback and have your change
-merged in.
+merged in. Also, split your changes into comprehensive chunks if your patch is
+longer than a dozen lines.

 If you are starting to work on a particular area, feel free to submit a PR
 that highlights your work in progress (and note in the PR title that it's
```

### 



### Git 分支



ref:

1.[1.3 起步 - Git 基础](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-Git-%E5%9F%BA%E7%A1%80),   2.[1.6 起步 - 初次运行 Git 前的配置](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%88%9D%E6%AC%A1%E8%BF%90%E8%A1%8C-Git-%E5%89%8D%E7%9A%84%E9%85%8D%E7%BD%AE#_first_time),   3.[1.7 起步 - 获取帮助](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E8%8E%B7%E5%8F%96%E5%B8%AE%E5%8A%A9),   4.[2.1 Git 基础 - 获取 Git 仓库](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E8%8E%B7%E5%8F%96-Git-%E4%BB%93%E5%BA%93),   5.[]()

