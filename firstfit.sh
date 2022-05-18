#!/bin/bash
block=(100 500 200 300 600)
echo "Blocks = " ${block[@]} 
process=(212 417 112 426) 
m=5
n=4
declare -a allocation 
i=0
while [ $i -lt $n ] 
do
allocation[$i]=-1 
i=$((i+1))
done 
j=0
while [ $j -lt $n ] 
do
k=0
while [ $k -lt $m ] 
do
if [ ${block[$k]} -ge ${process[$j]} ] 
then
allocation[$j]=$k 
block[$k]=$((block[$k]-process[$j])) 
break
fi 
k=$((k+1))
done 
j=$((j+1))
done
echo "Process No.	Process Size	Block No." 
a=0
while [ $a -lt $n ] 
do
if [ ${allocation[$a]} -ne -1 ] 
then
echo "  " $((a+1)) " " ${process[$a]} " " $((allocation[$a]+1)) 
else
echo "  " $((a+1)) " " ${process[$a]} "	Not Allocated "
fi 
a=$((a+1))
done
