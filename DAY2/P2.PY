# Function to find the sum of even-placed digits
def sum_even_placed_digits(number):
    # Convert the number to a string
    number_str = str(number)
    # Initialize the sum
    sum_even_places = 0
    # Loop through the digits by their index
    for index, digit in enumerate(number_str):
        # Check if the index is even (0-based indexing)
        if index % 2 == 0:
            # Add the digit to the sum (convert to integer)
            sum_even_places += int(digit)
    return sum_even_places

# Example usage
number = input("Enter a number: ")
result = sum_even_placed_digits(number)
print(f"Sum of even-placed digits in {number}: {result}")
