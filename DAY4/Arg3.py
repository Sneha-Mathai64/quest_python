def varArgFunction(*arguments): # receives the data into a tuple. However, if it has objects like list or dictionary, then they will received by reference only.
    print(arguments)
   
def myFunction(user_given_list): # receives refrence to the list numbers2
    user_given_list.remove(35)

numbers1 = []
input_string = input("Enter numbers separated by commas: ")
input_list = input_string.split(',')

for num in input_list:
    try:
        numbers1.append(int(num))
    except ValueError:
        print(f"'{num}' is not a valid integer and will be skipped.")

print(numbers1)

# input: 10,20,30,40,50
print(numbers1)
varArgFunction(numbers1)# the list here is passed by reference
print(numbers1)

numbers2 = list(map(int, input().split()))
print(numbers2)
myFunction(numbers2)
print(numbers2)
