###Spring配置文件###

在*Spring*之中配置文件用来对例如对象Bean的配置，数据源的加载，aop功能的开启，事务的开启，缓存配置，Hibernate集成，MyBatis的整合等有着重要的管理，此处用一个配置的说明案例来介绍。
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- 自动扫描web包 ,将带有注解的类 纳入spring容器管理 -->
    <context:component-scan base-package="com.eduoinfo.finances.bank.web"></context:component-scan>

    <!-- 引入jdbc配置文件 -->
    <bean id="propertyConfigurer"
 class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="locations">
            <list>
                <value>classpath*:jdbc.properties</value>
            </list>
        </property>
    </bean>

    <!-- dataSource 配置 -->
    <bean id="dataSource"
    class="com.alibaba.druid.pool.DruidDataSource" 
    init-method="init"
    destroy-method="close">
        <!-- 基本属性 url、user、password -->
        <property name="url" value="${jdbc.url}" />
        <property name="username" value="${jdbc.username}" />
        <property name="password" value="${jdbc.password}" />

        <!-- 配置初始化大小、最小、最大 -->
        <property name="initialSize" value="1" />
        <property name="minIdle" value="1" />
        <property name="maxActive" value="20" />

        <!-- 配置获取连接等待超时的时间 -->
        <property name="maxWait" value="60000" />

        <!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
        <property name="timeBetweenEvictionRunsMillis" value="60000" />

        <!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
        <property name="minEvictableIdleTimeMillis" value="300000" />
        <property name="validationQuery" value="SELECT 'x'" />
        <property name="testWhileIdle" value="true" />
        <property name="testOnBorrow" value="false" />
        <property name="testOnReturn" value="false" />

        <!-- 打开PSCache，并且指定每个连接上PSCache的大小 -->
        <property name="poolPreparedStatements" value="false" />
        <property name="maxPoolPreparedStatementPerConnectionSize" value="20" />

        <!-- 配置监控统计拦截的filters -->
        <property name="filters" value="stat" />
    </bean>

    <!-- mybatis文件配置，扫描所有mapper文件 -->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean" p:dataSource-ref="dataSource" p:configLocation="classpath:mybatis-config.xml" p:mapperLocations="classpath:com/eduoinfo/finances/bank/web/dao/*.xml" />

    <!-- spring与mybatis整合配置，扫描所有dao -->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer"
    p:basePackage="com.eduoinfo.finances.bank.web.dao"
    p:sqlSessionFactoryBeanName="sqlSessionFactory" />

    <!-- 对dataSource 数据源进行事务管理 -->
    <bean id="transactionManager"
    class="org.springframework.jdbc.datasource.DataSourceTransactionManager" 
    p:dataSource-ref="dataSource" />

    <!-- 配置使Spring采用CGLIB代理 -->
    <aop:aspectj-autoproxy proxy-target-class="true" />

    <!-- 启用对事务注解的支持 -->
    <tx:annotation-driven transaction-manager="transactionManager" />

    <!-- Cache配置 -->
    <cache:annotation-driven cache-manager="cacheManager" />
    <bean id="ehCacheManagerFactory" class="org.springframework.cache.ehcache.EhCacheManagerFactoryBean" p:configLocation="classpath:ehcache.xml" />
    <bean id="cacheManager" class="org.springframework.cache.ehcache.EhCacheCacheManager" p:cacheManager-ref="ehCacheManagerFactory" />
</beans>

```
例2:
```
<?xml version="1.0" encoding="UTF-8"?>  
<beans xmlns="http://www.springframework.org/schema/beans"  
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
    xsi:schemaLocation="http://www.springframework.org/schema/beans    
http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">  
    <!-- 定义使用C3P0连接池的数据源 -->  
    <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">  
        <!-- 指定连接数据库的JDBC驱动 -->  
        <property name="driverClass">  
            <value>com.mysql.jdbc.Driver</value>  
        </property>  
        <!-- 连接数据库所用的URL -->  
        <property name="jdbcUrl">  
            <value>jdbc:mysql://localhost:3306/eportal?useUnicode=  
                true&characterEncoding=gbk</value>  
        </property>  
        <!-- 连接数据库的用户名 -->  
        <property name="user">  
            <value>root</value>  
        </property>  
        <!-- 连接数据库的密码 -->  
        <property name="password">  
            <value>root</value>  
        </property>  
        <!-- 设置数据库连接池的最大连接数 -->  
        <property name="maxPoolSize">  
            <value>20</value>  
        </property>  
        <!-- 设置数据库连接池的最小连接数 -->  
        <property name="minPoolSize">  
            <value>2</value>  
        </property>  
        <!-- 设置数据库连接池的初始化连接数 -->  
        <property name="initialPoolSize">  
            <value>2</value>  
        </property>  
        <!-- 设置数据库连接池的连接的最大空闲时间，单位为秒 -->  
        <property name="maxIdleTime">  
            <value>20</value>  
        </property>  
    </bean>  
    <!-- 定义Hibernate的SessionFactory -->  
    <bean id="sessionFactory"  
        class="org.springframework.orm.  
hibernate3.LocalSessionFactoryBean">  
        <!-- 依赖注入上面定义的数据源dataSource -->  
        <property name="dataSource" ref="dataSource" />  
        <!-- 注册Hibernate的ORM映射文件 -->  
        <property name="mappingResources">  
            <list>  
                <value>com/eportal/ORM/News.hbm.xml</value>  
                <value>com/eportal/ORM/Category.hbm.xml</value>  
                <value>com/eportal/ORM/Memberlevel.hbm.xml</value>  
                <value>com/eportal/ORM/Cart.hbm.xml</value>  
                <value>com/eportal/ORM/Traffic.hbm.xml</value>  
                <value>com/eportal/ORM/Newsrule.hbm.xml</value>  
                <value>com/eportal/ORM/Merchandise.hbm.xml</value>  
                <value>com/eportal/ORM/Admin.hbm.xml</value>  
                <value>com/eportal/ORM/Orders.hbm.xml</value>  
                <value>com/eportal/ORM/Cartselectedmer.hbm.xml</value>  
                <value>com/eportal/ORM/Newscolumns.hbm.xml</value>  
                <value>com/eportal/ORM/Member.hbm.xml</value>  
            </list>  
        </property>  
        <!-- 设置Hibernate的相关属性 -->  
        <property name="hibernateProperties">  
            <props>  
                <!-- 设置Hibernate的数据库方言 -->  
                <prop key="hibernate.dialect">org.hibernate.dialect.MySQLDialect</prop>  
                <!-- 设置Hibernate是否在控制台输出SQL语句，开发调试阶段通常设为true -->  
                <prop key="show_sql">true</prop>  
                <!-- 设置Hibernate一个提交批次中的最大SQL语句数 -->  
                <prop key="hibernate.jdbc.batch_size">50</prop>  
                <prop key="show_sql">50</prop>  
            </props>  
        </property>  
    </bean>  
    <!--定义Hibernate的事务管理器HibernateTransactionManager -->  
    <bean id="transactionManager"  
        class="org.springframework.orm.hibernate3.HibernateTransactionManager">  
        <!-- 依赖注入上面定义的sessionFactory -->  
        <property name="sessionFactory" ref="sessionFactory" />  
    </bean>  
    <!--定义Spring的事务拦截器TransactionInterceptor -->  
    <bean id="transactionInterceptor"  
        class="org.springframework.transaction.interceptor.TransactionInterceptor">  
        <!-- 依赖注入上面定义的事务管理器transactionManager -->  
        <property name="transactionManager" ref="transactionManager" />  
        <!-- 定义需要进行事务拦截的方法及所采用的事务控制类型 -->  
        <property name="transactionAttributes">  
            <props>  
                <!-- 以browse、list、load、get及is开头的所有方法采用只读型事务控制类型 -->  
                <prop key="browse*">PROPAGATION_REQUIRED,readOnly</prop>  
                <prop key="list*">PROPAGATION_REQUIRED,readOnly</prop>  
                <prop key="load*">PROPAGATION_REQUIRED,readOnly</prop>  
                <prop key="get*">PROPAGATION_REQUIRED,readOnly</prop>  
                <prop key="is*">PROPAGATION_REQUIRED,readOnly</prop>  
                <!-- 所有方法均进行事务控制，如果当前没有事务，则新建一个事务 -->  
                <prop key="*">PROPAGATION_REQUIRED</prop>  
            </props>  
        </property>  
    </bean>  
    <!-- 定义BeanNameAutoProxyCreatorf进行Spring的事务处理 -->  
    <bean  
        class="org.springframework.aop.framework.autoproxy.    
BeanNameAutoProxyCreator">  
        <!-- 针对指定的bean自动生成业务代理 -->  
        <property name="beanNames">  
            <list>  
                <value>adminService</value>  
                <value>columnsService</value>  
                <value>newsService</value>  
                <value>crawlService</value>  
                <value>memberLevelService</value>  
                <value>memberService</value>  
                <value>categoryService</value>  
                <value>merService</value>  
                <value>cartService</value>  
                <value>ordersService</value>  
                <value>trafficService</value>  
            </list>  
        </property>  
        <!-- 这个属性为true时，表示被代理的是目标类本身而不是目标类的接口 -->
        <property name="proxyTargetClass">
            <value>true</value>
        </property>
        <!-- 依赖注入上面定义的事务拦截器transactionInterceptor -->
        <property name="interceptorNames">
            <list>
                <value>transactionInterceptor</value>
            </list>
        </property>
    </bean>
    <!-- 装配通用数据库访问类BaseDAOImpl -->
    <bean id="dao" class="com.eportal.DAO.BaseDAOImpl">
        <property name="sessionFactory" ref="sessionFactory" />
    </bean>
    <!-- 部署系统用户管理业务逻辑组件AdminServiceImpl -->
    <bean id="adminService" class="com.eportal.service.AdminServiceImpl">
        <property name="dao" ref="dao" />
    </bean>
    <!-- 部署新闻栏目管理业务逻辑组件ColumnsServiceImpl -->
    <bean id="columnsService" class="com.eportal.service.ColumnsServiceImpl">
        <property name="dao" ref="dao" />
    </bean>

      <!-- 部署订单管理业务逻辑组件OrderServiceImpl -->
    <bean id="ordersService" class="com.eportal.service.OrderServiceImpl">
        <property name="dao" ref="dao" />
    </bean>
    <!-- 部署流量统计业务逻辑组件TrafficServiceImpl -->
    <bean id="trafficService" class="com.eportal.service.TrafficServiceImpl">
        <property name="dao" ref="dao" />
    </bean>
    <!-- 部署Struts 2负责系统用户管理的控制器AdminAction -->
    <bean id="adminAction" class="com.eportal.struts.action.AdminAction"       scope="prototype">
        <property name="service" ref="adminService" />
    </bean>
    <!-- 部署Struts 2负责新闻栏目管理的控制器ColumnsAction -->  
    <bean id="columnsAction"   class="com.eportal.struts.action.ColumnsAction"    scope="prototype">
        <property name="service" ref="columnsService" />
    </bean>
    <!-- 部署Struts 2负责新闻管理的控制器NewsAction -->
    <bean id="newsAction" class="com.eportal.struts.action.NewsAction"
        scope="prototype">
        <property name="service" ref="newsService" />
        <property name="columnsService" ref="columnsService" />
    </bean>
    <!-- 部署Struts 2负责新闻采集规则管理的控制器CrawlAction -->
    <bean id="crawlAction" class="com.eportal.struts.action.CrawlAction"
        scope="prototype">
        <property name="service" ref="crawlService" />
        <property name="columnsService" ref="columnsService" />
    </bean>
</beans>
```
++*对于配置文件的命名没有强制要求*++

一般情况，除aop之外，一般情况所有的配置，如数据源，事务等都被配置为*bean*，可以设置id和name，class属性是其关联到的类。

***此处说明，property用于对Bean实例中的属性进行赋值，对基本数据类型的值可用value属性直接指定，而ref则表示对于其他的Bean的引用。***
ref:
[spring applicationContext.xml 配置文件 详解](http://blog.csdn.net/zoutongyuan/article/details/27073683)，
[spring配置文件详解--真的蛮详细](http://blog.csdn.net/zzjjiandan/article/details/22922847/)，
[spring配置文件各个属性详解](http://blog.csdn.net/snn1410/article/details/7846582),
[spring4配置文件详解](http://www.cnblogs.com/guscode/p/5518464.html)
[Spring、Spring MVC、MyBatis整合文件配置详解](http://www.cnblogs.com/wxisme/p/4924561.html),
[spring MVC配置详解](http://www.cnblogs.com/superjt/p/3309255.html)