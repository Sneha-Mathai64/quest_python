#Print a hollow square of n lines
# Input from the user
n = int(input("Enter the number of lines for the hollow square: "))

# Print the hollow square
for i in range(n):
    if i == 0 or i == n - 1:
        # Print the border (top and bottom lines)
        print("*" * n)
    else:
        # Print the sides (hollow lines)
        print("*" + " " * (n - 2) + "*")
