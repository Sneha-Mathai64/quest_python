#Program to check if a number is Prime if then print nth prime number

import math



def check_if_prime(num):

    for i in range(2, math.ceil(math.sqrt(num))+1):

        if num % i == 0:

            return False

    return True



input_number = int(input('Enter the number N, to print Nth Prime number: '))



j = 0

if input_number == 1:

    j = 2

elif input_number == 2:

    j = 3

else:

    count = 2

    j = 4 #Number in J is checked if Prime or not

    while count <= input_number:

        if check_if_prime(j):

            count += 1

        if count == input_number:

            break

        j += 1

print(f'{input_number}th Prime number is {j}')
