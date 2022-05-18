#!/bin/bash
pages=(7 0 1 2 0 3 0 4 2 3 0 3 2)
capacity=4 
count=0 
fault=0 
n=13
echo "frame1   frame2   frame3   frame4"
declare -a frames 
declare -a time 
i=0
while [ $i -lt $capacity ] 
do
frames[$i]=-1 
i=$((i+1))
done
j=0
while [ $j -lt $n ] 
do
flag1=0 
flag2=0 
k=0
while [ $k -lt $capacity ] 
do
if [ ${frames[$k]} -eq ${pages[$j]} ] 
then
count=$((count+1)) 
time[$j]=$count 
flag1=1
flag2=1 
break
fi 
k=$((k+1))
done
if [ $flag1 -eq 0 ] 
then
a=0
while [ $a -lt $capacity ] 
do
if [ ${frames[$a]} -eq -1 ] 
then
count=$((count+1)) 
fault=$((fault+1)) 
frames[$a]=${pages[$j]} 
time[$a]=$count
flag2=1 
break
fi
a=$((a+1)) 
done
fi
if [ $flag2 -eq 0 ] 
then
pos=0 
minimum=${time[0]} 
b=1
while [ $b -lt $capacity ] 
do
if [ ${time[$b]} -lt $minimum ] 
then
minimum=${time[$b]} 
pos=$b
fi 
b=$((b+1))
done
count=$((count+1)) 
fault=$((fault+1))
frames[$pos]=${pages[$j]} 
time[$pos]=$count
fi
echo ${frames[0]} "       " ${frames[1]} "      " ${frames[2]} "       " ${frames[3]} 
j=$((j+1))
done
echo "Total page faults = " $fault
