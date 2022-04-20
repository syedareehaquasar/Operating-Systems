echo "Program to find number is Prime or Composite"
echo "Enter the number to check: "
read n
echo "Number is: "
for((i = 2; i * i <= n; i++))
do
    if [ $((n % i)) == 0 ]
    then
        echo "Composite"
        exit
    fi
done
echo "Prime"