function sem_wait(){ 
    while [ $1 -le 0 ]
    do
        $1=$(($1-1))
    done
}

function signal(){
    result=$(($1+1))
}

x=1 y=1 z=1
wsem=1 rsem=1 readcount=0 writecount=0 var=5

function reader(){
    echo "----------------------------"
    echo "reader " $1 " is reading"
    sem_wait $z 
    sem_wait $rsem
    sem_wait $x
    readcount=$((readcount+1))
    if [ $readcount -eq 1 ]
    then
        sem_wait $wsem
    fi
    signal $x
    signal $rsem
    signal $z
    echo "Updated value = " $var
    sem_wait $x
    readcount=$((readcount-1))
    if [ $readcount -eq 0 ] 
    then
        signal $wsem
    fi
    signal $x
}
 
function writer(){
    echo
    echo "writer " $1 " is writing"
    sem_wait $y
    writecount=$((writecount+1))
    if [ $writecount -eq 1 ]
    then
        sem_wait $rsem
    fi
    signal $y
    sem_wait $wsem
    var=$((var+5))
    signal $wsem
    sem_wait $y
    writecount=$((writecount-1))
    if [ $writecount -eq 0 ]
    then
        signal $rsem
    fi
    signal $y
}

reader 0
writer 0
reader 1
reader 2
reader 3
writer 3
reader 4
