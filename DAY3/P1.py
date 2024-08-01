#Program to print X shape inside a hollow Square



print('Program to print X shape inside Hollow Square')

number_of_lines = int(input('Enter the number of lines: '))

for i in range(number_of_lines):

    for j in range(number_of_lines):

        if i == 0 or i == number_of_lines-1 or j == 0 or j == number_of_lines-1 or i == j or j == number_of_lines-i-1:

            print('* ', end='')

        else:

            print('  ', end='')

    print()
