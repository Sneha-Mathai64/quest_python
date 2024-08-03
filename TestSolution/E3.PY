#segregate the random data and obtain only characters data and process them in a meaningful way
def extract_characters(input_string):
    filtered_string = ""
    for char in input_string:
        if char.isalpha():
            filtered_string += char
    return filtered_string

# Prompt user for input
user_input = input("Enter a string with characters and special characters: ")
output_string = extract_characters(user_input)
print("Filtered String:", output_string)
