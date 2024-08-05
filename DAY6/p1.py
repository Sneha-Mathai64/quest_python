def check_parentheses(p_str):
    stack = []
    pair_count = 0

    try:
        for char in p_str:
            if char == '(':
                stack.append(char)
            elif char == ')':
                if stack:
                    stack.pop()
                    pair_count += 1
                else:
                    raise ValueError("improper arrangement")
        
        if stack:
            raise ValueError("improper arrangement")
    except ValueError as e:
        return str(e)
    
    return f"{pair_count} pairs"

# Test cases
print(check_parentheses("((()()))"))  # Output: 4 pairs
print(check_parentheses("(()))"))     # Output: improper arrangement

    
    
