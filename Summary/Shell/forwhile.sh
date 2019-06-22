#!/usr/bin
s=100
s=$((s+2))
echo $s
while (($s < 130))
do
  echo $s
  s=$((s +2))
done

#不起作用
#p=135
#until (( $s -gt $p))
#do
#  echo $s
#  s=$((s + 1))
#done


