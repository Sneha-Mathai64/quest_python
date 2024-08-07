input1 = input("enter a value: ")
input2 = int(input("enter a number"))
try:
    print(print(" ".join([input1, input2])))
except TypeError:
    print(" Cannot add a string and an integer")
