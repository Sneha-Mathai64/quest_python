term_number = int(input ("Enter N to print the Nth Fibo term: "))  



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



if term_number <= 0:  

    print ("Please enter a positive integer, the given number is not valid")

else:

    print (f'The {term_number}th Fibo number is ', find_nth_fibo_term(term_number))
