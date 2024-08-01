# Input from the user
n = int(input("Enter the value of n (1 <= n <= 5): "))
m = int(input("Enter the number of terms (2 < m < 10): "))

# Initialize the sum
sum_series = 0

# Validate inputs
if 1 <= n <= 5 and 2 < m < 10:
    # Loop through the terms and calculate the sum
    for i in range(m):
        term = (n ** (2 ** i)) / (2 * i + 1)
        if i % 2 == 0:
            sum_series += term
        else:
            sum_series -= term

    # Output the result
    print(f"The sum of the series for {m} terms is: {sum_series}")
else:
    print("Invalid input. Ensure 1 <= n <= 5 and 2 < m < 10.")
