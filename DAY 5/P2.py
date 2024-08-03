# Program to create 2D Array, that is, a Matrix(using List) and add it to another Matrix and print the sum Matrix.



rows = int(input('Enter number of rows of the Matrix: ')) #enter the number of rows


columns = int(input('Enter number of columns of the Matrix: ')) #enter the no of columns



matrix1 = [] # create an empty matrix to store 

for i in range(rows): #the loop iterates through rows 

    print(f'Enter {columns} numbers of Row-{i+1}')  #enter first column first row in first iteration and so on

    row_numbers = [] # List that stores numbers of a specific row  

    for j in range(columns): # To read numbers of a row

        row_numbers.append(int(input()))#appending next rows

    matrix1.append(row_numbers) #adding to matrix one



for row in matrix1: #to print ths matrix

    for number in row: #loop to print each number in the row

        print('%3s'%(number), end='') #print each number with a width of 3 characters ,without a newline

    print()#print a newline after each row is completed



rows = int(input('Enter number of rows of the Matrix2: '))

columns = int(input('Enter number of columns of the Matrix2: '))



matrix2 = []

for i in range(rows):

    print(f'Enter {columns} numbers of Row-{i+1}')

    row_numbers = [] # List that stores numbers of a specific row

    for j in range(columns): # To read numbers of a row

        row_numbers.append(int(input()))

    matrix2.append(row_numbers)



print('Matrix1 is:')

for row in matrix1:

    for number in row:

        print('%3s'%(number), end='')

    print()



print('Matrix2 is:')

for row in matrix2:

    for number in row:

        print('%3s'%(number), end='')

    print()



sum_matrix = []

for i in range(len(matrix1)):

    row_numbers = []

    for j in range(len(matrix1[0])):

        row_numbers.append(matrix1[i][j] + matrix2[i][j])

    sum_matrix.append(row_numbers)



print('Sum Matrix is:')

for row in sum_matrix:

    for number in row:

        print('%3s'%(number), end='')

    print()

