# Program to create a 3D Array

'''

1st read elements of a row

add these rows into the Matrix

Now read such N matrices and add them all to the 3D Array

'''

matrices = int(input('Enter the number of Matrices in 3D array: '))

rows = int(input('Enter number of rows of each Matrix: '))

columns = int(input('Enter number of columns of each row: '))

array_3d = []

for i in range(matrices):

    matrix = []

    print(f'Enter elements of the Matrix-{i+1}')

    for j in range(rows):

        row = []

        for k in range(columns):

            row.append(int(input()))

        matrix.append(row)

    array_3d.append(matrix)

print('3D MATRIX IS :')

for row in array_3d:

    for number in row:

        print('%3s'%(number), end='')

    print()

print(array_3d)
