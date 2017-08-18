#!/bin/bash

# Keyboard Input And Arithmetic

### -t number => timeout
### -s => hide context

echo -n "Hurry up and type something! > "
if read -st 3 response; then
    echo "Great, you made it in time! $response"
else
    echo "Sorry, you are too slow!"
fi

### Arithmetic
first_num=0
second_num=0

echo -n "Enter the first number --> "
read first_num
echo -n "Enter the second number -> "
read second_num

echo "first number + second number = $((first_num + second_num))"
echo "first number - second number = $((first_num - second_num))"
echo "first number * second number = $((first_num * second_num))"
echo "first number / second number = $((first_num / second_num))"
echo "first number % second number = $((first_num % second_num))"
echo "first number raised to the"
echo "power of the second number   = $((first_num ** second_num))"

number=0

echo -n "Enter a number > "
read number

echo "Number is $number"
if [ $((number % 2)) -eq 0 ]; then
    echo "Number is even"
else
    echo "Number is odd"
fi
