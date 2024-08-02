def varArgFunction1(*arguments):

    print(arguments)

    # arguments[1] = 22 # TypeError

    arguments[5][0] = 20 # even though the list is inside the tuple, we can modify it.

    print(arguments)

    arguments[5].append(50)

    print(arguments)



varArgFunction1(1, 2, 4, 'list', 4.5, [2, 3, 5])
