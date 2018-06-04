### 关于MyBatis开发的一些问题

***

#### Spring boot开发的基本套路

Spring boot和其他的Spring开发的方式基本的套路是一致的，首先建立**domain层**，然后建立**service层**，然后使用**controller层(控制层)**调用service，而在service之中，需要调用的就是**dao层**，dao层在domain层的基础之上，对数据库进行操作，使用orm框架，建立起数据库和java对象的对应关系。
整个的调用关系如下：
```java
domain->dao->service(service implement)->controller
```



#### 使用XML方式的mybatis操作

使用XML配置的方式是比较传统的方式，需要些Mapper的配置文件(XML文件)和Mapper的方法文件(Java)，这两部分是分开的，其调用的方式和使用注解的方式是一致的，也是使用service调用mybatis写成的dao层，service层在controller层调用，提供想要的结果。

Domain层：SysUser

```java
package tk.mybatis.simple.model;

import java.util.Date;
import java.util.Arrays;

/**
 * 用户表
 * 
 * @author prayjourney
 */
public class SysUser
{
	private Long id;
	private String userName;
	private String userPassword;
	private String userEmail;
	private String userInfo;
	private byte[] headImg;
	private Date createTime;

	public SysUser(){
	}

	public Long getId(){
		return id;
	}

	public void setId(Long id){
		this.id = id;
	}

	public String getUserName(){
		return userName;
	}

	public void setUserName(String userName){
		this.userName = userName;
	}

	public String getUserPassword(){
		return userPassword;
	}

	public void setUserPassword(String userPassword){
		this.userPassword = userPassword;
	}

	public String getUserEmail(){
		return userEmail;
	}

	public void setUserEmail(String userEmail){
		this.userEmail = userEmail;
	}

	public String getUserInfo(){
		return userInfo;
	}

	public void setUserInfo(String userInfo){
		this.userInfo = userInfo;
	}

	public byte[] getHeadImg(){
		return headImg;
	}

	public void setHeadImg(byte[] headImg){
		this.headImg = headImg;
	}

	public Date getCreateTime(){
		return createTime;
	}

	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}

	@Override
	public String toString(){
		return "SysUser [id=" + id + ", userName=" + userName
				+ ", userPassword=" + userPassword + ", userEmail=" + userEmail
				+ ", userInfo=" + userInfo + ", headImg="
				+ Arrays.toString(headImg) + ", createTime=" + createTime + "]";
	}
	
	/**
	 * 新添加的，因为加入了新的字段，所以其实就应该为其添加新的模型。所以，需要新的字段加入
	 */
	
	/**
	 * 用户角色
	 */
	private SysRole role;
	public SysRole gerRole() {
		return role;
	}
	public void setRole(SysRole role){
		this.role=role;
	}
	public String toString2(){
		return "SysUser [id=" + id + ", userName=" + userName
				+ ", userPassword=" + userPassword + ", userEmail=" + userEmail
				+ ", userInfo=" + userInfo + ", headImg="
				+ Arrays.toString(headImg) + ", createTime=" + createTime
				+ ", role=" +role.getId()+role.getEnabled()+role.getRoleName()
				+role.getCreateBy()+role.getRoleName()+"]";
	}
}
```

