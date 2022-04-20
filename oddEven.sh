echo "Program to find number is Odd or Even"
echo "Enter the number to check: "
read n
echo "Number is: "
if [ `expr $n % 2` == 0 ]
then
    echo "Even"
else
    echo "Odd"
fi