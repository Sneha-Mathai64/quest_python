#Print a hollow square of n line with the diagonals.
# Input from the user
n = int(input("Enter the number of lines for the hollow square with diagonals: "))

# Print the hollow square with diagonals
for i in range(n):
    for j in range(n):
        # Print stars on the borders or diagonals
        if i == 0 or i == n - 1 or j == 0 or j == n - 1 or j == i or j == n - i - 1:
            print("*", end="")
        else:
            print(" ", end="")
    # Move to the next line after finishing the current row
    print()
