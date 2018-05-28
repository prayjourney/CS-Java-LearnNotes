### 用 Hexo 搭建博客
***
这会是一篇很长的教程。其实，介绍 Hexo 在 Github 上搭建博客的教程汗牛充栋，之所以还要继续这一项重复的工作，主要是我心中对理想的技术博客文章有两点期盼：

- 技术博客不仅仅是操作手册，不仅要告诉读者如何做，还要告诉读者为何要这么做；
- 消除神秘性，在博客文章中给出的信息都应该提供参考资料，且最好是官方文档，信息的准确性不会经过 N 手转述而打折。

这一篇文章，是我的一次尝试。本文一共 6 个部分，第 1 章，在具体动手之前，先要思考一下整个 Hexo 建站过程一共可以分为几个模块，每个模块涉及到的各个工具扮演的究竟是什么角色。第 2 章，我们正式进入到操作阶段，讲述 Hexo 在本地建站。第 3 章是关于如何把本地建好的网站部署到 Github Pages 上去。第 4 章，介绍如何绑定独立域名。最后两章，分别介绍身为作者如何获得更好的写作体验，以及如何让读者获得更好的访客体验。

#### 1. 动手前的思考

在看这篇文章之前，也许你已经看过不少关于 Hexo 和 Github 搭建博客的文章了，那你肯定见过这些：Hexo、Github Pages、SSH 配置、域名解析、A 记录、CNAME。这些究竟是什么东西？一下子都灌输给我，头好晕。别担心，这一章就是先帮我们理清思路的。

##### 1.1 模块划分

上面提到的 Hexo、Github Pages、SSH 配置、域名解析、A 记录、CNAME，那么多名词，都是由完全不认识的人创造、负责管理的，所以每个名词所代表的背后的服务之间的耦合度是非常低的。这里，我根据访问网址的不同，将利用 Hexo 和 Github Pages 搭建博客的流程一共分为如下 3 大模块：

- **Hexo 本地建站：**这一模块利用 Hexo 在本地（你的电脑）内生成你的网站，可以通过 <http://localhost:4000/> 来查看最后生成的网站；
- **部署到 Github Pages：**这一模块介绍 Github Pages 服务以及利用 Hexo 将上一模块中生成的网站部署到 Github 服务器，从而可以通过 your_name.github.io 访问你新建的博客。其中，your_name 是你 Github 的用户名；
- **绑定独立域名：**这一模块介绍如何绑定自己购买的独立域名，从而可以通过自己购买的网址访问自己的网站，如果没有购买独立域名的打算，这一模块可以不用进行。

##### 1.2 关键词解释

Hexo、Github Pages、SSH 配置、域名解析、A 记录、CNAME 这些名词究竟代表了什么？为了不至于在后面的操作阶段懵逼，这里，我们先来打点预防针。

- **Hexo：**Hexo 是一款静态博客生成器。静态的意思是指生成的博客网站访客只能浏览，没法像淘宝那样在我们的网站上提交信息。Hexo 负责把我们写的 Markdown 文件根据选定的主题（规定网站的外观样式的文件）生成一堆 HTML 以及负责外观样式的 CSS 和 Javascript 文件。此外，Hexo 还提供了帮我们把这一堆 HTML、CSS、Javascript 文件上传到 Github 服务器的功能，也就是部署。
- **Github Page：**我们平时在新浪上看新闻的时候，所有的东西都要从新浪服务器发送到我们的手机、电脑上。我们的网站也一样，需要一个服务器，把用 Hexo 生成的那些 HTML、CSS、Javascript 文件发送给访客。但我们自己没有服务器呀？Github Pages 是 Github 提供的一项免费的静态页面托管服务，提供 your_name.github.io 的域名（your_name 为你的 Github 用户名）发布自己的静态网站。我们把 Hexo 生成的内容上传到 Github 服务器，访客的浏览器就是从 Github 服务器获取相关文件的。



#### 2. Hexo 本地建站

##### 2.1 安装 Hexo

