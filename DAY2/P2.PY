#Find sum of Even placed digits in a number
# Input from the user
number = input("Enter a number: ")

# Initialize sum
sum_even_position_digits = 0

# Iterate over the digits and their indices
for index in range(len(number)):
    # Check if the position (index) is even
    if index % 2 == 0:
        # Convert the digit to an integer and add it to the sum
        sum_even_position_digits += int(number[index])

# Print the result
print(f"Sum of digits in even positions: {sum_even_position_digits}")

