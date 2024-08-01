# Input from the user
number = int(input("Enter a number: "))

# A flag variable to check if the number is prime
is_prime = True

# 0 and 1 are not prime numbers
if number <= 1:
    is_prime = False
else:
    # Check from 2 to number-1
    for i in range(2, number):
        if number % i == 0:
            is_prime = False
            break

# Output the result
if is_prime:
    print(f"{number} is a prime number.")
else:
    print(f"{number} is not a prime number.")