根据 Hexo 的官方文档 [开始使用 — 概述](https://hexo.io/zh-cn/docs/index.html)，安装 Hexo 的前提是先安装 [Node.js](https://nodejs.org/zh-cn/) 和 [Git](https://git-scm.com/download)，再安装完这两者后，安装 Hexo 很简单，只需在终端（cmd、Git bash、Node.js command prompt 均可）中敲入如下命令，回车等待安装完成。

```
npm install -g hexo-cli
```

##### 2.2 建立站点

- **Step 1:** 先在电脑中的某一位置建立好 `your_name.github.io` 文件夹，比如 `D:\Blog\your_name.github.io`；

- **Step 2:** 在终端中切换到 `your_name.github.io` 文件夹所在的路径。需要注意的是，在 Windows 中，如果要进入某个磁盘，不需要敲 `cd`，直接敲盘符即可。比如我要进入 `D:\Blog\your_name.github.io`，那就输入 `D:` 回车，然后再 `cd Blog\your_name.github.io`；

- **Step 3:** 由于默认的 NPM 镜像实在太慢太慢，我们把源替换成淘宝的镜像，在终端中执行如下命令：

  ```
  npm config set registry "https://registry.npm.taobao.org"
  ```

  需要注意的是，这一次切换是暂时的，如果下回从 npm 下载一些东西还是觉得非常慢，记得再执行一次这一条命令。

- **Step 4:** 根据 Hexo 的官方文档 [开始使用 — 建站](https://hexo.io/zh-cn/docs/setup.html)，依次执行下面两条命令，建立我们的新网站：

  ```
  hexo init
  npm install
  ```

  换了淘宝的镜像后，应该能在几分钟内完成。完成后，`your_name.github.io` 文件夹下面的目录如下：

  ```
  .
  ├── _config.yml
  ├── package.json
  ├── scaffolds
  ├── source
  |   └── _posts
  └── themes
  ```

  - `_config.yml` 文件存放着网站的配置信息，可以在这里配置大部分的参数。
  - `package.json` 文件存放着插件信息，从中可以查看那些插件已经安装。
  - `scaffolds` 是模板文件夹，新建文章时，Hexo 会根据 scaffold 来建立文件，不过这个模板和后面的主题里指的模板不一样。
  - `source` 是存放用户资源的地方的文件夹，除 `_posts` 文件夹之外，开头命名为 `_` (下划线) 的文件 / 文件夹和隐藏的文件将会被忽略。Markdown 和 HTML 文件会被解析并放到 `public` 文件夹（别急，等下会生成的），而其他文件会被拷贝过去。
  - `themes` 主题文件夹，Hexo 会根据主题来生成静态页面，我们以后自己安装的主题也都会放在这个文件夹下面，默认的 landscape 主题已经在里面了。

- **Step 5:** 根据 Hexo 的官方文档 [开始使用 — 命令](https://hexo.io/zh-cn/docs/commands.html)，在终端中敲入 `hexo server` 命令（确保路径仍在 `your_name.github.io` 下），可以在 <http://localhost:4000/> 中看到我们网站默认的样子了。

##### 2.3 配置站点

在 `_config.yml` 中，我们可以修改大部份的配置，里面每一个参数的含义可以查看 Hexo 的官方文档 [开始使用 — 配置](https://hexo.io/zh-cn/docs/configuration.html) ，这里我暂且只修改了 `title`，`subtitle` 和 `author`，替换成自己网站的名字和作者名即可。另外，我觉得默认的网址链接有点长，将 `permalink` 改成如下：

```
permalink: :title/
```

`per_page` 决定首页显示多少篇文章，默认的 10 篇有点多，我改成了 5 篇。其余的设置，比如 theme，deploy 我们回头用到了再来更改。

##### 2.4 生成自己的内容

在 `_posts` 文件夹下，新建一个 Markdown 文件，或者把你以前有的 Markdown 文件复制进来，根据 Hexo 的官方文档 [基本操作 — Front-matter](https://hexo.io/zh-cn/docs/front-matter.html) ，写好你的第一篇文章，比如：

```
title: Test for Hexo
date: 2016/12/7 20:46:25
categories:
- Diary
tags:
- PS3
- Games
---

Hexo Test.
```

这里，Front-matter 是文件最上方以 `---` 分隔的区域，用于指定文章的标题、建立日期、更新日期等，如果主题模板还支持分类和标签的话（比如默认的 landscape 主题），还可以指定分类和标签。根据 Hexo 的官方文档 [基本操作 — 生成文件](https://hexo.io/zh-cn/docs/generating.html)，在终端中敲入如下命令：

```
hexo generate
```

Hexo 会替我们刚加入到 `_posts` 文件夹下的 markdown 文件生成静态文件。运行 `hexo server` 可以在 <http://localhost:4000/> 中看到我们新添加的网页内容了。至此，我们采用默认主题 landscape 的网站已经生成了，且相信你已经掌握了关于 Hexo 的大部分操作，如果自感还不熟悉，可以再看看 Hexo 的官方文档 [开始使用 — 命令](https://hexo.io/zh-cn/docs/commands.html)，主要是下面几个命令：

- `hexo init [folder]`: 新建一个网站。如果没有设置 `folder` ，Hexo 默认在目前的文件夹建立网站；
- `hexo generate`: 生成静态文件；
- `hexo server`: 启动服务器。默认情况下，访问网址为： `http://localhost:4000/`；
- `hexo deploy`: 部署网站（后文会用得）；
- `hexo clean`: 清除缓存文件 (`db.json`) 和 `public` 文件夹下已生成的静态文件。

##### 2.5 更换主题

如果觉得默认的 landscape 并不是自己最喜欢的那一款，我们可以去 [Themes | Hexo](https://hexo.io/themes/) 中挑选喜欢的主题。就我个人而言，最喜欢的是 [Noise](http://lotabout.me/hexo-theme-noise/) 和 [Phase](https://hexo.io/hexo-theme-phase/) 这两个主题，下面就以 Noise 为例。

- **Step 1:** 在 Demo 页面上找到该主题的 Github 主页，比如 Noise 就是在其页底的 Theme [noise](https://github.com/lotabout/hexo-theme-noise) 字样上。如果没找到，可以在 Github 上的 [hexo - Wiki - Themes](https://github.com/hexojs/hexo/wiki/Themes) 中搜索对应主题名，[hexo - Wiki - Themes](https://github.com/hexojs/hexo/wiki/Themes) 整理了每个 Hexo 主题的 项目主页 和 Demo 网址；

- **Step 2:** 根据 [Noise 主页](https://github.com/lotabout/hexo-theme-noise) 上的文档，我们需要先安装主题和渲染器：

  ```
  git clone https://github.com/lotabout/hexo-theme-noise themes/noise
  npm install hexo-renderer-less --save
  npm install hexo-renderer-jade --save
  ```

- **Step 3:** 根据 [Noise 主页](https://github.com/lotabout/hexo-theme-noise) 上的文档，将 `your_name.github.io/_config.yml` 中的 `theme` 的值由原来默认的 `landscape` 改为 `noise` 。

至此，主题已经更换完成，依次运行`hexo clean`, `hexo generate`, `hexo server` 我们可以在 <http://localhost:4000/> 上查看我们网站新的样式。根据 [Noise 主页](https://github.com/lotabout/hexo-theme-noise) 上的文档，我们还可以进一步的配置该主题，不过这内容就扯开去了。过段时间，我会专门写一篇文章关于 Noise 主题的配置、对 LaTeX 的支持和访问速度的优化，敬请期待。更换其他主题的操作与此基本相同，不再赘述。



#### 3. 部署到 Github

部署到 Github 的命令行操作都在 Git Bash 中完成。也许黑黢黢的命令行、陌生的 SSH 和 git 会让你有点害怕，请不要担心，下面的所有操作都来源于 Github Pages 和 Hexo 的官方文档，且我会解释每一步究竟是干什么的，以及为何要这么做。

事实上，这一环节非常简单，其实本质上就是一个 `git push` 操作，只不过我们要 `push` 的这个项目的名字比较特殊，刚好是 `your_name.github.io` 而已。根据 Github 的官方文档 [Set Up Git](https://help.github.com/articles/set-up-git/)，我们可以把这一环节分为 4 个流程，第一步建立一个名为 `your_name.github.io` 的 repository，第二步设置 Git（[Setting up Git](https://help.github.com/articles/set-up-git/##setting-up-git)），第三步从 Git 与 Github 进行身份验证（[Authenticating with GitHub from Git](https://help.github.com/articles/set-up-git/##next-steps-authenticating-with-github-from-git)）， 最后一部上传项目也就是 Hexo 部署我们的站点。

##### 3.1 Creating a repository

要在 Github 上创建项目，当然首先需要[注册 Github帐号](https://github.com/join?source=header-home)。在注册完成后，Github 的官方文档 [Create a new repository on GitHub](https://help.github.com/articles/create-a-repo/##create-a-new-repository-on-github) 已经图文并茂将如何建立一个 repository 交待得非常清楚明白了，唯一要注意的是，第二步里的 Repository name 一定要是 `your_name.github.io` ，`your_name` 是你的 Github 用户名。

##### 3.2 Setting up Git

根据 Github 的官方文档 [Setting up Git](https://help.github.com/articles/set-up-git/##setting-up-git)，这一操作的目的是 Tell Git your *name* so your commits will be properly labeled 和 Tell Git the *email address* that will be associated with your Git commits，也就是告诉版本控制软件 Git 接下来这台电脑上提交的文件是 E-mail 地址是什么的谁谁谁提交的。在 Git Bash 中执行如下代码即可：

```
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR EMAIL ADDRESS"
```

其中，`YOUR NAME` 是自己取的名字，`YOUR EMAIL ADDRESS` 是自己的邮箱。由于自己的博客网站就自己一个人提交，所以就都设置成跟 Github 用户名和邮箱相同了。但其实是可以不同的，因为对于很多项目，并不只有一个开发者，Github 允许多人向同一个 Repo 提交，这里提供用户名和邮箱，只是为了搞清楚哪些代码是谁谁谁提交的。

##### 3.3 Authenticating with GitHub from Git

这一整章，我们的最终目的是实现在终端中敲入 `hexo deploy` 后，Hexo 会将我们本地的 `public` 文件夹下的东西上传到 Github 服务器，这样我们就可以通过 `your_name.github.io` 这个域名（`your_name` 是你的 Github 用户名）看到我们已经上网的博客网站了。为了实现这个目的，首先我们先要让本地的电脑和 Github 服务器建立起某种联系，也就是让 Github 服务器信任由我这台电脑提交的东西，接受，并存放到`your_name.github.io` 这个 Repo 下面，与 Github 服务器建立信任的这个环节就是身份认证（Authenticating ）。根据 Github 的官方文档 [Authenticating with GitHub from Git](https://help.github.com/articles/set-up-git/##next-steps-authenticating-with-github-from-git) 这里，我们选择 [**Connecting over SSH**](https://help.github.com/articles/set-up-git/##connecting-over-ssh) 这一种方式。在 Github 的官方文档 [Categories / SSH](https://help.github.com/categories/ssh/) 下，我们能找到关于 Github 与 SSH 的资料。

###### 3.3.1 生成新的 SSH key

根据 Github 的官方文档 [Generating a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/##generating-a-new-ssh-key) ， 我们在 Git Bash 下执行如下命令，生成 SSH key

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

其中，`your_email@example.com` 是你的 Github 注册邮箱。然后，Git Bash 中会出现

```
Generating public/private rsa key pair.
```

表示新的 SSH 已经生成了。随后会出现

```
Enter a file in which to save the key
(/Users/you/.ssh/id_rsa): [Press enter]
```

这里 `id_rsa` 是生成的 key 文件的文件名，默认都是这个；如果不是，在后面用到 `id_rsa` 的地方请替换成出现的名字。这条信息是让你选择 SSH key 存放的地点，按回车选择默认的即可。回车后，还会出现

```
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]
```

让你设置使用 SSH 密钥时的密码，由于我们都是在自己个人的电脑上操作，所以仍然回车，不设置密码即可。

###### 3.3.2 将 SSH key 添加到 ssh-agent

根据 [Wikipedia](https://en.wikipedia.org/wiki/Ssh-agent)，[ssh-agent](https://en.wikipedia.org/wiki/Ssh-agent) 是一个在本地登录会话持续时间内，将未加密的密钥存储在内存中，并使用 Unix 域套接字与 SSH 客户端进行通信的程序。根据 Github 的官方文档 [Adding your SSH key to the ssh-agent](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/##adding-your-ssh-key-to-the-ssh-agent) ， 我们在 Git Bash 下执行如下命令，开启 ssh-agent

```
eval "$(ssh-agent -s)"
```

然后我们要将这个 SSH key 添加到 ssh-agent 里去，运行如下命令，其中 `id_rsa` 是你的 key 文件的文件名：

```
ssh-add ~/.ssh/id_rsa
```

###### 3.3.3 将 SSH key 添加到 Github 账户

Github 的官方文档 [Adding a new SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/) 已经图文并茂将如何在 Github

帐号中添加 SSH 介绍的非常清楚了。先是在 Git Bash 中将 SSH Key 拷贝出来：

```
$ clip < ~/.ssh/id_rsa.pub
## Copies the contents of the id_rsa.pub file to your clipboard
```

`id_rsa` 是你刚才的 SSH Key 文件。此时，SSH Key 已经在我们的剪切板里了。然后登录 Github 帐号，依次点击自己的头像，**Settings**，**SSH and GPG keys**，**New SSH key** 或者 **Add SSH key**， 在 **Title** 这里输入 Key 的label，比如 `your_name - PC`，然后在 Key 里面把 **SSH Key** 粘贴进去，点击 **Add SSH key**大功告成。

回想一下，操作了那么多 SSH 相关的命令，我们在干嘛？个人的理解，就是在生成身份认证的凭证 SSH key，分别放在自己本地电脑和 Github 服务器上，以后向 Github 提交内容的时候，两者的 Key 匹配就可以了，省去了我们每次输密码的时间。

###### 3.3.4 测试 SSH 连接

在大功告成之前，为了稳妥起见，我们来测试一下自己跟 Github 服务器 SSH 连接是否已经建立起来了。Github 的官方文档 [Testing your SSH connection](https://help.github.com/articles/testing-your-ssh-connection/) 已经将次环节介绍得非常详细了。我们要做得就是在 Git Bash 中敲入

```
ssh -T git@github.com
```

你可能会看到类似于

```
The authenticity of host 'github.com (192.30.252.1)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)?
```

没关系的，输入 `yes` 敲回车，就可以看到如下的成功信息了

```
Hi username! You've successfully authenticated, but GitHub does not
provide shell access.
```

至此为止，我们已经建立起了跟 Github 服务器的连接。其实我们也可以用 `git push` 命令，提交 `public`文件夹下面的内容，不过 Hexo 更我们提供了更方便的途径。

##### 3.4 Hexo 部署

Hexo 提供了 `hexo deploy` 命令，可以方便地将整个 `public` 文件夹部署到 Github 服务器上去。根据 Hexo 的官方文档 [基本操作 — 部署](https://hexo.io/zh-cn/docs/deployment.html) 我们只需要做以下两步：

- **Step 1:** 在终端中运行如下命令，安装 `hexo-deployer-git` 插件：

  ```
  npm install hexo-deployer-git --save
  ```

- **Step 2:** 在 `_config.yml` 中修改参数，如下所示：

```
deploy:
  type: git
  repo: https://github.com/your_name/your_name.github.io.git
  branch: master
```

其中，your_name 是你的 Github 帐号名。`repo` 对应的是你 `your_name.github.io` 这个项目的库（Repository）地址，进入这个项目的主页，点击 **Clone or download** 下拉菜单也能看到。`branch` 是分支名称，如果使用的是 GitHub 或 GitCafe 的话，程序会尝试自动检测，通常都是 `master`。 **注意，冒号后的空格非常重要，一定要有！**

至此，在终端执行 `hexo deploy` 命令，就可以把我们的网站部署到 Github 服务器上。在第一次部署的时候，Github 还会跳出来一个小窗口，让你输入 Github 帐号和密码，输入即可。根据不少网友的说法以及我之前搭站的经验，等待 15 分钟的样子，就可以通过 your_name.github.io （your_name 是你的 Github 用户名）来访问自己的网站了。如果等了很久还没动静，或者想立刻看到效果，该怎么破？别急，请看下一小节。

###### 3.4 部署了，没动静怎么办？

博客第一次创建，即使 deploy 成功了，但仍然不会立刻可以访问，还需要等待 15 分钟以上。以前我也用 Github Pages 建过博客，都是等一会就好，不过这一次我没有等到。过了两个钟头，还是无法访问。有点急了，我是如下搞定的。

- **Step 1:** 到 your_name.github.io 项目的 Github 主页，网址形如 <https://github.com/your_name/your_name.github.io> ，上方最右侧有一个 **Settings**，点击 **Settings**，拉到 **GitHub Pages**，有一个**Launch automatic page generator**，点击后，再点击 **Continue to layouts**，最后点击 **Publish page**，马上就可以看到 your_name.github.io 可以访问了，但样式是是刚刚默认的，跟我们本地的不一样，内容也没有我们自己上传的内容。
- **Step 2:** 再试着 `hexo deploy` 一次，如果页面正常了那就大功告成了，假使遇到 Permission Denied，再 `hexo deploy` 一次就好。



#### 4. 绑定独立域名

看到这里，恭喜你已经拥有了域名为 `your_name.github.io` 的个人博客网站了，进一步的，就是希望能够在浏览器中输入自己的域名，比如 `your.site`，就可以看到自己的网站。停下来思考一下，要实现这一目的，我们需要干什么？首先，当然我们要去买一个域名。买完域名后呢？怎么要让浏览器知道这个域名对应的网站内容在 Github 服务器上？这就是域名解析的事情啦。这是浏览器这里，还有 Github 服务器呢？Github 服务器上存放着那么多个人网站，怎么在收到浏览器一个要访问我的域名为 `your.site`这个站点内容的时候，准确的把我的站点的内容送出来呢？这就是要在自己提交的 `public` 文件夹下添加 CNAME 文件了。一共 3 个环节，我们一个一个来介绍。

##### 4.1 购买域名

域名提供商非常多，比如 Godaddy、 DNSPod 和 Gandi ，这三者都支持支付宝付款。经 [L 叔](http://liam0205.me/) 推荐，我是在 [Gandi](https://www.gandi.net/) 上买的域名，挑了一个丑丑的没人要的域名，10 年才 150 RMB 就买下了。域名注册很简单，不过需要特别注意的是，虽然 Gandi 提供了简体中文的界面，但填写注册信息的时候，**一定要填英文字符！！！**。输入中文也能够注册成功，但坑的是什么呢？在你付完款以后，会域名创建不成功，原因卡在比如地址信息中的中文字符集超出范围了。遇上了这种情况，也不要慌，在 Gandi 的 **账户管理** 中的 **更新账户资讯** 中把中文字符改成英文的，然后再在 **服务** 中的 **域名** 这里点击类似重启该操作字样的按钮即可。至此，第一步购买域名已经完成。

##### 4.2 域名解析

我们在浏览器中输入的是 `your.site` 这样的域名，但实际在网络中，真正的地址是 IP 地址，就如何将 `your.site` 这样的域名转化成 IP 地址告诉浏览器去哪里找所要的网站文件呢？这就是 DNS 服务器的作用。那我们要怎么才能告诉遍布全世界的这么多 DNS 服务器我们的 `your.site` 网站上的资源放在 IP 为 XXX.XXX.XXX.XXX 的哪台服务器上呢？这就是域名解析服务了。Godaddy 和 Gandi 这样的域名提供商，都提供了自带的 DNS 解析服务，可惜，在国内这些域名解析通常较慢，[DNSPod ](http://dnspod.cn/)提供了免费的域名解析服务，速度更快，解析生效的时间也更快，通常只要等待 10 秒的样子即可。我们可以在终端（cmd） 里面 `ping gandi.net` 和 `ping dnspod.cn` 在我电脑上，前者是 350 毫秒，而后者只有 23 毫秒，快了 10 倍不止。那么如何用 DNSPod 来解析我在 Gandi 上买的域名呢？

Step 1: 告诉 Github `your_name.github.io` 对应哪个域名

在 `source` 文件夹下添加一个 `CNAME` 文件，里面就一行内容，写上自己的域名，比如 `your.site`。 在终端中运行

```
hexo generate
```

Hexo 在生成 `public` 文件夹内容的时候，会自动把 `CNAME` 文件复制过去，这样，`public` 文件夹下就也有 `CNAME` 文件了。再运行

```
hexo deploy
```

将其部署到 Github，让 Github 知道 `your_name.github.io` 对应哪个域名。

Step 2: 告诉 Gandi 我要用 DNSPod 解析域名

登录 Gandi，点击 **服务** 中的 **域名** 中你购买的域名，进入 **域名 > your.site** 页面，your.site 是你购买的域名，在网页的下方找到 **修改伺服器**，点击进入。删掉 Gandi 原来自带的 3 个 DNS 服务器地址，填入 DNSPod 的域名服务器。那 DNSPod 的域名服务器是什么呢？在 DNSPod 的官方文档 [DNSPod 各个套餐的 DNS 地址](https://support.dnspod.cn/Kb/showarticle/?qtype=%E5%8A%9F%E8%83%BD%E4%BB%8B%E7%BB%8D%E5%8F%8A%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B&tsid=178) 中可以知道，DNSPod 免费 DNS 服务器的地址为：`f1g1ns1.dnspod.net` 和 `f1g1ns2.dnspod.net`。在 Gandi 那里把这两个地址依次填入，保存。

Step 3: 告诉 DNSPod 域名对应的网站存放在哪台服务器上

DNSPod 的官方文档 [学会使用 DNSPod，仅需三步](https://support.dnspod.cn/Kb/showarticle/tsid/177/) 已经图文并茂的将如何告诉 DNSPod 域名对应的网站存放在哪台服务器上介绍地非常详细了。在注册完 DNSPod 后，点击 **添加域名**，添加上自己购买的域名，点击 **确定**，再点击刚添加的域名，在域名记录管理界面，点击 **添加记录**，添加两条 A 记录即可，最后如下图所示：

![mark](http://ohm5uq281.bkt.clouddn.com/blog/20161208/142105538.png)

其中，`192.30.252.153` 和 `192.30.252.154` 为 GIthub 服务器的 IP 地址，可以从 Github 的官方文档 [Configuring A records with your DNS provider](https://help.github.com/articles/setting-up-an-apex-domain/##configuring-a-records-with-your-dns-provider) 知道。DNSPod 域名解析生效非常快，只要等待十来秒即可用自己的域名访问了。至此，拥有独立域名的博客网站都已经搭建完了。



#### 5. 更好的作者体验

就我自己以往的经历而言，除了爬虫以外，博客的真实访问量基本为零，博客文章更多的其实是写给自己的，是自己阶段性工作和思路的总结整理，所以也就会多考虑一点身为作者，如何获得更好的体验，分享几个自己小心得。

##### 5.1 图床软件

不管是出于为了让国内访问速度更快，还是不好意思给 Github 服务器添太多麻烦的目的，我们中的很多人都会使用像 [七牛云](https://www.qiniu.com/) 这样的服务作为图床，但这样的操作每次都要到七牛云网站手动上传，再复制链接地址，当图片一多时自己的耐心也就快速被消磨了。在 Mac 上有 [图床神器 iPic](https://toolinbox.net/iPic/)，在 Windows 上 [罗朝福](http://blog.lzhaofu.cn/) 也开发了 [Windows 下的图片上传工具 MPic](http://blog.lzhaofu.cn/2016/08/26/%E5%9B%BE%E5%BA%8A%E7%A5%9E%E5%99%A8-Windows%E4%B8%8B%E7%9A%84%E5%9B%BE%E7%89%87%E4%B8%8A%E4%BC%A0%E5%B7%A5%E5%85%B7MPic/)，均支持七牛云。在图床神器的帮助下，屏幕截图、复制的图片，都可以自动上传、保存 Markdown 格式的链接，直接在 Markdown 文件中粘贴插入。如果对怎么添加七牛云有点困惑，可以查看 [ITJason ](http://www.jianshu.com/users/8f3d6e37991d)的 [在 iPic 中添加七牛云](http://www.jianshu.com/p/97bf7bbb18ee) 一文，MPic 也是同样的操作。

##### 5.2 LaTeX 支持

有时，我们的博客文章会有几个数学公式，而这些数学公式一般都早就存在在我们的各自的文章里了，不管这些公式是我们 Word 在中用 Mathtype 敲的，还是 LaTeX 写得，他们都可以得到 LaTeX 的形式。最常见的 Wikipedia 是将数学公式显示成图片的格式，如果采用这种方式，可以用 KLatexFormula 生成图片，用 iPic 或者 MPic 上传图床。

不过体验更好的方式是直接在 Markdown 中写 LaTeX 代码，或者从 tex 文件中将 LaTeX 代码复制过来，MathJax 和 KaTeX 都可以帮助我们在网页中直接显示 LaTeX 公式。考虑到 KaTeX 的渲染速度是 MathJax 的百倍以上，<http://lowrank.science/> 采用 KaTeX 来渲染数学公式，关于如何使 Hexo 博客支持 KaTeX 可以看我的上一篇文章 [Hexo 博客支持 KaTeX（回炉版）](http://lowrank.science/Hexo-KaTeX/)。

##### 5.3 本地 Markdown 软件

聪明的你，可以跳过这一小节。我之所以写这个内容，实在是被之前的我要蠢哭了。我以前写博客，可是真的用 Sublime Text 3 写好 Markdown，然后 `hexo generate`、`hexo deploy` 后在线去看，发现不对再回来调得。。。

推荐采用 Typora 现在本地写好 Markdown，所见即所得，确认样式没问题后再上传。需要注意的一点是，由于 Hexo 采用 `- Game` 这样的 tags 记号，`tags` 或者 `category` 其中的一个，在你不注意的时候，很容易缩进成跟 `- Game` 这样的 item 了，`hexo generate` 会报错，将 `tags` 或者 `category` 顶格即可。其实，也不需要这么麻烦，`tags` 或者 `category` 被缩进成 item 的时候，按下 Shift + Tab 保持顶格即可。

##### 5.4 二维码捐赠

受 [L 叔](http://liam0205.me/) 的启发，可以在文章的最后贴上支付宝和微信的二维码，希冀能由从自己文章中受益的小伙伴打赏一点，cover 一下域名的钱。自己支付宝的收款二维码可以从 <https://qr.alipay.com/paipai/open.htm> 这里获取，微信的，可以点击手机微信 APP 最右上角的加号 -> **收付款** -> **我要收款** 这里下载二维码。

##### 5.5 思路整理

目前，我在使用 [幕布](http://mubu.io/)，最初只是简单用来记录一下笔记，后来我发现幕布的树形结构非常好使，可以在记录笔记的时候顺便就把思路给整理好，后续的文章写作就非常流畅了~ 幕布同类的产品还有 [WorkFlowy](https://workflowy.com/) 和 [Dynalist](https://dynalist.io/)，后者还支持 LaTeX 和 Markdown，不过国内访问速度有些慢。根据自己的喜好，挑一款即可~



#### 6. 更好的访客体验

现有的 Hexo 主题都相当漂亮，因此这一章所要追寻的更好的访客体验我们主要关注如何提高网站的加载速度。

##### 6.1 图像压缩神器 TinyPNG

[TinyPNG](https://tinypng.com/) 是一个在线 PNG 和 JPG 图像压缩服务，经过其进一步压缩，可以在保证图像没有肉眼可以察觉的质量损失的情况下，将图像体积压缩到原来的几分之一。在将图片上传到图床前，先经由 TinyPNG 压缩一下，可以加快网页的加载时间，对于移动用户，也能节省一些流量。

##### 6.2 用 KaTeX 替代 MathJax

KaTeX 渲染 LaTeX 公式的速度比 MathJax 快上百倍，读者可以在 [KaTeX and MathJax Comparison Demo](http://www.intmath.com/cg5/katex-mathjax-comparison.php)上感受下两者速度的差别，在我电脑上，KaTeX 渲染完所有公式仅用了 118 毫秒，而 MathJax 用了 15708 毫秒。关于如何使 Hexo 博客支持 KaTeX 可以看我的上一篇文章 [Hexo 博客支持 KaTeX（回炉版）](http://lowrank.science/Hexo-KaTeX/)。

##### 6.3 采用 DNSPod 解析域名

在国内，DNSPod 的免费域名解析服务比 Gandi、Godaddy 这些域名提供商自带的域名解析服务快上很多，采用 DNSPod 解析域名能够进一步提高我们网站的访问速度，关于如何采用 DNSPod 解析域名，可以查看本文的 **4.2 域名解析** 小节。

##### 6.4 优化 Hexo 主题

很多时候，觉得自己网站访问的慢，问题多半是出在自己所选用的主题上，主题所采用的 Javascript、CSS 或者字体在一些访问比较困难的公共服务器上，导致网页迟迟加载不完。在 Chrome 浏览器中，可以 **右键** -> **检查** -> **Network** ，然后再刷新下网页，看看具体是什么拖累了自己网站的访问速度，找到病因，如果问题出在主题上，那就要去更改自己所采用的主题。我在另一篇文章 [Hexo Noise 主题的使用和优化](http://lowrank.science/Hexo-Noise/)记录了对 Hexo 的 Noise 主题的访问速度做优化的过程



#### 7. 创建迁移和同步
##### 7.1 新电脑中的环境搭建
这部分应该要简单一点，如果你已经搭建过一个hexo博客的话。这种情况是我们已经在其他电脑上有了一个博客环境，在github上面有发布的文章，此时，我们在另外的电脑上搭建我们的hexo环境，步骤如下：

1.新电脑上安装node.js和git
2.安装
```xml
hexo：npm install -g hexo-cli
```
3.clone远程仓库到本地
```javascript
git clone - b "branch-name" git@github.com:username/username.github.io.git
```
4.根据packge.json安装依赖
```
npm install
```
5.本地生成网站
```
hexo g
```
6.并开启博客服务器：
```xml
hexo s
```
如果一切正常，此时打开浏览器输入http://localhost:4000/已经可以看到博客正常运行了。

##### 7.2 在两台电脑上的同步操作
git pull从远程hexo分支拉取最新的环境文件到本地，可以理解为svn的更新操作。比如在公司写了博客，回家在电脑上也要写需要先执行这一步操作。
文章写完，要发布时，需要先提交环境文件，再发布文章。按以下顺序执行命令：git add .、git commit -m "some descrption"、git push origin hexo、hexo g -d。



#### 致谢

最后，感谢 [L 叔](http://liam0205.me/) 和 [阿诺](http://panxiuqing.github.io/) 在文章写作过程中提供的帮助，也感谢您一直阅读到这里，如果我的文章有错误或不足之处，请务必在评论中留言指出，千万不用客气，万分感谢~

ref:

1.[在win7中一步一步安装Hexo搭建个人博客](http://www.lzblog.cn/2016/04/06/%E5%9C%A8win7%E4%B8%AD%E4%B8%80%E6%AD%A5%E4%B8%80%E6%AD%A5%E5%AE%89%E8%A3%85Hexo%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/),   2.[知行合一 | 用 Hexo 搭建博客](http://lowrank.science/Hexo-Github/),   3.[hexo博客同步管理及迁移](https://www.jianshu.com/p/fceaf373d797),   4.[windows下如何安装hexo？](https://www.zhihu.com/question/29994270),   5.[使用hexo，如果换了电脑怎么更新博客？](使用hexo，如果换了电脑怎么更新博客？)