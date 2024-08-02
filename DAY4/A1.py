# Input string
input_string = "kerala-tiruvanantapuram karnataka-bengaluru tamilnadu-chennai"

# Initialize empty lists for states and capitals
states = []
capitals = []

# Split the input string by spaces to separate each state-capital pair
pairs = input_string.split()

# Iterate over each pair
for pair in pairs:
    # Split each pair by hyphen to separate state and capital
    state, capital = pair.split('-')
    # Append the state to the states list
    states.append(state)
    # Append the capital to the capitals list
    capitals.append(capital)

# Print the lists
print("States:", states)
print("Capitals:", capitals)
