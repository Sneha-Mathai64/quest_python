# Input from the user
n = int(input("Enter the value of n: "))
m = int(input("Enter the number of terms (m): "))

# Initialize the sum
sum_of_terms = 0

# Loop through the terms and calculate the sum
for i in range(0,m):
    term = (n ** i) * ((-1) ** i)
    sum_of_terms += term

# Output the result
print(f"The sum of the series for {m} terms is: {sum_of_terms}")

