def create_matrix(numbers, rows):
    """Create a matrix from a list of numbers with a specified number of rows."""
    matrix = []
    index = 0
    for _ in range(rows):
        row = []
        for _ in range(len(numbers) // rows):
            row.append(numbers[index])
            index += 1
        matrix.append(row)
    return matrix

def print_matrix(matrix):
    """Print the matrix row-wise."""
    for row in matrix:
        print(' '.join(map(str, row)))

def main():
    # Get input from the user
    input_string = input("Enter a space-separated string of numbers: ")
    numbers = list(map(int, input_string.split()))
    
    # Get the number of rows
    rows = int(input("Enter the number of rows for the matrix: "))
    
    # Calculate the number of columns
    cols = len(numbers) // rows
    
    if len(numbers) % rows != 0:
        print("Error: The total number of numbers is not divisible by the number of rows.")
        return

    # Create and print the matrix
    matrix = create_matrix(numbers, rows)
    print("The matrix is:")
    print_matrix(matrix)

# Call the main function to execute the program
main()


