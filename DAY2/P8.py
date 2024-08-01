# Input from the user
n = int(input("Enter the number of terms for the Fibonacci series: "))

# Initialize the first two terms
a, b = 1, 2

# Print the Fibonacci series
print("Fibonacci series:")
if n >= 1:
    print(a, end=" ")
if n >= 2:
    print(b, end=" ")

# Generate and print the rest of the terms
for _ in range(3, n + 1):
    c = a + b
    print(c, end=" ")
    a, b = b, c

print()
