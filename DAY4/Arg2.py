def varArgFunction(*arguments): # receives the data into a tuple. However, if it has objects like list or dictionary, then they will received by reference only.

    print(arguments)

    arguments[0].remove(10)



def myFunction(user_given_list): # receives refrence to the list numbers2

    user_given_list.remove(35)



numbers1 = [int(num) for num in input().split(',')]

# input: 10,20,30,40,50

print(numbers1)

varArgFunction(numbers1)# the list here is passed by reference

print(numbers1)



numbers2 = list(map(int, input().split()))

print(numbers2)

myFunction(numbers2)

print(numbers2)

 
