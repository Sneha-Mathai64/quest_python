# Function to print Pascal's Triangle
def print_pascals_triangle(n):
    for i in range(n):
        # Print leading spaces
        for j in range(n - i - 1):
            print(" ", end="")
        
        # Calculate and print binomial coefficients
        num = 1
        for k in range(i + 1):
            print(num, end=" ")
            num = num * (i - k) // (k + 1)
        # Move to the next line
        print()

# Input from the user
n = int(input("Enter the number of lines for Pascal's Triangle: "))

# Call the function to print Pascal's Triangle
print_pascals_triangle(n)
