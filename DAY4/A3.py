# function to check if words are palindromes and count them
def check_palindromes(word_list):  
    palindrome_count = 0
    for word in word_list:
        if word[::-1] == word:
            palindrome_count += 1
    print("Number of palindrome words is:", palindrome_count)

input_words = [word for word in input("Enter the words to check if they are palindromes, separated by spaces: ").split(' ')]
check_palindromes(input_words)
