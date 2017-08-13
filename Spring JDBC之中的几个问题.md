### Spring JDBC之中的几个问题

- - -

- [ ] jdbctemplate之中query和queryForObject的区别，jdbctemplate之中的RowMapper的API，以及queryForObject所可以接受的类型

- - -

**1.JdbcTemplate**

  - 介绍

  JdbcTemplate位于*org.springframework.jdbc.core*包之中，是此包之中的核心，其简化了JDBC的使用，可以进行查询，更新等操作。*数据源必须被配置成一个bean，以供上下文来调用*，**此类的一个实例，一旦经过配置，则是线程安全的**。

  ==This is the central class in the JDBC core package. It simplifies the use of JDBC and helps to avoid common errors. It executes core JDBC workflow, leaving application code to provide SQL and extract results. This class executes SQL queries or updates, initiating iteration over ResultSets and catching JDBC exceptions and translating them to the generic, more informative exception hierarchy defined in the org.springframework.dao package.

   Code using this class need only implement callback interfaces, giving them a clearly defined contract. The PreparedStatementCreator callback interface creates a prepared statement given a Connection, providing SQL and any necessary parameters. The ResultSetExtractor interface extracts values from a ResultSet. See also PreparedStatementSetter and RowMapper for two popular alternative callback interfaces.

Can be used within a service implementation via direct instantiation with a DataSource reference, or get prepared in an application context and given to services as bean reference. Note: The DataSource should always be configured as a bean in the application context, in the first case given to the service directly, in the second case to the prepared template.

  Because this class is parameterizable by the callback interfaces and the SQLExceptionTranslator interface, there should be no need to subclass it.

 All SQL operations performed by this class are logged at debug level, using "org.springframework.jdbc.core.JdbcTemplate" as log category.

 NOTE: An instance of this class is thread-safe once configured.==

  - 常用方法

  ```

    int[]	 batchUpdate(String... sql)

    Issue multiple SQL updates on a single JDBC Statement using batching.

    void	  execute(String sql)

    Issue a single SQL execute, typically a DDL statement.

    int	    getFetchSize()

    Return the fetch size specified for this JdbcTemplate.

    int	    getMaxRows()

    Return the maximum number of rows specified for this JdbcTemplate.

    int	    update(String sql)

    Issue a single SQL update operation (such as an insert, update or delete statement).

    int	    update(String sql, Object... args)

    Issue a single SQL update operation (such as an insert, update or delete statement) via a prepared statement, binding the given arguments.

    int	    update(String sql, PreparedStatementSetter pss)

    Issue an update statement using a PreparedStatementSetter to set bind parameters, with given SQL.

    <T> T	query(String sql, Object[] args,  ResultSetExtractor<T> rse)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, reading the ResultSet with a ResultSetExtractor.

    <T> List<T>	query(PreparedStatementCreator psc, RowMapper<T> rowMapper)

    Query using a prepared statement, mapping each row to a Java object via a RowMapper.

    <T> List<T>	query(String sql, Object[] args, int[] argTypes, RowMapper<T> rowMapper)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, mapping each row to a Java object via a RowMapper.

    <T> List<T>	query(String sql, Object[] args, RowMapper<T> rowMapper)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, mapping each row to a Java object via a RowMapper.

    <T> T	queryForObject(String sql, Class<T> requiredType)

    Execute a query for a result object, given static SQL.

    <T> T	queryForObject(String sql, Class<T> requiredType, Object... args)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, expecting a result object.

    List<Map<String,Object>>	queryForList(String sql)

    Execute a query for a result list, given static SQL.

    <T> List<T>	queryForList(String sql, Class<T> elementType)

    Execute a query for a result list, given static SQL.

    <T> List<T>	queryForList(String sql, Class<T> elementType, Object... args)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, expecting a result list.

    List<Map<String,Object>>	queryForList(String sql, Object... args)

    Query given SQL to create a prepared statement from SQL and a list of arguments to bind to the query, expecting a result list.

```



- 总结上面的方法，重要的有 update, query, queryFOrObject, queryForList, queryForMap等几种，update用来执行增删修，queryXXX用来执行查询。*queryForObject用来查询对象，如果我们的对象是自定义的，Spring并不能直接解析，所以需要使用创建RowMapper的类，来将我们的对象封装起来,普通的如int,string这种是可以直接解析的。*

 对于query和queryForObject而言，就我目前的使用来看，queryForObject多在单个查询之中使用，配合自定义的RowMapper子类，而返回一个对象；query也需要配合自定义的RowMapper子类来使用，但是其返回的是一个List更多的，queryForList返回的更多的是List< Map< String, Object >>的类型，此外还有	queryForMap方法，这几个方法彼此互有重叠，还需要在今后多加研究。

- RowMapper

  位于*org.springframework.jdbc.core*，是一个接口。用来将JDBCTemplate查询的结果映射于ResultSet之中，异常由JDBCTemplate来处理。

  ==An interface used by JdbcTemplate for mapping rows of a ResultSet on a per-row basis. Implementations of this interface perform the actual work of mapping each row to a result object, but don't need to worry about exception handling. SQLExceptions will be caught and handled by the calling JdbcTemplate.

Typically used either for JdbcTemplate's query methods or for out parameters of stored procedures. RowMapper objects are typically stateless and thus reusable; they are an ideal choice for implementing row-mapping logic in a single place.

  Alternatively, consider subclassing MappingSqlQuery from the jdbc.object package: Instead of working with separate JdbcTemplate and RowMapper objects, you can build executable query objects (containing row-mapping logic) in that style.==

  需要实现的方法：

```

  T	mapRow(ResultSet rs, int rowNum)

Implementations must implement this method to map each row of data in the ResultSet.

```

具体其中每行的处理是使用ResultSet的，其是位于java.sql中的接口，通过对应的get方法，而取得或者是“列号”或者是“列名”上的值，即可。









ref:

[springJDBC queryForObject结果转bean对象](http://sd1992585.iteye.com/blog/963412),

[jdbcTemplate queryForObject 查询 结果集 数量](http://www.cnblogs.com/rocky-fang/p/5660890.html),

[SpringMVC jdbcTemplate中queryForObject以及queryForList返回映射实体使用](http://www.2cto.com/kf/201501/374254.html)