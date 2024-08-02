
# Find the nth term of the series 1 2 2 3 3 5 5 7 8 11 13 13
import math


def nth_fibo_term(n):   # Function for get the nth fibo term
    thrid_number = 0
    first_number  = 1
    second_number = 2  
    if n == 1:           # The first and second term of fibo series is 1 & 2 so we can    directly give the terms
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

##########################################################################################

def check_if_prime(num):           # Function to check if the given number is prime or not
    for i in range(2, math.ceil(math.sqrt(num))+1):
        if num % i == 0:
            return False
    return True

###########################################################################################

def last_prime(term_number):     # Function to get the last prime term
    j = 0
    if term_number == 1:
        j = 2
    elif term_number == 2:
        j = 3
    else:
        count = 2
        j = 4                   #Number in J is checked if Prime or not
        while count <= term_number:
            if check_if_prime(j):
                count += 1
            if count == term_number:
                break
            j += 1
    return j

