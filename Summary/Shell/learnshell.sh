#!/usr/bin/bash
#是注释符号, !/bin/sh要写在第一句,指出哪一个bash运行此程序
#定义常量,x= xxx, x = xxx是错误的
a="hello world!"
num=2
echo "a is : $a , num is ${num}nd"
stringass="123gdfsgsd1312313131231"
echo ${stringass:1:4}
if `ps -ef| grep pickup`; then echo hello; fi
# 无限循环
#while :
#do 
#    echo "$a"
#done
s=100
while (($s -gt 120))
do 
 echo"毛sssfsfa"
 # 数值运算
 s=$((s+2))
done

# ifelse
if [ "$SHELL" = "/bin/bash" ];then
echo "your shell is the bash \n"
echo "SHELL is :$SHELL"
else
echo "SHELL is not bash but $SHELL"
fi
# 注释
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


