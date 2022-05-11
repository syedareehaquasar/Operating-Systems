#!/bin/bash    
sort () {
    for ((i=0; i <= $((${#arr[@]} - 2)); ++i))
    do
        for ((j=((i + 1)); j <= ((${#arr[@]} - 1)); ++j))
        do
            if [[ ${arr[i]} -lt ${arr[j]} ]]
            then
                # echo $i $j ${arr[i]} ${arr[j]}
                tmp=${arr[i]}
                arr[i]=${arr[j]}
                arr[j]=$tmp         
            fi
        done
    done
}
# arr=(6 5 68 43 82 60 45 19 78 95)
arr=(1 23 3)
# arr=($(for i in {0..9}; do echo $((RANDOM%100)); done))
echo ${arr[@]}
sort ${arr[@]}
echo ${arr[@]}