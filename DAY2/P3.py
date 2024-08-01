# Prompt the user to enter a number
number = input("Enter a number: ")

# Check if the input is valid
if number.isdigit():
    # Find the largest digit
    largest_digit = max(number)
    # Print the result
    print(f"The largest digit in {number} is: {largest_digit}")
else:
    print("Invalid input. Please enter a valid number.")
