#Count the number of Prime digits in a number
# Input from the user
number = input("Enter a number: ")

# Set of prime digits
prime_digits = {'2', '3', '5', '7'}

# Counter for prime digits
prime_count = 0

# Iterate through each character in the string representation of the number
for digit in number:
    if digit in prime_digits:
        prime_count += 1

# Print the result
print(f"The number of prime digits in {number} is: {prime_count}")
