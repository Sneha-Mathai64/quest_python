name = 'Cambodia' # Initialize the string variable

names = ['aizwal', 'imphal', 'shillong', 'agartala']# Initialize the list of names
print(name)# Print the original string

print(name.upper())# Convert the string to uppercase and print it

print(name.count('a'))# Count the number of occurrences of lowercase 'a' in the string and print it

print(name.count('A'))# Count the number of occurrences of uppercase 'A' in the string and print it

print(name.upper().count('A'))# Convert the string to uppercase and count the occurrences of 'A' (which is now uppercase) and print it

print(name.upper().count('a'))# Convert the string to uppercase and count the occurrences of lowercase 'a' (which is now not present) and print it

print(name.find('o'))# Find the index of the first occurrence of 'o' in the string and print it

print(name.find('dia'))# Find the starting index of the substring 'dia' in the string and print it

print(name.find('xx'))#returns -1 because the strings  starting index of the substring 'xx' in the string, which is not present
