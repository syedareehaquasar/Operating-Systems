echo "Program to find input is a string or a number"
echo "Enter the input to check: "
read n
echo "Given input is: "
if [[ $n =~ ^[0-9]*$ ]]
then
    echo "It's number"
else
    echo "Is a String"
fi
