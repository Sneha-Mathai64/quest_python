# Input a lowercase letter from the user
lowercase_letter = input("Enter a lowercase letter: ")

# Check if the input is a single lowercase letter
if len(lowercase_letter) == 1 and 'a' <= lowercase_letter <= 'z':
    # Convert to uppercase by subtracting the difference between 'a' and 'A'
    uppercase_letter = chr(ord(lowercase_letter) - ord('a') + ord('A'))
    print(f"The uppercase of '{lowercase_letter}' is '{uppercase_letter}'")
else:
    print("Input is not a valid lowercase letter")
