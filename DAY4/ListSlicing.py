numbers = [2, 9, 7, 5, 3, 13, 19, 17, 29]
# we get the complete list
print(numbers)
# we get the 1st element
print(numbers[0])
# we get the last element
print(numbers[-1])
# we get last but element from the list
print(numbers[-2])
# we get the complete list
print(numbers[:])
# Start from index 0 and access elements up to index 3-1 which is 2.
print(numbers[:3])
# Start from index 1 (2nd element) and access elements up to last but element, because -1 is the index of last element and we must not include it.
print(numbers[1:-1])
# start from index 1 and access upto index 8-1 and increment each time by 2 elements. So o/p is [9, 5, 3, 19]
print(numbers[1:8:2])
# start from biginning and go up to end of the list with increment of 3
print(numbers[::3])
#Start from index 8, go up to index 2 with decrement of 2 (or increment of -2)
print(numbers[8:1:-2])
# Since the increment is negative, we understand that we have to move in reverse (meaning from the end to towards the start). The area within the list we have to access is all the elements, because nothing is specified before and after the 1st colon :
print(numbers[::-1])
print(numbers[::-3])
print(numbers[:1:-3])
print(numbers[1:8:-2])
numbers = [1,2,3,5]

print(numbers[:1:-2])
