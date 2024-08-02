#Accept N main strings and N sub strings into lists and check create a list of numbers of 0s and 1s where 0 represents that the sub string at respective index is not a substring of the main string.
 
#main_list = ['andhra pradesh', 'kerala', 'maharashtra', 'haryana']
#sub_list  = ['pradesh', 'south', 'rashtra', 'punjab']
#presence = [1, 0, 1, 0]

def check_sub_string(strings, subs):
    #Function to check how many of the main strings contain their corresponding substring."""
    count = []
    for i in range(len(strings)):
        if subs[i] in strings[i]:
            count.append(1)
        else:
            count.append(0)
    print("The presence of sub strings in the main strings is", count)

# Main code to get input from the user
strings = input("Enter the main strings separated by commas: ").split(',')
subs = input("Enter the sub strings separated by commas: ").split(',')

# Check if the lengths of both lists are the same
if len(strings) != len(subs):
    print("Error: The number of main strings and sub strings must be the same.")
else:
    check_sub_string(strings, subs)
