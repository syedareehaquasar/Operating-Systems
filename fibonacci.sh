echo "How many Fibonacci series numbers do you want to list? "
read n
a=0
b=1
count=2
echo "Fibonacci series upto $n terms:"
echo $a
echo $b
while [ $count -le $n ]
do
fib=`expr $a + $b`
a=$b
b=$fib
echo $fib
count=`expr $count + 1`
done
