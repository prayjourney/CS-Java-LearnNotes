### brew的介绍和常用命令
***

brew 是 Mac 下的一个包管理工具，类似于 centos 下的 yum，可以很方便地进行安装/卸载/更新各种软件包，例如：nodejs, elasticsearch, kibana, mysql, mongodb 等等，可以用来快速搭建各种本地环境，程序员必备工具

#####  安装 brew
首先要通过如下命令安装 brew
```ruby
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```



#####  基本用法
###### 安装/卸载/更新
以 nodejs 为例，执行下面命令即可，安装目录在 `/usr/local/Cellar`
```powershell
brew install nodejs
```
如果需要更新或卸载
```shell
brew upgrade nodejs
brew remove nodejs
```

###### 其他命令
```shell
brew list                   # 列出当前安装的软件
brew search nodejs          # 查询与 nodejs 相关的可用软件
brew info nodejs            # 查询 nodejs 的安装信息
```
如果需要指定版本，可以在 `brew search` 查看有没有需要的版本，在 `@` 后面指定版本号，例如 `brew install thrift@0.9`



#####  brew services
`brew services` 是一个非常强大的工具，可以用来管理各种服务的启停，有点像 linux 里面的 services，非常方便，以 elasticsearch 为例
```shell
brew install elasticsearch          # 安装 elasticsearch
brew services start elasticsearch   # 启动 elasticsearch
brew services stop elasticsearch    # 停止 elasticsearch
brew services restart elasticsearch # 重启 elasticsearch
brew services list                  # 列出当前的状态
```

brew services 服务相关配置以及日志路径
**配置路径**：`/usr/local/etc/`
**日志路径**：`/usr/local/var/log`



ref:
1.[Mac 必备工具之 brew](https://segmentfault.com/a/1190000013317511),   2.[Mac 必备工具之 brew](http://www.hatlonely.com/2018/02/21/Mac-%E5%BF%85%E5%A4%87%E5%B7%A5%E5%85%B7%E4%B9%8B-brew/)