def min_deletions(string):
    deletions = 0
    for i in range(1, len(string)):
        if string[i] == string[i - 1]:
            deletions += 1
    return deletions

# Getting user input
string = input("Enter the string containing only characters A and B: ").strip()

# Validate input
if all(c in 'AB' for c in string):
    print("Minimum deletions required:", min_deletions(string))
else:
    print("Invalid input. Please enter a string containing only characters A and B.")

