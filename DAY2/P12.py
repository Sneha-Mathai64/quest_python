#Print X shape made up of stars of n lines
# Input from the user
n = int(input("Enter the number of lines for the X shape (odd number): "))

# Ensure n is an odd number
if n % 2 == 0:
    print("Please enter an odd number.")
else:
    # Print the X shape
    for i in range(n):
        for j in range(n):
            if j == i or j == n - i - 1:
                # Print stars on the diagonals
                print("*", end="")
            else:
                # Print spaces
                print(" ", end="")
        # Move to the next line after finishing the row
        print()