Dao层：Mapper.xml文件

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
					"http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="tk.mybatis.simple.mapper.UserMapper">
	<!-- resultMap里面的id,和select之中的resultMap相同 -->
	<!-- resultMap里面的id需要时独一无二的 -->
	<resultMap id="userMap"
		type="tk.mybatis.simple.model.SysUser">
		<id property="id" column="id" />
		<result property="userName" column="user_name" />
		<result property="userPassword" column="user_password" />
		<result property="userEmail" column="user_email" />
		<result property="userInfo" column="user_info" />
		<result property="headImg" column="head_img" jdbcType="BLOB" />
		<result property="createTime" column="create_time"
			jdbcType="TIMESTAMP" />
	</resultMap>

	<!-- 新建的Mapper，这个如果写了就对应在resultMap定义和 使用的部分要对应起来 -->
	<!-- Could not find result map tk.mybatis.simple.mapper.UserMapper.UserMapper -->
	<resultMap id="UserMapper123"
		type="tk.mybatis.simple.model.SysUser">
		<id property="id" column="id" />
		<result property="userName" column="user_name" />
		<result property="userPassword" column="user_password" />
		<result property="userEmail" column="user_email" />
		<result property="userInfo" column="user_info" />
		<result property="headImg" column="head_img" jdbcType="BLOB" />
		<result property="createTime" column="create_time"
			jdbcType="TIMESTAMP" />
	</resultMap>
	<!--select之中的id和Mapper之中的方法名相同，#{id},就是类之中的方法的参数 -->
	<select id="selectById" resultMap="userMap">
		select * from sys_user where
		id=#{id}
	</select>


	<select id="selectAll"
		resultType="tk.mybatis.simple.model.SysUser">
		select id,
		user_name userName,
		user_password userPassword,
		user_email userEmail,
		user_info userInfo,
		head_img headImg,
		create_time
		createTime
		from sys_user
	</select>

	<!-- 现在看起来是，如果我们要的是单独的字段，就会要resultMap，而如果要的是对象，则完全可以不使用resultMap -->
	<select id="selectRolesByUserId"
		resultType="tk.mybatis.simple.model.SysRole">
		select r.id,
		r.role_name roleName,
		r.enabled,
		r.create_by
		createBy,
		r.create_time createTime
		from sys_user u
		inner join
		sys_user_role ur on u.id =
		ur.user_id
		inner join sys_role r on
		ur.role_id = r.id
		where u.id =
		#{userId}
	</select>


	<insert id="insert">
		insert into sys_user(
		id, user_name, user_password,
		user_email,
		user_info, head_img, create_time)
		values(
		#{id}, #{userName},
		#{userPassword}, #{userEmail},
		#{userInfo}, #{headImg, jdbcType=BLOB},
		#{createTime, jdbcType= TIMESTAMP})
	</insert>

	<insert id="insert2" useGeneratedKeys="true" keyProperty="id">
		insert
		into sys_user(
		id, user_name, user_password, user_email,
		user_info,
		head_img, create_time)
		values(
		#{id}, #{userName}, #{userPassword},
		#{userEmail},
		#{userInfo}, #{headImg, jdbcType=BLOB},
		#{createTime,
		jdbcType= TIMESTAMP})
	</insert>

	<update id="updateById">
		update sys_user
		set user_name=#{userName},
		user_password=#{userPassword},
		user_email=#{userEmail},
		user_info=#{userInfo},
		head_img=#{headImg,jdbcType=BLOB},
		create_time=#{createTime, jdbcType=TIMESTAMP}
		where id=#{id}
	</update>

	<delete id="deleteById">
		delete from sys_user where id=#{id}
	</delete>

	<!-- 多接口参数的情况 -->
	<select id="selectRolesByUserIdAndRoleEnabled"
		resultType="tk.mybatis.simple.model.SysRole">
		select
		r.id,
		r.role_name roleName,
		r.enabled,
		r.create_by
		createBy,
		r.create_time createTime
		from sys_user u
		inner join
		sys_user_role ur on u.id =
		ur.user_id
		inner join sys_role r on
		ur.role_id = r.id
		where u.id =
		#{userId} and r.enabled = #{enabled}
	</select>



	<!-- 使用动态sql查询，动态sql，其实就是结合ongl的sql语句，目前来看就是这样的 -->
	<!-- where 1=1,为了防止后面的动态条件为空 -->
	<select id="selectByUser"
		resultType="tk.mybatis.simple.model.SysUser">
		select id,
		user_name userName,
		user_password userPassword,
		user_email
		userEmail,
		user_info userInfo,
		head_img headImg,
		create_time createTime
		from sys_user
		where 1=1
		<if test="userName !=null and userName != '' ">
			and user_name like concat('%',#{userName},'%')
			<bind name="userNameLike" value=" '%' + userName + '%' " />
			and user_name like #{userNameLike}
			<!-- 上面是使用bind,来定义一个变量的操作 -->
			<!-- and user_name like concat('%',#{userName},'%') -->
		</if>
		<if test="userEmail !=null and userName !='' ">
			and user_email = #{userEmail}
		</if>
	</select>

	<!-- 一个是每个if语句内容之中最后有一个“,” 还有一个就是where之前的 id=#{id} -->
	<update id="updateByIdSelective">
		update sys_user
		set
		<if test="userName != null and userName !='' ">
			user_name=#{userName},
		</if>
		<if test="userPassword != null and userPassword !='' ">
			user_password=#{userPassword},
		</if>
		<if test="userEmail != null and userEmail !='' ">
			user_email=#{userEmail},
		</if>
		<if test="userInfo != null and userInfo !='' ">
			user_info=#{userInfo},
		</if>
		<if test="headImg != null">
			head_img=#{headImg, jdbcType=BLOB},
		</if>
		<if test="createTime != null ">
			create_time=#{createTime, jdbcType=TIMESTAMP},
		</if>
		id=#{id}
		where id = #{id}
	</update>



	<!-- alter table sys_user modify column user_email varchar(50) null default 
		"abc@test.com" comment "默认邮箱" after user_password; -->
	<!-- 首先执行上述语句，修改数据库的情况，然后有选择的插入，其中email有默认值，而userInfo为空值 -->
	<!-- <insert id="insert3" useGeneratedKeys="true" keyProperty＝ "工d">,后面的两个字段没有，但是仍然可以正常插入 -->
	<insert id="insert3">
		insert into sys_user(
		user_name,user_password,
		<if test="userEmail !=null and userEmail !=''">
			user_email,
		</if>
		<if test="userInfo == null or userInfo =='' ">
			user_info,
		</if>
		head_img, create_time)
		values(
		#{userName}, #{userPassword},
		<if test="userEmail !=null and userEmail !=''">
			#{userEmail},
		</if>
		<if test="userInfo == null or userInfo =='' ">
			#{userInfo},
		</if>
		#{headImg, jdbcType=BLOB}, #{createTime, jdbcType=TIMESTAMP})
	</insert>

	<select id="selectByIdOrUserName"
		resultType="tk.mybatis.simple.model.SysUser">
		select id,
		user_name userName,
		user_password userPassword,
		user_email
		userEmail,
		user_info userInfo,
		head_img headImg,
		create_time createTime
		from sys_user
		where 1=1
		<choose>
			<when test="id != null">
				and id=#{id}
			</when>
			<when test="userName != null and userName !='' ">
				<!-- 数据库字段user_name使用 Java对象字段userName来填充 -->
				and user_name =#{userName}
			</when>
			<otherwise>
				<!-- 作用就是不让查询到任何结果 -->
				and 1=2
			</otherwise>
		</choose>
	</select>

	<!-- 使用where标签字 -->
	<!-- 如果 if 条件满足， where 元素的内容就是以 and开头的条件， where 会自动去掉开头的 and，这也能保证 where条件正确 -->
	<select id="selectByUser1"
		resultType="tk.mybatis.simple.model.SysUser">
		select id,
		user_name userName,
		user_password userPassword,
		user_email
		userEmail,
		user_info userInfo
		from sys_user
		<where>
			<if test="userName != null and userName !='' ">
				<bind name="userLikeName" value=" '%' + userName + '%' " />
				and user_name like #{userLikeName}
			</if>
			<if test="userEmail !='' and userEmail != null ">
				and user_email = #{userEmail}
			</if>
		</where>
	</select>


	<!-- 使用set标签 -->
	<update id="updateByIdSelective1">
		update sys_user
		<set>
			<if test="userName  != null and userName  !='' ">
				user_name= #{userName},
			</if>
			<if test="userPassword  != null and userPassword  !='' ">
				user_password= #{userPassword},
			</if>
			<if test="userEmail  != null and userEmail  !='' ">
				user_email = #{userEmail},
			</if>
			<if test="userInfo  != null and userInfo !='' ">
				user_info = #{userInfo},
			</if>
			<if test="headImg  != null ">
				head_img = #{headImg, jdbcType=BLOB},
			</if>
			<if test="createTime  != null ">
				create_time = #{createTime, jdbcType=TIMESTAMP},
			</if>
			id = #{id},<!-- #和{需要靠在一起，不然会出错 -->
		</set>
		where id = #{id}
	</update>


	<!-- 使用for each来完成查询，得到一个集合 -->
	<select id="selectByIdList"
		resultType="tk.mybatis.simple.model.SysUser">
		select id,
		user_name userName,
		user_password userPassword,
		user_email
		userEmail,
		user_info userInfo,
		head_img headImg,
		create_time createTime
		from sys_user
		where id in
		<foreach collection="list" open="(" close=")" separator=","
			item="id" index="i">
			#{id}<!-- #和{}必须紧紧相连 -->
		</foreach>
	</select>


	<!-- 批量插入，使用for each来帮助 -->
	<insert id="insertList">
		insert into sys_user(
		user_name, user_password, user_email ,
		user_info,
		head_img, create_time)
		values
		<foreach collection="list" item="user" separator=","><!-- user是这个临时变量的名字 -->
			<!-- 括号，坚决不能忘记！！！否则出现语法错误！！！ -->
			(<!-- 括号，坚决不能忘记！！！否则出现语法错误！！！ -->
			#{user.userName}, #{user.userPassword},#{user.userEmail},
			#{user.userInfo}, #{user.headImg, jdbcType=BLOB},
			#{user.createTime,
			jdbcType=TIMESTAMP}
			)
		</foreach>
	</insert>

	<!-- 借助Sql语句进行分页 -->
	<select id="querySysUsersBySql0" parameterType="map"
		resultMap="userMap">
		select * from sys_user limit #{currIndex} , #{pageSize}
	</select>

	<!-- resultMap是 对一个Mapper文件，返回的结果或者对象的整体定义，一个Mapper文件有一个就可以了！ -->
	<!-- Mapper文件之中，有了resultMap之后，其就要写相应的sql语句，查询获取自己想要的结果！ -->
	<select id="querySysUsersBySql1" resultMap="userMap">
		select * from
		sys_user limit #{offset} ,#{limit}
	</select>

	<!-- 使用下面的语句是错误的，只能使用0,1占位符，使用map的时候可以直接key和value对应 -->
	<!-- 查询的占位符号是默认的，第一个是起始点，第二个每页的大小 -->
	<!-- select * from sys_user limit #{offset} ,#{limit} -->
	<select id="querySysUsersBySql2" resultMap="userMap">
		select * from
		sys_user limit #{0}, #{1}
	</select>

	<!-- 使用继承 ，新的方法-->
	<resultMap id="userRoleMap123" extends="userMap"
				type="tk.mybatis.simple.model.SysUser">
		<result property="role.id" column="role_id"/>
		<result property="role.roleName" column="role_name"/>
		<result property="role.enabled" column="enabled"/>
		<result property="role.createBy" column="create_by"/>
		<result property="role.createTime" column="role_create_time" jdbcType="TIMESTAMP"/>
	</resultMap>
	
	<select id="selectUserAndRoleId2" resultMap="userRoleMap123">
			select
				u.id,
				u.user_name,
				u.user_password,
				u.user_email,
				u.user_info,
				u.head_img,
				u.create_time,
				r.id role_id,
				r.role_name,
				r.enabled enabled,
				r.create_by create_by,
				r.create_time role_create_time
			from sys_user u
			inner join sys_user_role ur on u.id=ur.user_id
			inner join sys_role r on ur.role_id=r.id
			where u.id= #{id}
	</select>
	
	<select id="selectUserAndRoleId3" resultMap="userRoleMap123">
			select
				u.id,
				u.user_name,
				u.user_password,
				u.user_email,
				u.user_info,
				u.head_img,
				u.create_time,
				r.id "role.id",
				r.role_name "role.roleName",
				r.enabled "role.enabled",
				r.create_by "role.createBy",
				r.create_time "role.createTime"
			from sys_user u
			inner join sys_user_role ur on u.id=ur.user_id
			inner join sys_role r on ur.role_id=r.id
			where u.id= #{id}
	</select>

</mapper>
```

Dao层：

```java
package tk.mybatis.simple.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import tk.mybatis.simple.model.SysRole;
import tk.mybatis.simple.model.SysUser;

/**
 * 参数的情况如下： 1:基本类型，只有一个基本类型的参数，如Interger id
 * 2:JavaBean，一般是同属于一个类的参数，虽然有多个内部的参数，但是可以使用一个java bean来封装成一个参数
 * 3:多个接口参数，一般是多个类之中的不同字段，组成参数的列表，这时候就需要使用多接口参数的情况，一般使用@Param注解操作
 * 
 * @author prayjourney
 *
 */
public interface UserMapper{
	SysUser selectById(Long id);

	List<SysUser> selectAll();

	List<SysRole> selectRolesByUserId(Long userId);

	int insert(SysUser sysUser);// 主键不回写

	int insert2(SysUser sysUser);// 主键回写

	int updateById(SysUser sysUser);// 更新

	int deleteById(Long id);// 删除

	// 相当于在下面的参数之中，使用@Param注解，来命名了一个参数的变量，在mapper.xml文件之中，使得其中的sql语句认识
    // 多个接口参数的方法，主要是针对的多张表之中的不同字段，组成的字段的情况
	List<SysRole> selectRolesByUserIdAndRoleEnabled(
			@Param("userId") Long userId, @Param("enabled") Integer enabled);
    
	// 使用动态sql查询，动态sql，其实就是结合ongl的sql语句，目前来看就是这样的
	List<SysUser> selectByUser(SysUser sysUser);

	// 根据主键史新
	int updateByIdSelective(SysUser sysUser);

	// 使用默认值，结合动态sql，插入数值
	int insert3(SysUser sysUser);

	// 使用choose
	SysUser selectByIdOrUserName(SysUser sysUser);

	// 使用where
	SysUser selectByUser1(SysUser sysUser);

	// 使用set标签
	int updateByIdSelective1(SysUser sysUser);

	// 测试for each
	List<SysUser> selectByIdList(List<Long> idList);

	// 使用for each完成批量插入
	int insertList(List<SysUser> userList);

	// 借助Sql语句进行分页，使用注解的方式不成功，在此处，使用下面的方式来完成分页
    // @Select("SELECT * FROM sys_user where limit=#{limit} AND offset=#{offset}")
    // List<SysUser> querySysUsersBySql0(@Param("limit") int limit,@Param("offset") int offset);
	
	// 借助Sql语句进行分页
	List<SysUser> querySysUsersBySql1(Map<String,Object> map);
	
	// 借助Sql语句进行分页
	List<SysUser> querySysUsersBySql2(int offset,int limit);
	
	//extends resultMap
	SysUser selectUserAndRoleId2(Long id);
	
	SysUser selectUserAndRoleId3(Long id);
	
}
```

使用Junit测试Mybatis的执行

```java
package tk.mybatis.simple.mapper;

import static org.junit.Assert.assertNull;

import java.io.IOException;
import java.io.Reader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.BeforeClass;
import org.junit.Test;

import junit.framework.Assert;
import tk.mybatis.simple.model.Country;
import tk.mybatis.simple.model.SysRole;
import tk.mybatis.simple.model.SysUser;
import tk.mybatis.simple.service.impl.UserServiceImpl;

public class UserMapperTest extends BaseMapperTest{

	@Test
	public void testSelectById(){
		// 获取 sqlSession
		SqlSession sqlSession = getSqlSession();
		try{
			// 获取 UserMapper接口
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			// 调用 selectById方法，查询 id=1的用户
			SysUser user = userMapper.selectById(1l);
			// user不为空
			Assert.assertNotNull(user);
			// userName = admin
			Assert.assertEquals("admin", user.getUserName());
		} finally{
			sqlSession.close();
		}
	}

	@Test
	public void testSelectAll(){
		SqlSession session = getSqlSession();
		// try可以和finally一起使用，而不去使用catch!
		try{
			UserMapper user = session.getMapper(UserMapper.class);
			// 查詢所有的用戶
			List<SysUser> userList = user.selectAll();
			// 结果不为空
			Assert.assertNotNull(userList);
			// 用户数量大于0
			Assert.assertTrue(userList.size() > 0);
			System.out.println(userList.get(0).getUserName());
		} finally{
			// 不妥忘记关闭 session
			session.close();
		}
	}

	@Test
	public void testSelectRolesByUserId(){
		SqlSession session = getSqlSession();
		// try可以和finally一起使用，而不去使用catch!
		try{
			UserMapper user = session.getMapper(UserMapper.class);
			// 查詢所有的用戶
			List<SysRole> rolesList = user.selectRolesByUserId(1l);
			// 结果不为空
			Assert.assertNotNull(rolesList);
			// 用户数量大于0
			Assert.assertTrue(rolesList.size() > 0);
			System.out.println(rolesList.get(0).getRoleName());
		} finally{
			// 不妥忘记关闭 session
			session.close();
		}
	}

	@Test
	public void testInsert(){
		// 没有返回对象的id,所以测试id为空
		SqlSession session = getSqlSession();
		try{
			UserMapper userMapper = session.getMapper(UserMapper.class);
			// 创建一个对象
			SysUser sysUser = new SysUser();
			sysUser.setUserName("ccvv");
			sysUser.setUserPassword("123456");
			sysUser.setUserEmail("test@mybatis.tk");
			sysUser.setUserInfo("test info");
			// 正常情况下应该读入一张图片存到 byte 数纽中
			sysUser.setHeadImg(new byte[] { 1, 2, 3 });
			sysUser.setCreateTime(new Date());
			// 将新建的对象插入数据库中，特别注意这里的返回值 result 是执行的 SQL 影响的行数
			int result = userMapper.insert(sysUser);
			// 只插入1条数据
			Assert.assertEquals(1, result);
			// id 为 null ，没有给 id 赋佳，并且没有配直回写 id 的值
			System.out.println(sysUser.getId());// 主键不回写
			Assert.assertNull(sysUser.getId());

		} finally{
			// 为了不影响其他测试，这里选择回滚
			// 由于默认的 sqlSessionFactory.openSession()是不自动提交的
			// 因此不手动执行 commit 也不会提交到数据库
			// session.rollback();
			session.commit();
			// 不妥忘记关闭 session
			session.close();
		}
	}

	@Test
	public void testInsert2() throws ParseException{
		// 设置了返回对象的id,所以测试id为其本身的主键
		SqlSession session2 = getSqlSession();
		UserMapper userMapper = session2.getMapper(UserMapper.class);
		SysUser sysUser2 = new SysUser();
		sysUser2.setUserName("张三");
		sysUser2.setUserPassword("pwd123456");
		sysUser2.setUserInfo("张三是谁呢？你知道吗");
		sysUser2.setUserEmail("zhangs@126.com");
		sysUser2.setHeadImg(new byte[] { 1, 2, 3 });
		String sdate = "2010-09-12";
		SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY-MM-DD");
		Date d1 = sdf1.parse(sdate);
		sysUser2.setCreateTime(d1);

		int result2 = userMapper.insert2(sysUser2);
		session2.commit();
		System.out.println(sysUser2.getId());// 主键回写
		System.out.println(result2);
		session2.close();
	}

	@Test
	public void testUpdateById() throws ParseException{
		SqlSession session3 = getSqlSession();
		try{
			UserMapper userMapper = session3.getMapper(UserMapper.class);
			SysUser sysUser3 = userMapper.selectById(1009l);// 获取一个对象
			sysUser3.setUserName("王麻子");
			sysUser3.setUserPassword("王麻子123456");
			sysUser3.setUserInfo("...");
			sysUser3.setUserEmail("mz@gmail.com");
			sysUser3.setHeadImg(new byte[] { 11, 2, 3 });
			String sdate = "2013-05-09";
			SimpleDateFormat sdf1 = new SimpleDateFormat("YYYY-MM-DD");
			Date d1 = sdf1.parse(sdate);
			sysUser3.setCreateTime(d1);

			int result3 = userMapper.updateById(sysUser3);// 返回的是受影响的行数
			Assert.assertEquals(true, result3 == 1);
			session3.commit();
			System.out.println(sysUser3.getId());
			System.out.println(result3);

		} finally{
			session3.close();
		}
	}

	@Test
	public void testDeleteById(){
		SqlSession sqlSession1 = getSqlSession();
		try{
			UserMapper userMapper1 = sqlSession1.getMapper(UserMapper.class);
			SysUser sUser = userMapper1.selectById(1033l);
			Assert.assertNotNull(sUser);
			int result3 = userMapper1.deleteById(1033l);
			System.out.println(result3);
			sqlSession1.commit();
			SysUser sUser2 = userMapper1.selectById(1033l);
			Assert.assertNull(sUser2);
		} finally{
			sqlSession1.close();
		}
	}

	@Test
	public void testSelectRolesByUserIdAndRoleEnabled(){
		SqlSession sqlSession2 = getSqlSession();
		try{
			UserMapper userMapper2 = sqlSession2.getMapper(UserMapper.class);
			// 调用 selectRolesByUseridAndRoleEnabled 方法查询用户的角色
			List<SysRole> userList = userMapper2
					.selectRolesByUserIdAndRoleEnabled(1l, 1);
			Assert.assertNotNull(userList);
			Assert.assertTrue(userList.size() > 0);
		} finally{
			sqlSession2.close();
		}
	}

	@Test
	public void testSelectByUser(){
		SqlSession sqlSession = getSqlSession();
		try{
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			// 只查询用户名时
			SysUser query = new SysUser();
			query.setUserName("test");
			List<SysUser> userList = userMapper.selectByUser(query);
			Assert.assertTrue(userList.size() > 0);
			// 只查询用户邮箱时
			query = new SysUser();
			query.setUserEmail("test@mybatis.tk");
			userList = userMapper.selectByUser(query);
			Assert.assertTrue(userList.size() > 0);
			// 当同时查询用户名和邮箱时
			query = new SysUser();
			query.setUserName("ad");
			query.setUserEmail("test@mybatis.tk");
			userList = userMapper.selectByUser(query);
			// 由于没有同时符合这两个条件的用户 ，因此查询结采数为 0
			Assert.assertTrue(userList.size() == 0);
		} finally{
			sqlSession.close();
		}
	}

	@Test
	public void testUpdateByIdSelective(){
		SqlSession sqlSession = getSqlSession();
		try{
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			SysUser sUser = new SysUser();
			sUser.setId(1002l);
			sUser.setUserName("张三123");
			sUser.setUserPassword("mt12345");
			int result = userMapper.updateByIdSelective(sUser);
			Assert.assertEquals(1, result);
			Assert.assertEquals("张三123", sUser.getUserName());
			sqlSession.commit();
		} finally{
			sqlSession.close();
		}
	}

	@Test
	public void testInsert3(){
		SqlSession sqlSession1 = getSqlSession();
		try{
			UserMapper userMap = sqlSession1.getMapper(UserMapper.class);
			SysUser user = new SysUser();
			user.setUserName("uiaosdusao!");
			user.setUserPassword("ortetfds");
			// 此处无Email,Info了，采用了默认的值，还有就是id,使用了自增的数据
			user.setHeadImg(new byte[] { 112, 122, 123, 84 });
			user.setCreateTime(new Date());
			userMap.insert3(user);
			Assert.assertEquals("uiaosdusao!", user.getUserName());
			sqlSession1.commit();
		} finally{
			sqlSession1.close();
		}
	}

	@Test
	public void testSelectByIdOrUserName(){
		SqlSession sqlSession1 = getSqlSession();
		try{
			UserMapper uMapper = sqlSession1.getMapper(UserMapper.class);
			// 只查name时
			SysUser query1 = new SysUser();
			query1.setId(1l);
			query1.setUserName("admin");
			SysUser s1 = uMapper.selectByIdOrUserName(query1);
			Assert.assertNotNull(s1);
			// 没有id时
			query1.setId(null);
			s1 = uMapper.selectByIdOrUserName(query1);
			// Assert.assertNotNull(s1);
			// 当id和name都为空时
			query1.setUserName(null);
			s1 = uMapper.selectByIdOrUserName(query1);
			// Assert.assertNull(s1);
		} finally{
			sqlSession1.close();
		}
	}

	@Test
	public void testSelectByUser1(){
		SqlSession sqlSession = getSqlSession();
		try{
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			// 只查询用户名时
			SysUser query = new SysUser();
			query.setUserName("test");
			SysUser sysUser1 = userMapper.selectByUser1(query);
			Assert.assertNotNull(sysUser1);
		} finally{
			sqlSession.close();
		}
	}

	@Test
	public void testUpdateByIdSelective1(){
		SqlSession sqlSession3 = getSqlSession();
		try{
			UserMapper userMap = sqlSession3.getMapper(UserMapper.class);
			SysUser user = new SysUser();
			user.setId(1002l);
			user.setUserName("123mgeeeee!");
			user.setUserPassword("1323");
			user.setUserEmail("wewre@qq.com");
			// 此处无Email,Info了，采用了默认的值，还有就是id,使用了自增的数据
			user.setHeadImg(new byte[] { 112, 122, 123, 84 });
			userMap.updateByIdSelective1(user);
			Assert.assertEquals("123mgeeeee!", user.getUserName());
			sqlSession3.commit();
		} finally{
			sqlSession3.close();
		}
	}

	// 测试foreach
	@Test
	public void testSelectByIdList(){
		SqlSession sqlSession3 = getSqlSession();
		try{
			UserMapper userMap = sqlSession3.getMapper(UserMapper.class);
			List<Long> idList = new ArrayList<Long>();
			idList.add(1l);
			idList.add(1002l);
			idList.add(1008l);
			// 业务逻辑中必须校验idList.size() > 0
			List<SysUser> userList = userMap.selectByIdList(idList);
			Assert.assertEquals(3, userList.size());
			System.out.println(userList.get(2).toString());
		} finally{
			sqlSession3.close();
		}
	}

	// 测试foreach
	@Test
	public void testInsertList(){
		SqlSession sqlSession22 = getSqlSession();
		try{
			UserMapper userMap = sqlSession22.getMapper(UserMapper.class);
			List<SysUser> listUser = new ArrayList<SysUser>();
			for (int i = 0; i < 6; i++){
				SysUser userTemp = new SysUser();
				userTemp.setUserName("test" + i);
				userTemp.setUserPassword("123456");
				userTemp.setUserEmail("test@mybatis.tk");
				userTemp.setUserInfo((String.valueOf("info---" + i)));
				userTemp.setHeadImg(new byte[] { 10, 80, 90, 100 });
				userTemp.setCreateTime(new Date());
				listUser.add(userTemp);
			}
			int result22 = userMap.insertList(listUser);
			Assert.assertEquals(6, result22);
			Assert.assertEquals("test2", listUser.get(2).getUserName());
			System.out.println(listUser.get(2).toString());
			sqlSession22.commit();
		} finally{
			sqlSession22.close();
		}
	}

	// 注解，添加service层的方式，实践不成功
	@Test
	public void testQuerySysUsersBySql(int limit, int offset){
		SqlSession sqlSession123 = getSqlSession();
		UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		UserServiceImpl userServiceImpl = new UserServiceImpl();
		userServiceImpl.querySysUsersBySql(10, 1);
		userMap.querySysUsersBySql(10, 1);
	}

	// 1、用@Test注解的方法必须没有返回值，返回值类型无：void
	// 2、用@Test注解的方法必须没有入参。
	/**
	 * 错误信息：java.lang.Exception: Method testQuerySysUserBySql123 should have
	 no parameters
	 * 也就是说要方法没入参，方法无返回值
	 * @param limit
	 * @param offset
	 */
	 public void testQuerySysUserBySql123(int limit, int offset){
		 Map<String, Object> map = new HashMap<String, Object>();
		 SqlSession sqlSession123 = getSqlSession();
		 UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		 map.put("start", 0);
		 map.put("pagesize", 4);
		 List<SysUser> list = userMap.querySysUsersBySql123(map);
		 for (SysUser s : list)
		 {
		 System.out.println(s.toString());
		 }
	 }

	@Test
	public void testQuerySysUserBySql1(){
		Map<String, Object> map = new HashMap<String, Object>();
		SqlSession sqlSession123 = getSqlSession();
		UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		map.put("offset", 0);
		map.put("limit", 5);

		List<SysUser> list = userMap.querySysUsersBySql1(map);
		Assert.assertEquals(5, list.size());
		for (SysUser s : list){
			System.out.println(s.toString());
		}
	}

	@Test
	public void testQuerySysUserBySql2(){
		SqlSession sqlSession123 = getSqlSession();
		UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		int offset = 0;
		int limit = 3;
		// 查询的占位符号是默认的，第一个是起始点，第二个每页的大小
		List<SysUser> list = userMap.querySysUsersBySql2(offset, limit);
		Assert.assertEquals(3, list.size());
		for (SysUser s : list){
			System.out.println(s.toString());
		}
	}

	@Test
	public void testSelectUserAndRoleId2(){
		SqlSession sqlSession123 = getSqlSession();
		UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		SysUser sUser = userMap.selectUserAndRoleId2((long) 1);
		Assert.assertNotNull(sUser);
		System.out.println(sUser.toString2());
		System.out.println(sUser);
		System.out.println(sUser.gerRole());
		// 为何没有取到Role部分的值呢？---》没有完全创建新的对应的model
	}

	@Test
	public void testSelectUserAndRoleId3(){
		SqlSession sqlSession123 = getSqlSession();
		UserMapper userMap = sqlSession123.getMapper(UserMapper.class);
		SysUser sUser = userMap.selectUserAndRoleId3((long) 1060);
		Assert.assertNotNull(sUser);
		System.out.println(sUser);
		System.out.println(sUser.gerRole());
	}
}

```



#### 使用注解方式的mybatis操作

使用注解的方式使用mybatis的时候，仍然是首先要建立起来domain层，然后在dao层实现mybatis对于数据库的操作，使用注解的方式的时候，mybatis的**操作语句**和定义的**sql操作方法**(很多是增删改查)是写在同一个文件之中，**由于使用了动态代理，所以定义的是一个接口**，一般是以XXXMapper来命名，接口使用@Mapper注解来标明，对于相应的方法，定义和普通方法没有区别，唯一的区别在于，其上需要写明@Insert, @Select, @Delete, @Update等语句，**在注解后面，需要写上需要执行的sql语句**，在定义的方法之中，需要指明对应的参数，一般是使用@Param参数，而在@Param参数之中的参数，需要和在SQL语句之中表明的where参数对应的名字一致。

Domain层：WishList

```java
public class WishList{
    /**
     * 主键
     */
    private Long id;
    /**
     * 用户ID
     */
    private Long userId;
    /**
     * 商品ID
     */
    private Long itemId;
    /**
     * 添加时价格
     */
    private Integer addPrice;
    /**
     * 添加时间
     */
    private Integer addTime;
    /**
     * 创建时间
     */
    private Integer created;
    /**
     * 创建价格
     */
    private Integer updated;

    public WishList(){
    }
    
    public Long getId(){
        return id;
    }
    public void setId(Long id){
        this.id = id;
    }

    public Long getUserId(){
        return userId;
    }

    public void setUserId(Long userId){
        this.userId = userId;
    }

    public Long getItemId(){
        return itemId;
    }

    public void setItemId(Long itemId){
        this.itemId = itemId;
    }

    public Integer getAddPrice(){
        return addPrice;
    }

    public void setAddPrice(Integer addPrice){
        this.addPrice = addPrice;
    }

    public Integer getAddTime(){
        return addTime;
    }

    public void setAddTime(Integer addTime){
        this.addTime = addTime;
    }

    public Integer getCreated(){
        return created;
    }

    public void setCreated(Integer created){
        this.created = created;
    }

    public Integer getUpdated(){
        return updated;
    }

    public void setUpdated(Integer updated){
        this.updated = updated;
    }
}
```
DAO层：Mapper接口
```java
package com.yjf.dao.wishlist;


import com.yjf.domain.wishlist.WishList;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface WishListMapper {

    /**
     * 添加商品到收藏，并且获得收藏的主键id
     *
     * @param userId
     * @param itemId
     * @param addPrice
     * @param addTime
     * @param created
     * @param updated
     * @return
     */
    //返回受影响的行数
    //@Insert("INSERT INTO user_collection_info(user_id, item_id, add_price, add_time, created, updated) VALUES(#{a}, #{itemId}, #{addPrice}, #{addTime}, #{created}, #{updated})")
    //int addWishListItem(@Param("a") long userId, @Param("itemId") long itemId, @Param("addPrice") int addPrice, @Param("addTime") int addTime, @Param("created") long created, @Param("updated") long updated);

    //返回主键，按照如此方式，有点问题--->需要使用对象的方式，然后再getId()即可
    //@Insert("INSERT INTO user_collection_info(user_id, item_id, add_price, add_time, created, updated) VALUES(#{a}, #{itemId}, #{addPrice}, #{addTime}, #{created}, #{updated})")
    //@Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    //long addWishListItem(@Param("a") long userId, @Param("itemId") long itemId, @Param("addPrice") int addPrice,@Param("addTime") int addTime, @Param("created") long created, @Param("updated") long updated);

    //这样才可以获取Id主键
    @Insert("INSERT INTO user_collection_info(user_id, item_id, add_price, add_time, created, updated) VALUES(#{userId}, #{itemId}, #{addPrice}, #{addTime}, #{created}, #{updated})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    long addWishListItem(WishList wishList);


    /**
     * 通过商品id，获取收藏此商品的收藏对象集合
     *
     * @param itemId
     * @return
     */
    @Select("SELECT id, user_id, item_id, add_price, add_time, created, updated FROM user_collection_info WHERE user_id= #{userId} AND item_id= #{itemId, jdbcType=BIGINT}")
    List<WishList> getWishListItemByItemId(@Param("userId") long userId, @Param("itemId") long itemId);
    //Param后的字段和#之中的内容对应，select选择的是数据库之中的字段，后面的itemId可以自由命名


    /**
     * 通过商品id获取收藏id
     *
     * @param itemId
     * @return
     */
    @Select("SELECT id from user_collection_info WHERE user_id=#{userId, jdbcType=BIGINT} AND item_id =#{itemId, jdbcType=BIGINT}")
    long getMarkIdByGoodsId(@Param("userId") long userId, @Param("itemId") long itemId);


    /**
     * 删除一个收藏商品
     *
     * @param userId
     * @param itemId
     * @return
     */
    //此处使用用户id和商品id删除一个不重复的收藏商品
    @Delete("delete from user_collection_info where user_id=#{userId} AND item_id = #{itemId}")
    int removeOneWishListItem(@Param("userId") Long userId, @Param("itemId") Long itemId);


    /**
     * 删除多个收藏商品
     *
     * @param idLists
     * @return
     */
    //item_id商品id, id收藏夹列表id, 用哪一个执行删除操作，要考虑清楚，常常导致执行正确，但是结果为0的情况
    @Delete("<script>delete from user_collection_info where user_id= #{userId} AND item_id in "
            + "<foreach collection='array' item='itemId' index='index' open='(' separator=',' close=')'>"
            + "#{itemId} "
            + "</foreach>"
            + "</script>")
    int removeWishListItemsByIdLists(@Param("userId") long userId, @Param("array") List<Long> idLists);
    //使用foreach动态sql删除多条的数据


    /**
     * 查询收藏的所有商品
     *
     * @return
     */
    @Select("SELECT id, user_id, item_id, add_price, add_time, created, updated FROM user_collection_info")
    List<WishList> getWishListAllItems();


    /**
     * 查询收藏的商品，使用分页
     *
     * @param userId
     * @param limit
     * @param offset
     * @return
     */
    @Select("SELECT id, user_id, item_id, add_price, add_time, created, updated FROM user_collection_info WHERE user_id = #{userId} ORDER BY created DESC LIMIT #{offset},#{limit}")
    List<WishList> getWishListByLimit(@Param("userId") long userId, @Param("limit") int limit, @Param("offset") int offset);

}
```

Service层：WishListService

```java
@Service
@Slf4j
public class WishListService{
    /**
     * 添加商品到收藏
     * @param userId
     * @param itemId
     * @param addPrice
     * @return
     */
    public long addWishListItem(long userId, long itemId, int addPrice)
    {
        List<WishList> l = wishListMapper.getWishListItemByItemId(itemId);
        //如果商品不在列表之中，则加入，如果在，则返回
        if (l.size() >= 1){
            return -1l;
        } else{
            int addtime = TimeUtils.now();
            WishList  wishList=new WishList();
            wishList.setUserId(userId);
            wishList.setItemId(itemId);
            wishList.setAddPrice(addPrice);
            wishList.setAddTime(addtime);
            wishList.setCreated(addtime);
            wishList.setUpdated(addtime);
            long insertInfo= wishListMapper.addWishListItem(wishList);
            long result=wishList.getId();
            return result;
        }
    }

    /**
     * 查询收藏的某一个商品，通过商品id
     * @param itemId
     * @return
     */
    public List<WishList> getWishListItemByItemId(Long itemId){
        List<WishList> l = wishListMapper.getWishListItemByItemId(itemId);
        return l;
    }


    /**
     * 通过商品id获取收藏id
     * @param itemId
     * @return
     */
    public int getMarkIdByGoodsId(Long itemId){
        int result = wishListMapper.getMarkIdByGoodsId(itemId);
        return result;
    }

    /**
     * 删除一个收藏的商品
     * @param id
     * @return
     */
    public int removeOneWishListItem(Long id){
        /*
         * try catch包住的是异常处理的内容
         * 异常信息一般需要打印在日志之中，将异常的堆栈信息打出，然后将id,userId等关键信息打出来
         * 此处日志使用的是logback，日志需要对应级别查看，有error,debug,info等
         */
        try{
            int resullt = wishListMapper.removeOneWishListItem(id);
            return resullt;
        }catch (Exception e){
            log.error("itemId:{}",id, e);
            return -1;
        }
    }

    /**
     * 删除多个收藏的商品
     * @param lists
     * @return
     */
    public int removeWishListItemsByIdLists(String lists){
        ArrayList<Long> idLists = getList(lists);
        int result = wishListMapper.removeWishListItemsByIdLists(idLists);
        return result;
    }

    /**
     * 将url之中传入的string转化成list
     * @param id
     * @return
     */
    public ArrayList<Long> getList(String id){
        ArrayList<Long> list = new ArrayList<Long>();
        String[] str = id.split(",");
        for (int i = 0; i < str.length; i++){
            list.add(Long.valueOf(str[i]));
        }
        return list;
    }


    /**
     * 查询收藏的所有商品
     * @return
     */
    public List<WishList> getWishListAllItems(){
        List<WishList> l = wishListMapper.getWishListAllItems();
        return l;
    }

    //查询收藏的商品，使用分页
    public List<WishList> getWishListByLimit(Long userId, Integer limit, Integer offset){
        return wishListMapper.getWishListByLimit(userId, limit, offset);
    }

}
```

Controller层：

```java
@RestController
@RequestMapping("wishlist")
@Slf4j
public class WishListController
{
    private int NOTINCOLLECTION = -1;

    private int HAVEMANY = -2;
    @Autowired
    private WishListService wishListService;

    @Autowired
    private WishListDetailInfoService wishListDetailInfoService;

    /**
     * 添加商品到收藏
     *
     * @param userId
     * @param goodsId
     * @param goodsPrice
     * @return
     */
    @RequestMapping(value = "/insertMark", method = RequestMethod.POST)
    @ResponseBody
    @Auth
    public YjfJsonResult insertMark(long userId, long goodsId, int goodsPrice){
        // 测试使用的假数据，本地代码之中直接定义死itemId = 2L;userId = 3L;
        // 在url之中赋值，获得同等的效应，并且参数可以变换
        // wishlist/addWishListItem?userId=2&goodsId=3&goodsPrice=4

        long result = wishListService.addWishListItem(userId, goodsId, goodsPrice);
        HashMap<String, Object> map = new HashMap<>();
        map.put("markId", result);
        JSONObject jsonObject = new JSONObject(map);
        if (result == HAVEMANY){
            log.warn("商品已经在收藏列表之中! userId:{}, goodsId:{}, goodsPrice:{}", userId, goodsId, goodsPrice);
            return YjfJsonResult.builder().code(ResultCode.ITEM_ALREADY_IN_WISHLIST.val())
                    .message(ResultCode.ITEM_ALREADY_IN_WISHLIST.msg()).result(jsonObject).build();
        } else{
            return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg())
                    .result(jsonObject).build();
        }
    }


    /**
     * 通过商品id，获取收藏此商品的收藏对象集合
     *
     * @param itemId
     * @return
     */
    @RequestMapping(value = "/getWishListItemByItemId", method = RequestMethod.GET)
    @ResponseBody
    @Auth
    public YjfJsonResult getWishListItemByItemId(long userId, long itemId){
        List<WishList> tempItem = wishListService.getWishListItemByItemId(userId, itemId);
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(tempItem)
                .build();
    }


    /**
     * 通过商品id获取收藏id
     *
     * @param goodsId
     * @return
     */
    @RequestMapping(value = "getMarkIdByGoodsId", method = RequestMethod.GET)
    @ResponseBody
    @Auth
    public YjfJsonResult getMarkIdByGoodsId(long userId, Long goodsId){
        // 这个是本地测试使用的假数据
        // goodsId = 1l;goodsId直接在url参数之中获取即可，效果是等同的，由于spring已经封装好了，
        // 不用自己使用HttpRequest request之中获取想要的参数，而是直接在URL之中获取
        // 在URL之中获取的时候，一般而言，需要使得的函数参数和URL参数书写在大小写下划线等方面一致
        if (goodsId == null){
            log.warn(" userId:{} goodsId is null", userId);
            return YjfJsonResult.builder().code(ResultCode.ITEMS_NOT_EXIST.val())
                    .message(ResultCode.ITEMS_NOT_EXIST.msg()).result("").build();
        }

        long result = wishListService.getMarkIdByGoodsId(userId, goodsId);
        HashMap<String, Object> jsonMap = new HashMap<>();//使用fastjson将结果封装
        if (result == NOTINCOLLECTION){
            jsonMap.put("markId", "");//null或者""
            JSONObject json = new JSONObject(jsonMap);
            return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(json)
                    .build();
        } else if (result == HAVEMANY){
            jsonMap.put("markId", result);
            JSONObject json = new JSONObject(jsonMap);
            log.warn("同一件商品在收藏列表之中有多个! userId:{}, goodsId:{}", userId, goodsId);
            return YjfJsonResult.builder().code(ResultCode.ITEM_HAVE_MANY_IN_WISHLIST.val())
                    .message(ResultCode.ITEM_HAVE_MANY_IN_WISHLIST.msg()).result(json).build();
        } else{
            jsonMap.put("markId", result);
            JSONObject json = new JSONObject(jsonMap);
            return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(json)
                    .build();
        }
    }


    /**
     * 删除一个收藏的商品
     *
     * @param itemId
     * @return
     */
    @RequestMapping(value = "removeOneWishListItem", method = RequestMethod.POST)
    @ResponseBody
    @Auth
    public YjfJsonResult removeOneWishListItem(Long userId, Long itemId){
        int result = wishListService.removeOneWishListItem(userId, itemId);
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(result)
                .build();
    }


    /**
     * 删除多个收藏的商品
     *
     * @param list
     * @return
     */
    @RequestMapping(value = "delMarks", method = RequestMethod.POST)
    @ResponseBody
    @Auth
    public YjfJsonResult delMarks(long userId, String list){
        //测试使用的假数据，//idLists.add(6l); //idLists.add(7l);
        //参数检查
        list = StringUtils.trim(list);
        if (StringUtils.isEmpty(list))
        {
            log.error("参数列表为空!, list:{}", list);
            return YjfJsonResult.builder().code(ResultCode.PARAMS_ERROR.val()).message(ResultCode.PARAMS_ERROR.msg())
                    .build();
        }
        int result = wishListService.removeWishListItemsByIdLists(userId, list);
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(result)
                .build();
    }


    /**
     * 查询收藏的所有商品
     *
     * @return
     */
    @RequestMapping(value = "/getWishListAllItems", method = RequestMethod.GET)
    @ResponseBody
    @Auth
    public YjfJsonResult getWishListAllItems(){
        List<WishList> tempList = wishListService.getWishListAllItems();
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(tempList)
                .build();
    }


    /**
     * 查询简易的收藏商品的信息，使用分页
     *
     * @param userId
     * @param pageSize
     * @param pageStart
     * @return
     */
    @RequestMapping(value = "getMarkList123", method = RequestMethod.GET)
    @ResponseBody
    @Auth
    public YjfJsonResult getMarkList123(int userId, int pageSize, int pageStart){
        if (pageSize < 0 || pageStart < 0 || userId < 0)
        {
            log.warn("参数不符合要求! pageSize:{}, pageStart:{}, userId:{}", pageSize, pageStart, userId);
            return YjfJsonResult.builder().code(ResultCode.PARAMS_ERROR.val()).message(ResultCode.PARAMS_ERROR.msg())
                    .build();
        }
        List<WishList> list2 = wishListService.getWishListByLimit(userId, pageSize, pageStart);
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg()).result(list2)
                .build();
    }


    /**
     * 查询详细的的收藏商品的信息，包括商品名，ID，地区等信息，使用分页
     *
     * @param userId
     * @param pageSize
     * @param pageStart
     * @return
     * @throws ExecutionException
     * @throws InterruptedException
     */
    @RequestMapping(value = "getMarkList", method = RequestMethod.GET)
    @ResponseBody
    @Auth
    public YjfJsonResult getMarkList(long userId, int pageSize, int pageStart) throws ExecutionException,
            InterruptedException{
        if (userId < 0 || pageSize < 0 || pageStart < 0)
        {
            log.warn("参数不符合要求! pageSize:{}, pageStart:{}, userId:{}", pageSize, pageStart, userId);
            return YjfJsonResult.builder().code(ResultCode.PARAMS_ERROR.val()).message(ResultCode.PARAMS_ERROR.msg())
                    .build();
        }
        List<WishListDetailInfo> infoDetail = wishListDetailInfoService
                .getItemInfoModelDetail(userId, pageSize, pageStart);
        return YjfJsonResult.builder().code(ResultCode.SUCCESS.val()).message(ResultCode.SUCCESS.msg())
                .result(infoDetail).build();
    }
}
```

从上到下，就完成了调用的操作，而Mybatis只是扮演了SQL的操作，提供了相关方法，为Service使用。



#### XML和注解方式的区别

可以看出，使用XML配置的方式比使用注解要复杂，但是更加基础，而且使用XML方式支持的功能更多，而使用注解的方式支持的功能尚未完全覆盖到所有的功能，仍然在持续完善之中，一般，现在比较多使用注解的方式，这样比较简介，而且在同一个文件之中，更加方便调试，推荐这种方法。




#### Mybatis的配置





