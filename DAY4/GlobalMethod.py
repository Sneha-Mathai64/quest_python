#Global methods and keywords:
numbers = [1, 2, 3, 4, 5]
del numbers[1:3]
print(numbers) # [1, 4, 5]
del numbers[1]
print(numbers) # [1, 5]
del numbers[:] # we are deleting all the elements from the list
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]  # Initial list
numbers.insert(10, 0)  # Inserting the element 0 at index 10
print(numbers)
#METHOD 1 OF ADDING
a = [1, 2, 3, 4, 5]  # Initial list
a.insert(len(a), 6)  # Inserting 6 at the end of the list
print(a)


