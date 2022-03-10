#!/bin/bash
echo "This is a program to find greatest of 3 numbers"
echo "Enter 3 numbers"
read a
read b
read c

echo "greatest number is:"

if [ $a -gt $b ] && [ $a -gt $c ]
then
    echo $a
elif [ $b -gt $a ] && [ $b -gt $c ]
then
    echo $b
else
    echo $c
fi
