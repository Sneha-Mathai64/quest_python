#magic mirror problems
original_str = input('Enter the original string: ')

rotated_str = input('Enter the rotated string: ')



temp_str = rotated_str * 2

if temp_str.find(original_str) != -1:

    print(f'{rotated_str} is rotated string of {original_str}')

else:

    print(f'{rotated_str} is Not rotated string of {original_str}')
