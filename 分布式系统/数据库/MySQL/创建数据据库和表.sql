-- 导出 aboutstudent 的数据库结构
CREATE DATABASE IF NOT EXISTS `aboutstudent` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `aboutstudent`;

-- 导出  表 aboutstudent.course 结构
CREATE TABLE IF NOT EXISTS `course` (
  `cno` varchar(5) NOT NULL COMMENT '课程号',
  `cname` varchar(10) NOT NULL COMMENT '课程名',
  `tno` varchar(10) NOT NULL COMMENT '任课老师'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程';


-- 导出  表 aboutstudent.score 结构
CREATE TABLE IF NOT EXISTS `score` (
  `sno` varchar(3) NOT NULL COMMENT '学号',
  `cno` varchar(5) NOT NULL COMMENT '课程号',
  `degree` decimal(10,1) NOT NULL COMMENT '分数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分数';


-- 导出  表 aboutstudent.student 结构
CREATE TABLE IF NOT EXISTS `student` (
  `sno` varchar(3) NOT NULL COMMENT '学号',
  `sname` varchar(4) NOT NULL COMMENT '学生姓名',
  `ssex` varchar(2) NOT NULL COMMENT '学生性别',
  `sbirthday` datetime DEFAULT NULL COMMENT '生日',
  `class` varchar(5) DEFAULT NULL COMMENT '班级'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生信息';


-- 导出  表 aboutstudent.teacher 结构
CREATE TABLE IF NOT EXISTS `teacher` (
  `tno` varchar(3) NOT NULL COMMENT '老师编号',
  `tname` varchar(4) NOT NULL COMMENT '老师名称',
  `tsex` varchar(2) NOT NULL COMMENT '性别',
  `tbirthday` datetime NOT NULL COMMENT '生日',
  `prof` varchar(6) DEFAULT NULL COMMENT '级别',
  `depart` varchar(10) NOT NULL COMMENT '部门'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师';

-- 导出  表 aboutstudent.textbook 结构
CREATE TABLE IF NOT EXISTS `textbook` (
  `tbno` varchar(10) NOT NULL COMMENT '教材号',
  `tbname` varchar(60) NOT NULL COMMENT '教材名',
  `cno` varchar(5) NOT NULL COMMENT '课程号',
  `press` varchar(20) NOT NULL COMMENT '出版社',
  `presstime` datetime NOT NULL COMMENT '出版时间',
  `author` varchar(30) NOT NULL COMMENT '作者',
  `price` decimal(10,2) NOT NULL COMMENT '价格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教材';

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
