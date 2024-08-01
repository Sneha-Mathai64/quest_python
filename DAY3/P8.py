# Input the number of elements in the list
n = int(input("Enter the number of elements in the list: "))

# Initialize an empty list to store the numbers
numbers = []

# Input the numbers and add them to the list
for i in range(n):
    num = int(input(f"Enter number {i + 1}: "))
    numbers.append(num)

# Loop through the numbers list and remove negative numbers
i = 0
while i < len(numbers):
    if numbers[i] < 0:
        numbers.remove(numbers[i])  # Remove the negative number
    else:
        i += 1  # Move to the next element only if no removal occurred

# Output the result
print("The list of non-negative numbers is:", numbers)

