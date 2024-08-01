# Function to find the second smallest digit in a number
def find_second_smallest_digit(number):
    # Initialize smallest and second smallest
    smallest = None
    second_smallest = None

    # Convert the number to a string
    number_str = str(number)

    # Iterate through each digit in the number
    for digit in number_str:
        # Convert digit to integer
        digit = int(digit)
        
        # Update smallest and second smallest
        if smallest is None or digit < smallest:
            second_smallest = smallest
            smallest = digit
        elif digit != smallest and (second_smallest is None or digit < second_smallest):
            second_smallest = digit

    # Return result
    if second_smallest is not None:
        return second_smallest
    else:
        return "Not enough unique digits"

# Prompt the user to enter a number
number = input("Enter a number: ")

# Check if the input is valid
if number.isdigit():
    result = find_second_smallest_digit(number)
    print(f"The second smallest digit in {number} is: {result}")
else:
    print("Invalid input. Please enter a valid number.")
