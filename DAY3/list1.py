def print_list(numbers):
    for element in numbers:
        print(element)

def modify_list1(numbers):
    for element in numbers:
        element = element + 1

def modify_list2(numbers):
    for i in range(len(numbers)):
        numbers[i] = numbers[i] - 1

numbers1 = [] # one way to create an empty list
numbers2 = list() # one way to create an empty list
numbers3 = [2, 4, '5', ['abc', 'xyz'], 5.5] # one way to create an list
# numbers4 = list(1, 2, 4, '7', 5.5) # one way to create an empty list
numbers5 = [1, 2, 4, 7, 5.5]
numbers4 = list(numbers5)
print_list(numbers4)
print('Numbers3 List is ', numbers3)
print('Before modification, numbers5 = ', numbers5)
print('Before modification, numbers4 = ', numbers4)
modify_list1(numbers5)
modify_list2(numbers4)
print('After modification, numbers5 = ', numbers5)
print('After modification, numbers4 = ', numbers4)

print('numbers3 2nd element = ', numbers3[1])
print('numbers3 4th element = ', numbers3[3])
print('numbers3 1st element in 4th element = ', numbers3[3][0])
