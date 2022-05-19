pages=(7 0 1 2 0 3 0 4 2 3 0 3 2)
capacity=4
fault=0
n=13
declare -a frames 
declare -a temp i=0
echo "frame1   frame2   frame3   frame4"
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
                fault=$((fault+1)) 
                frames[$a]=${pages[$j]} 
                flag2=1
                break
            fi 
            a=$((a+1))
        done
    fi
    if [ $flag2 -eq 0 ] 
    then
        flag3=0
        x=0
        while [ $x -lt $capacity ] 
        do
            temp[$x]=-1 
            y=$((j+1))
            while [ $y -lt $n ] 
            do
                if [ ${frames[$x]} -eq ${pages[$y]} ] 
                then
                    temp[$x]=$y 
                    break
                fi
                y=$((y+1))
            done
            x=$((x+1))
        done
        z=0
        while [ $z -lt $capacity ] 
        do
            if [ ${temp[z]} -eq -1 ] 
            then
                pos=$z flag3=1 
                break
            fi 
            z=$((z+1))
        done
        if [ $flag3 -eq 0 ] 
        then
            maximum=${temp[0]} 
            pos=0
            w=0
            while [ $w -lt $capacity ] 
            do
                if [ ${temp[$w]} -gt $maximum ] 
                then
                    maximum=${temp[$w]} 
                    pos=$w
                fi
                w=$((w+1)) 
            done
        fi
        frames[$pos]=${pages[$j]} 
        fault=$((fault+1))
    fi
    echo ${frames[0]} "    " ${frames[1]} "    " ${frames[2]} "    " ${frames[3]} 
    j=$((j+1))
done
echo "Total page faults = " $fault
