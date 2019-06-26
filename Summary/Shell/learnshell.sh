#!/usr/bin/bash
#是注释符号, !/bin/sh要写在第一句,指出哪一个bash运行此程序
echo "Hello World!"
echo "learn shell:https://blog.csdn.net/qq769651718/article/category/7467504"

#定义常量,x= xxx, x = xxx是错误的
a="hello world!"
num=2
echo "a is : $a , num is ${num}nd"

#切片
stringass="123gdfsgsd1312313131231"
echo ${stringass:1:4}
if `ps -ef| grep pickup`; then echo hello; fi

# 无限循环
#while :
#do 
#    echo "$a"
#done

echo "hello while loop"
let s=124
while [ $s -gt 120 ]
do :
    # set -x是开启调试, 会打印出来信息, set +x是关闭调试
    set +x
    # set +x
    echo "=========="
    # 数值运算
    s=$(($s - 2))
done


#定义常量
i=94
sum=0
while [ $i -le 100 ]
do
    #定义变量
    let sum=sum+$i
    let i+=2
done

echo $sum

#定义数组
array_name=("value1" "value2" "value3")
echo ${array_name[1]}
#@和*都是打印参数
echo ${array_name[@]}


length=${#array_name[@]}
echo ${length}

#这样直接定义了三个参数
array_name1=(value1 value2 value31)
echo ${array_name1[*]}

# if 和[]之间, 条件和[]之间,都要留下空格
# ifelse
if [ "$SHELL" = "/bin/bash" ];then
    echo "your shell is the bash \n"
    echo "SHELL is :$SHELL"
else
    echo "SHELL is not bash but $SHELL"
fi

#-p是输出时候的提示信息
read -p  "请输入1,2,3三个参数: " var1 var2 var3
echo $var1 $var2 $var3

read -t 5 -p "5s之后就会过期,请快速输入: " varu
echo $varu


# 文件的判断
#[ -f "somefile" ] : 判断是否是一个文件
#[ -x "/bin/ls" ] : 判断/bin/ls是否存在并有执行权限
#{ -n "$var" } : 判断$var变量是否有值
#[ "$a" = "$b"] : 判断$a和$b是否相等
[ -f "/etc/shadow" ] && echo "this is password computer"
if [ -f "/etc/shadow" ];then
	echo "123123123"
else
	echo "没有"
fi  

# 分片
string="a libaba, hhaha ,fsaf fasf"
echo ${string:1:4}

# 变量运算
let a=1
echo $a


