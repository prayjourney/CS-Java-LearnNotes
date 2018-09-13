### RabbitMQ的安装配置
***

##### 安装Server
RabbitMQ的安装配置 比较简单, 和普通的软件安装没有太大的区别, 需要注意的只是它的管理平台, 在安装完RabbitMQ的Server之后, 我们需要通过安装插件的形式来安装管理平台, 按照如下方式即可:
```html
1. 运行命令行窗口cmd, 进入安装目录的sbin目录下
2. 输入命令rabbitmq-plugins enable rabbitmq_management，这样就可以添加可视化插件了
```
在web浏览器中输入地址: http://127.0.0.1:15672/, 可以验证安装是否成功, 输入默认账号: guest, 密码: guest, 就可以登录查看rabbitmq里的资源信息. 



##### 常用命令和日志
启动服务: 可以运行 `rabbitmq-server  -detached`命令来重启服务并后台运行
停止服务: 可以运行 `rabbitmqctl stop` 命令来停止服务
日志位置: RabbitMQ的日志信息, 可以在 C:/Users/XXX/AppData/Roaming/RabbitMQ/log/文件夹下进行查看



ref:

1.[RabbitMQ的安装和配置化可视界面](https://www.cnblogs.com/wade-luffy/p/6003668.html),   2.[rabbitmq管理界面开启](http://blog.51cto.com/xiong51/2113794)