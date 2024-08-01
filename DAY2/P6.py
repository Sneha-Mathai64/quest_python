# Input from the user
n = int(input("Enter the number of lines for the equilateral triangle: "))

# Loop to print each line of the triangle
for i in range(1, n + 1):
    # Print leading spaces
    for j in range(n - i):
        print(" ", end="")
    
    # Print stars
    for k in range(2 * i - 1):
        print("*", end="")
    
    # Move to the next line
    print()
