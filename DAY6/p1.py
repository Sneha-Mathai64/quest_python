def check_parentheses(paranthesis):

    count1=0

    count2=0

    for i in range(len(paranthesis)):

        if paranthesis[i] == '(':

            count1 += 1

        elif paranthesis[i] == ')':

            count2 += 1

            if count2 > count1 :

                print('Improper arrangement')

                break

        else:

            print('Invalid input')

   

    if count1 == count2:

        return print(f'{count1} pairs')

     

n_paranthesis = input('Enter paranthesis: ')

check_parentheses(n_paranthesis)    
    
