pages=(7 0 1 2 0 3 0 4 2 3 0 3 2)
capacity=4
count=0
fault=0
n=13
echo "frame1   frame2   frame3   frame4"
declare -a frames 
i=0
while [ $i -lt $capacity ] 
do
    frames[$i]=-1 
    i=$((i+1))
done 
j=0
while [ $j -lt $n ] 
do
    flag=0
    k=0
    while [ $k -lt $capacity ] 
    do
        if [ ${frames[$k]} -eq ${pages[$j]} ] 
        then
            flag=1 
            fault=$((fault-1))
        fi
        k=$((k+1)) 
    done 
    fault=$((fault+1))
    if [ $fault -le $capacity ] && [ $flag -eq 0 ] 
    then
        frames[$j]=${pages[$j]} 
    else if [ $flag -eq 0 ] 
    then
        frames[$(( (fault-1)%capacity))]=${pages[$j]}
    fi
    fi
    echo ${frames[0]} "    " ${frames[1]} "    " ${frames[2]} "    " ${frames[3]} 
    j=$((j+1))
done
echo "Total page faults = " $fault
