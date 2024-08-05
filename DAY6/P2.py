import pdb

import math



pdb.set_trace()  # To run the code in debugger mode  



def find_nth_fibo_term(n):

    thrid_number = 0

    first_number  = 1

    second_number = 2  

    if n == 1:

        thrid_number = 1

    elif n == 2:

        thrid_number = 2

    else:

        thrid_number  = 0

        count = 2

        while count <= n:

            thrid_number = first_number + second_number

            count += 1

            if count == n:

                return thrid_number

            first_number = second_number

            second_number = thrid_number

    return thrid_number



def check_if_prime(num):

    for i in range(2, math.ceil(math.sqrt(num))+1):

        if num % i == 0:

            return False

    return True



def find_nth_prime_term(input_number):

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

    return j



nth_term = int(input ("Enter N to print the Nth term of Combined series: "))

term = 0

if nth_term % 2 == 0:

    term = find_nth_prime_term(nth_term // 2)

else:

    term = find_nth_fibo_term(nth_term // 2 + 1)



print(f'{nth_term}th term of combined series is {term}')
