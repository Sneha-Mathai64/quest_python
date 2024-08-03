def minimum_loss(n, prices):
    min_price = prices[0]
    min_loss = float('inf')
    
    for i in range(1, n):
        current_price = prices[i]
        current_loss = current_price - min_price
        
        if current_loss < min_loss and current_loss < 0:
            min_loss = current_loss
        
        if current_price < min_price:
            min_price = current_price
    
    print(min_loss)

# Read input
n = int(input())
prices = list(map(int, input().split()))

# Call the function to calculate the minimum loss
minimum_loss(n, prices)

