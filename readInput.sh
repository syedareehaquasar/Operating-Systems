IFS=$'\n'
for line in $(cat ./input.txt)
do
    IFS=" "
    var=($line)
    echo $line
    echo ${var[0]}
done