echo "This is a program to find greatest of 3 numbers"
echo "Enter 3 numbers"
read n1
read n2
read n3

echo "greatest number is:"
if [ $n1 -gt $n2 ] && [ $n1 -gt $n3 ]
then
    echo $n1
elif [ $n2 -gt $n1 ] && [ $n2 -gt $n3 ]
then
    echo $n2
else
    echo $n3
fi