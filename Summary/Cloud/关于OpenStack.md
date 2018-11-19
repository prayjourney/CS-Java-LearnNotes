### 关于OpenStack

***
OpenStack覆盖了网络、虚拟化、操作系统、服务器等各个方面。它是一个正在开发中的云计算平台项目，根据成熟及重要程度的不同，被分解成核心项目、孵化项目，以及支持项目和相关项目。每个项目都有自己的委员会和项目技术主管，而且每个项目都不是一成不变的，孵化项目可以根据发展的成熟度和重要性，转变为核心项目。截止到Icehouse版本，下面列出了10个核心项目（即OpenStack服务）。

**计算（Compute）：Nova**。一套控制器，用于为单个用户或使用群组管理虚拟机实例的整个生命周期，根据用户需求来提供虚拟服务。负责虚拟机创建、开机、关机、挂起、暂停、调整、迁移、重启、销毁等操作，配置CPU、内存等信息规格。自Austin版本集成到项目中。

**对象存储（Object Storage）：Swift**。一套用于在大规模可扩展系统中通过内置冗余及高容错机制实现对象存储的系统，允许进行存储或者检索文件。可为Glance提供镜像存储，为Cinder提供卷备份服务。自Austin版本集成到项目中。

**镜像服务（Image Service）：Glance**。一套虚拟机镜像查找及检索系统，支持多种虚拟机镜像格式（AKI、AMI、ARI、ISO、QCOW2、Raw、VDI、VHD、VMDK），有创建上传镜像、删除镜像、编辑镜像基本信息的功能。自Bexar版本集成到项目中。

**身份服务（Identity Service）：Keystone**。为OpenStack其他服务提供身份验证、服务规则和服务令牌的功能，管理Domains、Projects、Users、Groups、Roles。自Essex版本集成到项目中。

**网络&地址管理（Network）：Neutron**。提供云计算的网络虚拟化技术，为OpenStack其他服务提供网络连接服务。为用户提供接口，可以定义Network、Subnet、Router，配置DHCP、DNS、负载均衡、L3服务，网络支持GRE、VLAN。插件架构支持许多主流的网络厂家和技术，如OpenvSwitch。自Folsom版本集成到项目中。

**块存储 (Block Storage)：Cinder**。为运行实例提供稳定的数据块存储服务，它的插件驱动架构有利于块设备的创建和管理，如创建卷、删除卷，在实例上挂载和卸载卷。自Folsom版本集成到项目中。

**UI 界面 (Dashboard)：Horizon**。OpenStack中各种服务的Web管理门户，用于简化用户对服务的操作，例如：启动实例、分配IP地址、配置访问控制等。自Essex版本集成到项目中。

**测量 (Metering)：Ceilometer**。像一个漏斗一样，能把OpenStack内部发生的几乎所有的事件都收集起来，然后为计费和监控以及其它服务提供数据支撑。自Havana版本集成到项目中。

**部署编排 (Orchestration)：Heat**。提供了一种通过模板定义的协同部署方式，实现云基础设施软件运行环境（计算、存储和网络资源）的自动化部署。自Havana版本集成到项目中。

**数据库服务（Database Service）：Trove**。为用户在OpenStack的环境提供可扩展和可靠的关系和非关系数据库引擎服务。自Icehouse版本集成到项目中。



ref:
1.[OpenStack](https://baike.baidu.com/item/OpenStack/342467?fr=aladdin)





