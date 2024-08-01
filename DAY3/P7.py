#print the smallest and biggest sized strings from a list of N strings
# Input the number of strings in the list
n = int(input("Enter the number of strings in the list: "))

# Initialize an empty list to store the strings
strings = []

# Input the strings and add them to the list
for i in range(n):
    string = input(f"Enter string {i + 1}: ")
    strings.append(string)

# Initialize variables to store the smallest and biggest strings
# assuming the first string is both the smallest and the biggest
smallest = strings[0]
biggest = strings[0]

# Loop through the list to find the smallest and biggest strings
for string in strings:
    if len(string) < len(smallest):
        smallest = string
    if len(string) > len(biggest):
        biggest = string

# Output the result
print(f"The smallest string in the list is: '{smallest}' with length {len(smallest)}")
print(f"The biggest string in the list is: '{biggest}' with length {len(biggest)}")
