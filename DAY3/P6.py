#find the smallest and biggest element in a list of N numbers
# Input the number of elements in the list
n = int(input("Enter the number of elements in the list: "))

# Initialize an empty list to store the numbers
numbers = []

# Input the numbers and add them to the list
for i in range(n):
    num = int(input(f"Enter number {i + 1}: "))
    numbers.append(num)

# Initialize variables to store the smallest and biggest elements
smallest = numbers[0]
biggest = numbers[0]

# Loop through the list to find the smallest and biggest elements
for num in numbers:
    if num < smallest:
        smallest = num
    if num > biggest:
        biggest = num

# Output the result
print(f"The smallest element in the list is: {smallest}")
print(f"The biggest element in the list is: {biggest}")
