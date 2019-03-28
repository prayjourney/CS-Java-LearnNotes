### PostgreSQL
自从MySQL被Oracle收购以后，[PostgreSQL](http://www.postgresql.org/)，[MariaDB](http://mariadb.org/)逐渐成为开源关系型数据库的首选，本文介绍PostgreSQL。

* * *
##### 基本使用

**1.安装**

首先，安装PostgreSQL客户端。

> sudo apt-get install postgresql-client

然后，安装PostgreSQL服务器。

> sudo apt-get install postgresql

正常情况下，安装完成后，PostgreSQL服务器会自动在本机的5432端口开启。

如果还想安装图形管理界面，可以运行下面命令，但是本文不涉及这方面内容。

> sudo apt-get install pgadmin3

**2.添加新用户和新数据库**

初次安装后，默认生成一个名为postgres的数据库和一个名为postgres的数据库用户。这里需要注意的是，同时还生成了一个名为postgres的Linux系统用户。

下面，我们使用postgres用户，来生成其他用户和新数据库。好几种方法可以达到这个目的，这里介绍两种。

**第一种方法，使用PostgreSQL控制台。**

首先，新建一个Linux新用户，可以取你想要的名字，这里为dbuser。

> sudo adduser dbuser

然后，切换到postgres用户。

> sudo su - postgres

下一步，使用psql命令登录PostgreSQL控制台。

> psql

这时相当于系统用户postgres以同名数据库用户的身份，登录数据库，这是不用输入密码的。如果一切正常，系统提示符会变为"postgres=#"，表示这时已经进入了数据库控制台。以下的命令都在控制台内完成。

第一件事是使用\password命令，为postgres用户设置一个密码。

> \password postgres

第二件事是创建数据库用户dbuser（刚才创建的是Linux系统用户），并设置密码。

> CREATE USER dbuser WITH PASSWORD 'password';

第三件事是创建用户数据库，这里为exampledb，并指定所有者为dbuser。

> CREATE DATABASE exampledb OWNER dbuser;

第四件事是将exampledb数据库的所有权限都赋予dbuser，否则dbuser只能登录控制台，没有任何数据库操作权限。

> GRANT ALL PRIVILEGES ON DATABASE exampledb to dbuser;

最后，使用\q命令退出控制台（也可以直接按ctrl+D）。

> \q

**第二种方法，使用shell命令行。**

添加新用户和新数据库，除了在PostgreSQL控制台内，还可以在shell命令行下完成。这是因为PostgreSQL提供了命令行程序createuser和createdb。还是以新建用户dbuser和数据库exampledb为例。

首先，创建数据库用户dbuser，并指定其为超级用户。

> sudo -u postgres createuser --superuser dbuser

然后，登录数据库控制台，设置dbuser用户的密码，完成后退出控制台。

> sudo -u postgres psql
>
> \password dbuser
>
> \q

接着，在shell命令行下，创建数据库exampledb，并指定所有者为dbuser。

> sudo -u postgres createdb -O dbuser exampledb

**3.登录数据库**

添加新用户和新数据库以后，就要以新用户的名义登录数据库，这时使用的是psql命令。

> psql -U dbuser -d exampledb -h 127.0.0.1 -p 5432

上面命令的参数含义如下：-U指定用户，-d指定数据库，-h指定服务器，-p指定端口。

输入上面命令以后，系统会提示输入dbuser用户的密码。输入正确，就可以登录控制台了。

psql命令存在简写形式。如果当前Linux系统用户，同时也是PostgreSQL用户，则可以省略用户名（-U参数的部分）。举例来说，我的Linux系统用户名为ruanyf，且PostgreSQL数据库存在同名用户，则我以ruanyf身份登录Linux系统后，可以直接使用下面的命令登录数据库，且不需要密码。

> psql exampledb

此时，如果PostgreSQL内部还存在与当前系统用户同名的数据库，则连数据库名都可以省略。比如，假定存在一个叫做ruanyf的数据库，则直接键入psql就可以登录该数据库。

> psql

另外，如果要恢复外部数据，可以使用下面的命令。

> psql exampledb < exampledb.sql

**4.控制台命令**

除了前面已经用到的\password命令（设置密码）和\q命令（退出）以外，控制台还提供一系列其他命令。

> - \h：查看SQL命令的解释，比如\h select。
> - \?：查看psql命令列表。
> - \l：列出所有数据库。
> - \c [database_name]：连接其他数据库。
> - \d：列出当前数据库的所有表格。
> - \d [table_name]：列出某一张表格的结构。
> - \du：列出所有用户。
> - \e：打开文本编辑器。
> - \conninfo：列出当前数据库和连接的信息。

**5.数据库操作**

基本的数据库操作，就是使用一般的SQL语言。
```sql
> \# 创建新表
> CREATE TABLE user_tbl(name VARCHAR(20), signup_date DATE);
>
> \# 插入数据
> INSERT INTO user_tbl(name, signup_date) VALUES('张三', '2013-12-22');
>
> \# 选择记录
> SELECT * FROM user_tbl;
>
> \# 更新数据
> UPDATE user_tbl set name = '李四' WHERE name = '张三';
>
> \# 删除记录
> DELETE FROM user_tbl WHERE name = '李四' ;
>
> \# 添加栏位
> ALTER TABLE user_tbl ADD email VARCHAR(40);
>
> \# 更新结构
> ALTER TABLE user_tbl ALTER COLUMN signup_date SET NOT NULL;
>
> \# 更名栏位
> ALTER TABLE user_tbl RENAME COLUMN signup_date TO signup;
>
> \# 删除栏位
> ALTER TABLE user_tbl DROP COLUMN email;
>
> \# 表格更名
> ALTER TABLE user_tbl RENAME TO backup_tbl;
>
> \# 删除表格
> DROP TABLE IF EXISTS backup_tbl;
```



##### 操作符

- 逻辑操作符：
  常用的逻辑操作符有：**AND**、**OR**和**NOT**。其语义与其它编程语言中的逻辑操作符完全相同。

- 比较操作符：
  下面是PostgreSQL中提供的比较操作符列表：
| 操作符 | 描述 |
|--------|--------|
|<   	| 小于 |
|>	    |大于|
|<=	    |小于或等于|
|>=	    |大于或等于|
|=	    |等于|
|!=	    |不等于|

>比较操作符可以用于所有可以比较的数据类型。所有比较操作符都是双目操作符，且返回boolean类型。除了比较操作符以外，我们还可以使用BETWEEN语句，如：
```sql
    a BETWEEN x AND y 等效于 a >= x AND a <= y
    a NOT BETWEEN x AND y 等效于 a < x OR a > y
```

- 操作符：
  下面是PostgreSQL中提供的**数学操作符**列表：
|操作符|	描述	|例子	|结果|
|--------|--------|--------|--------|
|+	|加	|2 + 3|	5|
|-	|减	|2 - 3|	-1|
|\*	|乘	|2 * 3|	6|
|/	|除	|4 / 2|	2|
|%	|模	|5 % 4|	1|
|^	|幂	|2.0 ^ 3.0|	8|
|竖斜	|平方根|竖斜 25.0|	5|
|竖竖斜[^1]   |立方根|竖竖斜 27.0|	3|
|!	|阶乘	|5 !|	120|
|!!	|阶乘	|!! 5|	120|
|@	|绝对值|	@ -5.0|	5|
|&	|按位AND|	91 & 15|	11|
|竖	|按位OR|	32竖  3|	35|
|#	|按位XOR|	17 # 5|	20|
|~	|按位NOT|	~1|	-2|
|<<	|按位左移|	1 << 4|	16|
|>>	|按位右移|	8 >> 2|	2|
**按位操作符只能用于整数类型**，而其它的操作符可以用于全部数值数据类型。++按位操作符还可以用于位串类型bit和bit varying++.

##### 数学函数

- 数学函数
|函数	    |返回类型  |描述	  |例子    | 结果|
|--------|--------|--------|--------|--------|
|abs(x)	 |-	|绝对值 |	abs(-17.4)|	17.4|
|cbrt(double)|	-	| 	立方根|	cbrt(27.0)|	3|
|ceil(double/numeric)|	 -	|不小于参数的最小的整数|	ceil(-42.8)	|-42|
|degrees(double)|-| 	把弧度转为角度	|degrees(0.5)|	28.6478897565412|
|exp(double/numeric)|-	 |	自然指数|	exp(1.0)|	2.71828182845905|
|floor(double/numeric)|	 -|不大于参数的最大整数|	floor(-42.8)|	-43|
|ln(double/numeric)|-| 	自然对数|	ln(2.0)	|0.693147180559945|
|log(double/numeric)|- |	10为底的对数|	log(100.0)|	2|
|log(b numeric,x numeric)|-	 |	numeric指定底数的对数|	log(2.0, 64.0)|	6.0000000000|
|mod(y, x)|	 -	|取余数|	mod(9,4)|	1|
|pi()|double|	"π"常量|	pi() |3.14159265358979|
|power(a double, b double)|	double|	求a的b次幂|	power(9.0, 3.0)|	729|
|power(a numeric, b numeric)|	numeric	|求a的b次幂|	power(9.0, 3.0)|	729|
|radians(double)|	double|	把角度转为弧度|	radians(45.0)|	0.785398163397448|
|random()|	double|	0.0到1.0之间的随机数值|	random()|-|
|round(double/numeric)|-	 |	圆整为最接近的整数|	round(42.4)|	42|
|round(v numeric, s int)|	numeric	|圆整为s位小数数字|	round(42.438,2)	|42.44|
|sign(double/numeric)|	- |	参数的符号(-1,0,+1)| sign(-8.4)|	-1|
|sqrt(double/numeric)	 |-	|平方根|	sqrt(2.0)|	1.4142135623731|
|trunc(double/numeric)	|- 	|截断(向零靠近)	|trunc(42.8)	|42|
|trunc(v numeric, s int)|	numeric|	截断为s小数位置的数字|	trunc(42.438,2)	|42.43|

- 三角函数列表：
|函数	|描述|
|--------|--------|
|acos(x)|	反余弦|
|asin(x)|	反正弦|
|atan(x)|	反正切|
|atan2(x, y)|	正切 y/x 的反函数|
|cos(x)|	余弦|
|cot(x)|	余切|
|sin(x)|	正弦|
|tan(x)|	正切|

- 位串函数和操作符：
  对于类型*bit和bit varying*，除了常用的比较操作符之外，还可以使用以下列表中由PostgreSQL提供的位串函数和操作符，**其中&、|和#的位串操作数必须等长**。++在移位的时候，保留原始的位串的的长度++。
|操作符|	描述	|例子	|结果|
|--------|--------|--------|--------|
|竖	|连接	|B'10001'竖竖 B'011'|10001011|
|&	 |按位AND|	B'10001' & B'01101'|	00001|
|竖	|按位OR|	B'10001' 竖 B'01101'|	11101|
|#	 |按位XOR	|B'10001' # B'01101'	|11100|
|~	 |按位NOT	|~ B'10001'|	01110|
|<<	 |按位左移|	B'10001' << 3|	01000|
|>>	 |按位右移|	B'10001' >> 2|	00100|

##### 字符函数

- 简略信息
|函数	|返回类型|	描述|	例子|	结果|
|--------|--------|--------|--------|--------|
|string 竖竖 string|	text|	字串连接|	'Post' 竖竖 'greSQL'|	PostgreSQL|
|bit_length(string)|	int	|字串里二进制位的个数|	bit_length('jose')|	32|
|char_length(string)|	int	|字串中的字符个数	|char_length('jose')	|4|
|convert(string using conversion_name)|	text|	使用指定的转换名字改变编码|	convert('PostgreSQL' using iso_8859_1_to_utf8)|	'PostgreSQL'|
|lower(string)	|text	|把字串转化为小写|	lower('TOM')|	tom|
|octet_length(string)|	int	|字串中的字节数|	octet_length('jose')|	4|
|overlay(string placing string from int [for int])|	text|	替换子字串|	overlay('Txxxxas' placing 'hom' from 2 for 4)|	Thomas|
|position(substring in string)|	int	|指定的子字串的位置	|position('om' in 'Thomas')|	3|
|**substring(string [from int] [for int]**)|	text|**抽取子字串**|	substring('Thomas' from 2 for 3)|hom|
|**substring(string from pattern)**|	text|**	抽取匹配 POSIX 正则表达式的子字串**|substring('Thomas' from '...$')|	mas|
|**substring(string from pattern for escape)**|	text|**	抽取匹配SQL正则表达式的子字串**|substring('Thomas' from '%#"o_a#"_' for '#')|	oma|
|trim([leading竖 trailing 竖 both] [characters] from string)|	text|	从字串string的开头/结尾/两边/ 删除只包含characters(缺省是一个空白)的最长的字串|	trim(both 'x' from 'xTomxx')|	Tom|
|upper(string)|	text	|把字串转化为大写|	upper('tom')|	TOM|
|ascii(text)|	int	|参数第一个字符的ASCII码	ascii('x')|	120|
|btrim(string text [, characters text])|	text|	从string开头和结尾删除只包含在characters里(缺省是空白)的字符的最长字串|	btrim('xyxtrimyyx','xy')|	trim|
|chr(int)	|text	|给出ASCII码的字符|	chr(65)	|A|
|convert(string text, [src_encoding name,] dest_encoding name)|	text	|把字串转换为dest_encoding|	convert( 'text_in_utf8', 'UTF8', 'LATIN1')|	以ISO 8859-1编码表示的text_in_utf8|
|initcap(text)|	text|	把每个单词的第一个子母转为大写，其它的保留小写，单词是一系列字母数字组成的字符，用非字母数字分隔|	initcap('hi thomas')|	Hi Thomas|
|**length(string text)	**|int	|string中字符的数目|	length('jose')|	4|
|lpad(string text, length int [, fill text])	|text|	通过填充字符fill(缺省时为空白)，把string填充为长度length。 如果string已经比length长则将其截断(在右边)。|	lpad('hi', 5, 'xy')	|xyxhi|
|ltrim(string text [, characters text])|	text|	从字串string的开头删除只包含characters(缺省是一个空白)的最长的字串|	ltrim('zzzytrim','xyz')|	trim|
|md5(string text)|	text	|计算给出string的MD5散列，以十六进制返回结果|	md5('abc')|-|
|**repeat(string text, number int)**|	text|**重复string number次**|repeat('Pg', 4)|	PgPgPgPg|
|**replace(string text, from text, to text)**|	text	|把字串string里出现地所有子字串from替换成子字串to|replace('abcdefabcdef', 'cd', 'XX')|	abXXefabXXef|
|rpad(string text, length int [, fill text])|	text	|通过填充字符fill(缺省时为空白)，把string填充为长度length。如果string已经比length长则将其截断。|	rpad('hi', 5, 'xy')|	hixyx|
|rtrim(string text [, character text])|	text|	从字串string的结尾删除只包含character(缺省是个空白)的最长的字|	rtrim('trimxxxx','x')|	trim|
|split_part(string text, delimiter text, field int)	|text|	根据delimiter分隔string返回生成的第field个子字串(1 Base)|	split_part('abc~@~def~@~ghi', '~@~', 2)|	def|
|strpos(string, substring)|	text|	声明的子字串的位置|	strpos('high','ig')|	2|
|substr(string, from [, count])|	text|	抽取子字串|	substr('alphabet', 3, 2)|	ph|
|to_ascii(text [, encoding])|	text|	把text从其它编码转换为ASCII|	to_ascii('Karel')|	Karel|
|to_hex(number int/bigint)|	text	|把number转换成其对应地十六进制表现形式|	to_hex(9223372036854775807)	|7fffffffffffffff|
|translate(string text, from text, to text)|	text|	把在string中包含的任何匹配from中的字符的字符转化为对应的在to中的字符|	translate('12345', '14', 'ax')|	a23x5|

- 详细信息
 - 函数：==string || string==
说明：*String concatenation 字符串连接操作*
例子：'Post' || 'greSQL'　＝　PostgreSQL

 - 函数：==string || non-string or non-string || string==
说明：*String concatenation with one non-string input 字符串与非字符串类型进行连接操作*
例子：'Value: ' || 42 = Value: 42

 - 函数：==bit_length(string)==
说明：*Number of bits in string 计算字符串的位数*
例子：bit_length('jose') = 32

 - 函数：==char_length(string) or character_length(string)==
说明：*Number of characters in string 计算字符串中字符个数*
例子：char_length('jose') = 4

 - 函数：==lower(string)==
说明：*Convert string to lower case 转换字符串为小写*
例子：bit_length('jose') = 32

 - 函数：==octet_length(string)==
说明：*Number of bytes in string 计算字符串的字节数*
例子：octet_length('jose') = 4

 - 函数：==overlay(string placing string from int [for int])==
说明：*Replace substring 替换字符串中任意长度的子字串为新字符串*
例子：overlay('Txxxxas' placing 'hom' from 2 for 4) = 4

 - 函数：==position(substring in string)==
说明：*Location of specified substring 子串在一字符串中的位置*
例子：position('om' in 'Thomas') = 3

 - 函数：==substring(string [from int] [for int])==
说明：*Extract substring 截取任意长度的子字符串*
例子：substring('Thomas' from 2 for 3) = hom

 - 函数：==substring(string from pattern)==
说明：*Extract substring matching POSIX regular expression. See Section 9.7 for more information on pattern matching. 利用正则表达式对一字符串进行任意长度的字串的截取*
例子：substring('Thomas' from '...$') = mas

 - 函数：==substring(string from pattern for escape)==
说明：Extract substring matching SQL regular expression. See Section 9.7 for more information on pattern matching. 利于正则表达式对某类字符进行删除，以得到子字符串
例子：trim(both 'x' from 'xTomxx') = Tom

 - 函数：==trim([leading | trailing | both] [characters] from string)==
说明：*Remove the longest string containing only the characters (a space by default) from the start/end/both ends of the string 去除尽可能长开始，结束或者两边的某类字符，默认为去除空白字符，当然可以自己指定，可同时指定多个要删除的字符串*
例子：trim(both 'x' from 'xTomxx') = Tom

 - 函数：==upper(string)==
说明：*Convert string to uppercase 将字符串转换为大写*
例子：upper('tom') = TOM

 - 函数：==ascii(string)==
说明：*ASCII code of the first character of the argument. For UTF8 returns the Unicode code point of the character. For other multibyte encodings. the argument must be a strictly ASCII character. 得到某一个字符的Assii值*
例子：ascii('x') = 120

 - 函数：==btrim(string text [, characters text])==
说明：*Remove the longest string consisting only of characters in characters (a space by default) from the start and end of string 去除字符串两边的所有指定的字符，可同时指定多个字符*
例子：btrim('xyxtrimyyx', 'xy') = trim

 - 函数：==chr(int)==
说明：*Character with the given code. For UTF8 the argument is treated as a Unicode code point. For other multibyte encodings the argument must designate a strictly ASCII character. The NULL (0) character is not allowed because text data types cannot store such bytes. 得到某ACSII值对应的字符*
例子：chr(65) = A

 - 函数：==convert(string bytea, src_encoding name, dest_encoding name)==
说明：Convert string to dest_encoding. The original encoding is specified by src_encoding. The string must be valid in this encoding. Conversions can be defined by CREATE CONVERSION. Also there are some predefined conversions. See Table 9-7 for available conversions. 转换字符串编码，指定源编码与目标编码
例子：convert('text_in_utf8', 'UTF8', 'LATIN1') = text_in_utf8 represented in ISO 8859-1 encoding

 - 函数：==convert_from(string bytea, src_encoding name)==
说明：*Convert string to the database encoding. The original encoding is specified by src_encoding. The string must be valid in this encoding. 转换字符串编码，自己要指定源编码,目标编码默认为数据库指定编码*
例子：convert_from('text_in_utf8', 'UTF8') = text_in_utf8 represented in the current database encoding

 - 函数：==convert_to(string text, dest_encoding name)==
说明：*Convert string to dest_encoding.转换字符串编码，源编码默认为数据库指定编码，自己要指定目标编码*
例子：convert_to('some text', 'UTF8') = some text represented in the UTF8 encoding

 - 函数：==decode(string text, type text)==
说明：*Decode binary data from string previously encoded with encode. Parameter type is same as in encode. 对字符串按指定的类型进行解码*
例子：decode('MTIzAAE=', 'base64') = 123\000\001

 - 函数：==encode(data bytea, type text)==
说明：*Encode binary data to different representation. Supported types are: base64, hex, escape. Escape merely outputs null bytes as \000 and doubles backslashes. 与decode相反，对字符串按指定类型进行编码*
例子：encode(E'123\\000\\001', 'base64') = MTIzAAE=

 - 函数：==initcap(string)==
说明：*Convert the first letter of each word to uppercase and the rest to lowercase. Words are sequences of alphanumeric characters separated by non-alphanumeric characters. 将字符串所有的单词进行格式化，首字母大写，其它为小写*
例子：initcap('hi THOMAS') = Hi Thomas

 - 函数：==length(string)==
说明：*Number of characters in string 计算字符串长度*
例子：length('jose') = 4

 - 函数：==length(stringbytea, encoding name )==
说明：*Number of characters in string in the given encoding. The string must be valid in this encoding. 计算字符串长度，指定字符串使用的编码*
例子：length('jose', 'UTF8') = 4

 - 函数：==lpad(string text, length int [, fill text])==
说明：*Fill up the string to length length by prepending the characters fill (a space by default). If the string is already longer than length then it is truncated (on the right). 对字符串左边进行某类字符自动填充，即不足某一长度，则在左边自动补上指定的字符串，直至达到指定长度，可同时指定多个自动填充的字符*
例子：lpad('hi', 5, 'xy') = xyxhi

 - 函数：==ltrim(string text [, characters text])==
说明：*Remove the longest string containing only characters from characters (a space by default) from the start of string 删除字符串左边某一些的字符，可以时指定多个要删除的字符*
例子：trim

 - 函数：==md5(string)==
说明：*Calculates the MD5 hash of string, returning the result in hexadecimal 将字符串进行md5编码*
例子：md5('abc') = 900150983cd24fb0 d6963f7d28e17f72

 - 函数：==pg_client_encoding()==
说明：*Current client encoding name 得到pg客户端编码*
例子：pg_client_encoding() = SQL_ASCII

 - 函数：==quote_ident(string text)==
说明：*Return the given string suitably quoted to be used as an identifier in an SQL statement string. Quotes are added only if necessary (i.e., if the string contains non-identifier characters or would be case-folded). Embedded quotes are properly doubled. 对某一字符串加上两引号*
例子：quote_ident('Foo bar') = "Foo bar"

 - 函数：==quote_literal(string text)==
说明：*Return the given string suitably quoted to be used as a string literal in an SQL statement string. Embedded single-quotes and backslashes are properly doubled. 对字符串里两边加上单引号，如果字符串里面出现sql编码的单个单引号，则会被表达成两个单引号*
例子：quote_literal('O\'Reilly') = 'O''Reilly'

 - 函数：==quote_literal(value anyelement)==
说明：*Coerce the given value to text and then quote it as a literal. Embedded single-quotes and backslashes are properly doubled. 将一数值转换为字符串，并为其两边加上单引号，如果数值中间出现了单引号，也会被表示成两个单引号*
例子：quote_literal(42.5) = '42.5'

 - 函数：==regexp_matches(string text, pattern text [, flags text])==
说明：*Return all captured substrings resulting from matching a POSIX regular expression against the string. See Section 9.7.3 for more information. 对字符串按正则表达式进行匹配，如果存在则会在结果数组中表示出来*
例子：regexp_matches('foobarbequebaz', '(bar)(beque)') = {bar,beque}

 - 函数：==regexp_replace(string text, pattern text, replacement text [, flags text])==
说明：Replace substring(s) matching a POSIX regular expression. See Section 9.7.3 for more information. 利用正则表达式对字符串进行替换
例子：regexp_replace('Thomas', '.[mN]a.', 'M') = ThM

 - 函数：==regexp_split_to_array(string text, pattern text [, flags text ])==
说明：*Split string using a POSIX regular expression as the delimiter. See Section 9.7.3 for more information. 利用正则表达式将字符串分割成数组*
例子：regexp_split_to_array('hello world', E'\\s+') = {hello,world}

 - 函数：==regexp_split_to_table(string text, pattern text [, flags text])==
说明：*Split string using a POSIX regular expression as the delimiter. See Section 9.7.3 for more information. 利用正则表达式将字符串分割成表格*
例子：regexp_split_to_table('hello world', E'\\s+') =
hello
world
(2 rows)

 - 函数：==repeat(string text, number int)==
说明：*Repeat string the specified number of times 重复字符串一指定次数*
例子：repeat('Pg', 4) = PgPgPgPg

 - 函数：==replace(string text, from text, to text)==
说明：*Replace all occurrences in string of substring from with substring to 将字符的某一子串替换成另一子串*
例子：('abcdefabcdef', 'cd', 'XX') = abXXefabXXef

 - 函数：==rpad(string text, length int [, fill text])==
说明：*Fill up the string to length length by appending the characters fill (a space by default). If the string is already longer than length then it is truncated. 对字符串进行填充，填充内容为指定的字符串*
例子：rpad('hi', 5, 'xy') = hixyx

 - 函数：==rtrim(string text [, characters text])==
说明：*Remove the longest string containing only characters from characters (a space by default) from the end of string去除字符串右边指定的字符*
例子：rtrim('trimxxxx', 'x') = trim

 - 函数：==split_part(string text, delimiter text, field int)==
说明：*Split string on delimiter and return the given field (counting from one)  对字符串按指定子串进行分割，并返回指定的数值位置的值*
例子：split_part('abc~@~def~@~ghi', '~@~', 2) = def

 - 函数：==strpos(string, substring)==
说明：*Location of specified substring (same as position(substring in string), but note the reversed argument order) 指定字符串在目标字符串的位置*
例子：strpos('high', 'ig') = 2

 - 函数：==substr(string, from [, count])==
说明：*Extract substring (same as substring(string from from for count)) 截取子串*
例子：substr('alphabet', 3, 2) = ph

 - 函数：==to_ascii(string text [, encoding text])==
说明：*Convert string to ASCII from another encoding (only supports conversion from LATIN1, LATIN2, LATIN9, and WIN1250 encodings) 将字符串转换成ascii编码字符串*
例子：to_ascii('Karel') = Karel

 - 函数：==to_hex(number int or bigint)==
说明：*Convert number to its equivalent hexadecimal representation 　对数值进行十六进制编码*
例子：to_hex(2147483647) = 7fffffff

 - 函数：==translate(string text, from text, to text)==
说明：*Any character in string that matches a character in the from set is replaced by the corresponding character in the to set 将字符串中某些匹配的字符替换成指定字符串，目标字符与源字符都可以同时指定多个*
例子：translate('12345', '14', 'ax') = a23x5



##### 数据类型

- PostgreSQL支持的数据类型
| 类型 | 含义 |
|--------|--------|
|*bigint*   |有符号的八位整数   |
|bigserial	|自增长的八位整数   |
|bit [(n)]	|固定长度的位串     |
|bit varying [(n)]	|可变长度的位串|
|**boolean**	|逻辑布尔值(true/false)|
|box	|在一个平面上的矩形框|
|bytea	|二进制数据("位数组")|
|**character varying [(n)]**|	可变长度的字符串|
|**character [(n)]**	|固定长度的字符串|
|cidr	|IPv4 或者 IPv6 网络地址|
|circle	|平面上的一个圆|
|**date**	|**日历日期 ( 年月日)**|
|double precision	|双精度浮点数（8位）|
|inet	|IPv4 或者 IPv6 主机地址|
|**integer**	|有符号的四位整数|
|interval [fields] [(p)]|	时间跨度|
|line	|平面上的一个无限长的直线|
|lseg	|平面上的一个线段|
|macaddr	|MAC (媒体访问控制)地址|
|*money*	|货币金额|
|**numeric [(p, s)**]	|可选精度的精确数字|
|path	|一个平面上的几何路径|
|point	|一个平面上的几何点|
|polygon	|一个平面上的闭合的几何路径|
|**real**	|单精度浮点数(4 位)|
|*smallint*	|有符号的两位整数|
|*serial*	|自增长4位整数|
|**text**	|可变长度字符创|
|**time [(p)] [without time zone]**	|一天中的时间(无时区)|
|time [(p)] with time zone	|一天中的时间，包含时区|
|timestamp [(p)] [without time zone]	|日期和时间（没有时区）|
|timestamp [(p)] with time zone	|日期和时间，包含时区|
|tsquery	|文本搜索查询|
|tsvector	|文本搜索文档|
|txid_snapshot|	用户级事务ID快照|
|uuid	|通用的唯一标识符|
|xml	|XML 数据|



##### 日期相关

- PostgreSQL格式化函数提供一套有效的工具用于把各种数据类型(日期/时间、integer、floating point和numeric)转换成格式化的字符串以及反过来从格式化的字符串转换成指定的数据类型。下面列出了这些函数，它们都遵循一个公共的调用习惯：**第一个参数是待格式化的值**，而**第二个是定义输出或输出格式的模板**。
|函数	     |返回类型  |	描述	 |   例子  |
|---------|---------|---------|---------|
|to_char(timestamp, text)|text	|把时间戳转换成字串|	to_char(current_timestamp, 'HH12:MI:SS')|
|to_char(interval, text)|	text	|把时间间隔转为字串|	to_char(interval '15h 2m 12s', 'HH24:MI:SS')|
|to_char(int, text)	|text|	把整数转换成字串|	to_char(125, '999')|
|to_char(double precision, text)|	text|	把实数/双精度数转换成字串|	to_char(125.8::real, '999D9')|
|to_char(numeric, text)	|text	|把numeric转换成字串|	to_char(-125.8, '999D99S')|
|to_date(text, text)|	date|	把字串转换成日期|	to_date('05 Dec 2000', 'DD Mon YYYY')|
|to_timestamp(text, text)|	timestamp|	把字串转换成时间戳|	to_timestamp('05 Dec 2000', 'DD Mon YYYY')|
|to_timestamp(double)|	timestamp|	把UNIX纪元转换成时间戳|	to_timestamp(200120400)|
|to_number(text, text)|	numeric|	把字串转换成numeric|	to_number('12,454.8-', '99G999D9S')|

- 用于日期/时间格式化的模式：
|模式	|描述|
|---------|---------|
|HH	|一天的小时数(01-12)|
|HH12|	一天的小时数(01-12)|
|HH24|	一天的小时数(00-23)|
|MI	|分钟(00-59)|
|SS	|秒(00-59)|
|MS	|毫秒(000-999)|
|US	|微秒(000000-999999)|
|AM	|正午标识(大写)|
|Y,YYY|	带逗号的年(4和更多位)|
|YYYY|	年(4和更多位)|
|YYY|	年的后三位|
|YY	|年的后两位|
|Y	|年的最后一位|
|MONTH|	全长大写月份名(空白填充为9字符)|
|Month|	全长混合大小写月份名(空白填充为9字符)|
|month|	全长小写月份名(空白填充为9字符)|
|MON|	大写缩写月份名(3字符)|
|Mon|	缩写混合大小写月份名(3字符)|
|mon|	小写缩写月份名(3字符)|
|MM	|月份号(01-12)|
|DAY|	全长大写日期名(空白填充为9字符)|
|Day|	全长混合大小写日期名(空白填充为9字符)|
|day|	全长小写日期名(空白填充为9字符)|
|DY	|缩写大写日期名(3字符)|
|Dy	|缩写混合大小写日期名(3字符)|
|dy	|缩写小写日期名(3字符)|
|DDD|	一年里的日子(001-366)|
|DD	|一个月里的日子(01-31)|
|D	|一周里的日子(1-7；周日是1)|
|W	|一个月里的周数(1-5)(第一周从该月第一天开始)|
|WW	|一年里的周数(1-53)(第一周从该年的第一天开始)|


- 日期/时间函数：
|函数	|返回类型	|描述|	例子|	结果|
|---|---|---|---|---|
|age(timestamp, timestamp)	|interval	|减去参数，生成一个使用年、月的"符号化"的结果	|age('2001-04-10', timestamp '1957-06-13')	|43 years 9 mons 27 days|
|age(timestamp)	|interval	|从current_date减去得到的数值|	age(timestamp '1957-06-13')	|43 years 8 mons 3 days|
|**current_date**|	date	|今天的日期|-|-|
|**current_time**|	time	|现在的时间|-|-|
|current_timestamp|	timestamp	|日期和时间|-|-|
|date_part(text, timestamp)	|double	|获取子域(等效于extract)|date_part('hour', timestamp '2001-02-16 20:38:40')	|20|
|date_part(text, interval)|	double	|获取子域(等效于extract)	|date_part('month', interval '2 years 3 months')|	3|
|date_trunc(text, timestamp)|	timestamp|	截断成指定的精度|date_trunc('hour', timestamp '2001-02-16 20:38:40')|	2001-02-16 20:00:00+00|
|extract(field from timestamp)|	double	|获取子域	|extract(hour from timestamp '2001-02-16 20:38:40')	|20|
|extract(field from interval)|	double|	获取子域	|extract(month from interval '2 years 3 months')|	3|
|**localtime**|	time	|**今日的时间**|-|-|
|localtimestamp|timestamp|	日期和时间|-|-|
|**now()**|timestamp|当前的日期和时间(等效于 current_timestamp)|-|-|
|timeofday()|	text|	当前日期和时间|-|-|



##### 与MySQL的比较

- 二者区别
| Mysql| PostgrelSQL|
|------|------------|
|  流行 |    先进    |
|-   |  **稳定**        |
| -  |  大量的类型   |
| -  | **事务隔离做的更好**|
| -  | 存储方式支持更大的数据量|
| -  | 时间精度更高|
| -  | **标准SQL的兼容性**|
| -  | 在Windows上运行更可靠|

ref：
1.[PostgreSQL新手入门](http://www.ruanyifeng.com/blog/2013/12/getting_started_with_postgresql.html), 2.[PostgreSQL学习手册(函数和操作符<一>)](http://www.cnblogs.com/stephen-liu74/archive/2012/05/02/2294071.html), 3.[SQLite、MySQL和PostgreSQL 三种关系数据库哪个好？](https://www.ssdax.com/2188.html), 4.[PostgreSQL数据类型](http://www.yiibai.com/html/postgresql/2013/080435.html), 5.[PostgreSQL学习手册(常用数据类型)](http://www.cnblogs.com/stephen-liu74/archive/2012/04/30/2293602.html), 6.[ PostgreSQL数据类型](http://blog.csdn.net/neo_liu0000/article/details/6254086), 7.[ PostgreSQL与MySQL优势比较](http://blog.csdn.net/wag2765/article/details/50581658), 8.[PostgreSQL 与 MySQL 相比，优势何在？](https://www.zhihu.com/question/20010554)，9[PostgreSQL学习手册(函数和操作符<二>)](http://www.cnblogs.com/stephen-liu74/archive/2012/05/04/2294643.html)，10.[PostgrelSQl学习手册](http://www.cnblogs.com/stephen-liu74/category/343171.html), 11.[PostgreSQL与MySQL数据库的区别](http://blog.csdn.net/u012843873/article/details/60745287)


[^1]:竖表示“|”，斜表示"/"。