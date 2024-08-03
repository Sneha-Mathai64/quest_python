# Program to create 1D Array (List) and find biggest and smallest numbers in it.



n = int(input('Enter size of the Array: '))



array = []

print(f'Enter {n} numbers of the Array')

for i in range(n):

    array.append(int(input()))



print('Array = ', array)

small_num = array[0]

big_num = array[0]



for i in range(1, n):

    if array[i] < small_num:

        small_num = array[i]

    if array[i] > big_num:

        big_num = array[i]

print(f'Biggest number in Array is {big_num}')

print(f'Smallest number in Array is {small_num}')
