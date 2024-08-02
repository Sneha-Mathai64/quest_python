# Accept N strings, and check howmany of them possess the string X
def count_strings_with_substring(strings, substring):
    #Function to count how many strings in the list contain the given substring."""
    count = 0
    for string in strings:
        if substring in string:
            count += 1
    return count

def main():
 #Main function to get input from the user and call the counting function."""
    N = int(input("Enter the number of strings: "))
    strings = []
    for i in range(N):
        strings.append(input(f"Enter string {i+1}: "))
    
    X = input("Enter the substring to check: ")
    count = count_strings_with_substring(strings, X)
    print(f"Number of strings containing '{X}': {count}")

# Call the main function directly
main()
