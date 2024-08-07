def check_parentheses(parentheses):
    balance = 0
    pair_count = 0

    for char in parentheses:
            if char == '(':
                balance += 1
            elif char == ')':
               pair_count += 1 
               if balance > 0:
                   print("improper arrangement")
                   break
            else:
                 print('Invalid input')
        
                 if balance == pair_count:
    
                  return f"{pair_count} pairs"

n_paranthesis = input('Enter paranthesis: ')

check_parentheses(n_paranthesis)    
