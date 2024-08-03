#to find maximum earning
#sort the prices in lowest to highest and sum first p prices
def max_earnings(price_of_shoes, p):
    negative_prices = []

    # iterate  through each price and collect negative prices
    for price in price_of_shoes:
        if price < 0:
            negative_prices.append(price)
    
    # Sort negative prices in ascending order (most negative price comes first)
    negative_prices.sort()
    
    # Take highest negative prices,list slicing 
    selected_prices = negative_prices[:p]
    
    # To calculate the total earning
    total_earnings = -sum(selected_prices)  # Convert negative sum to positive (earnings will be positive)
    
    return total_earnings

# input from the user
n = int(input("Enter the number of shoes: "))  # Number of shoes owner have
p = int(input("Enter max no shoes they can carry: "))
prices = [] #empty list to store the prices of shoes
print("Enter the price of shoes :")
for i in range(n):
    price = int(input())
    prices.append(price)

# Calculate and print the maximum earnings
print("Maximum earnings:", max_earnings(prices, p))

