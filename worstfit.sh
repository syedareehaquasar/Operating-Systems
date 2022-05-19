block=(100 500 200 300 600)
process=(212 417 112 426) 
echo "Blocks = " ${block[@]} 
declare -a allocation 
m=5
n=4
i=0
while [ $i -lt $n ] 
do
    allocation[$i]=-1 
    i=$((i+1))
done
j=0
while [ $j -lt $n ] 
do
    worstindex=-1 
    k=0
    while [ $k -lt $m ] 
    do
        if [ ${block[$k]} -ge ${process[$j]} ] 
        then
            if [ $worstindex -eq -1 ] 
            then
                worstindex=$k 
            else
                if [ ${block[$worstindex]} -lt ${block[$k]} ] 
                then
                    worstindex=$k
                fi
            fi
        fi
        k=$((k+1)) 
    done
    if [ $worstindex -ne -1 ] 
    then
        allocation[$j]=$worstindex 
        block[$worstindex]=$((block[$worstindex]-process[$j]))
    fi 
    j=$((j+1))
done
echo "Process No.	Process Size	Block No."
a=0
while [ $a -lt $n ] 
do
    if [ ${allocation[$a]} -ne -1 ] 
    then
        echo "  " $((a+1)) "	            " ${process[$a]} "	   " $((allocation[$a]+1))
    else
        echo "  " $((a+1)) "	            " ${process[$a]} "	Not Allocated"
    fi 
    a=$((a+1))
done
