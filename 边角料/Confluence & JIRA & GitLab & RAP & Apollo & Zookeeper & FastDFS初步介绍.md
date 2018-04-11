###  Confluence & JIRA & GitLab & RAP & Apollo & Zookeeper & FastDFS初步介绍

***

##### Confluence

Confluence是一个专业的企业知识管理与协同软件，也可以用于构建企业wiki。使用简单，但它强大的编辑和站点管理特征能够帮助团队成员之间共享信息、文档协作、集体讨论，信息推送。

Confluence为团队提供一个协作环境。在这里，团队成员齐心协力，各擅其能，协同地编写文档和管理项目。从此打破不同团队、不同部门以及个人之间信息孤岛的僵局，Confluence真正实现了组织资源共享。

| 名称          | 本质                   | 功能                         |
| ------------- | ---------------------- | ---------------------------- |
| confluence    | 团队协同与知识管理工具 | 团队成员之间的协作和知识共享 |
| 公司          | 格式                   | 类型                         |
| Atlassian公司 | HTML、PDF、XML、Word   | 企业知识管理与协同软件       |



##### JIRA

JIRA是Atlassian公司出品的**项目与事务跟踪**工具，被广泛应用于*缺陷跟踪*、*客户服务*、*需求收集*、*流程审批*、*任务跟踪*、*项目跟踪*和*敏捷管理*等工作领域。JIRA采用J2EE技术，能够跨平台部署。它正被广泛的开源软件组织，以及全球著名的公司使用。

JIRA产品非常完善且功能强大，安装配置简单，多语言支持、界面十分友好，和其他系统如CVS、Subversion（SVN）、VSS、LDAP、邮件服务整合得相当好，文档齐全，可用性以及可扩展性方面都十分出色，拥有完整的用户权限管理。




##### GitLab

GitLab 是一个用于仓库管理系统的开源项目，使用Git作为代码管理工具，并在此基础上搭建起来的web服务。安装方法是参考GitLab在GitHub上的Wiki页面。



##### RAP

RAP是一个可视化接口管理工具 通过分析接口结构，动态生成模拟数据，校验真实接口正确性， 围绕接口定义，通过一系列自动化工具提升我们的协作效率。



##### Apollo

Apollo（阿波罗）是携程框架部门研发的配置管理平台，能够集中化管理应用不同环境、不同集群的配置，配置修改后能够实时推送到应用端，并且具备规范的权限、流程治理等特性。服务端基于Spring Boot和Spring Cloud开发，打包后可以直接运行，不需要额外安装Tomcat等应用容器。



##### Zookeeper

ZooKeeper是一个分布式]的，开放源码的分布式应用程序协调服务，是Google的Chubby一个开源的实现，是Hadoop和Hbase的重要组件。它是一个为分布式应用提供一致性服务的软件，提供的功能包括：配置维护、域名服务、分布式同步、组服务等。

ZooKeeper的目标就是封装好复杂易出错的关键服务，将简单易用的接口和性能高效、功能稳定的系统提供给用户。ZooKeeper包含一个简单的原语集，提供Java和C的接口。ZooKeeper代码版本中，提供了分布式独享锁、选举、队列的接口，代码在zookeeper-3.4.3\src\recipes。其中分布锁和队列有Java和C两个版本，选举只有Java版本。



##### FastDFS

FastDFS是一个开源的轻量级分布式文件系统，它对文件进行管理，功能包括：文件存储、文件同步、文件访问（文件上传、文件下载）等，解决了大容量存储和负载均衡的问题。特别适合以文件为载体的在线服务，如相册网站、视频网站等等。
FastDFS为互联网量身定制，充分考虑了冗余备份、负载均衡、线性扩容等机制，并注重高可用、高性能等指标，使用FastDFS很容易搭建一套高性能的文件服务器集群提供文件上传、下载等服务。



ref:
1.[新一代开源配置中心 - Apollo](https://yq.aliyun.com/articles/74601),   2.[学习使用Apollo配置中心](http://www.cnblogs.com/andyfengzp/p/7243847.html),   3.[spring boot工程集成apollo配置中心client](https://blog.csdn.net/forliberty/article/details/78284525),   4.[RAP](http://rapapi.org/org/index.do),   5.[zookeeper](https://baike.baidu.com/item/zookeeper/4836397?fr=aladdin),   6.[FastDFS简介](https://blog.csdn.net/zhushuai1221/article/details/52441155),   7.[Zookeeper 的学习与运用](http://blog.jiguang.cn/push_zookeeper_study_usage/)
