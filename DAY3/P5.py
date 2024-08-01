#program that accept n numbers from the user and swap the consecutive elements in the list
#Input from the user
n = int(input("Enter the number of elements: "))

# Initialize an empty list
numbers = []

# Accept n numbers from the user
for i in range(n):
    num = int(input(f"Enter number {i+1}: "))
    numbers.append(num)

print("Original list:", numbers)

# Swap consecutive elements
for i in range(0, n - 1, 2):
    # Swap elements at index i and i+1
    numbers[i], numbers[i+1] = numbers[i+1], numbers[i]

print("List after swapping consecutive elements:", numbers)
