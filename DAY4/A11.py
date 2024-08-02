def separate_states_and_capitals(input_data):
    # Split the input string by spaces to get state-capital pairs
    pairs = input_data.split(' ')

    # Initialize empty lists for states and capitals
    states = []
    capitals = []

    # Loop through each pair
    for pair in pairs:
        # Split each pair by '-' to separate state and capital
        state, capital = pair.split('-')
        # Append the state to the states list
        states.append(state)
        # Append the capital to the capitals list
        capitals.append(capital)

    # Return the lists of states and capitals
    return states, capitals

# Input string
input_data = "kerala-tiruvanantapuram karnataka-bengaluru tamilnadu-chennai"

# Call the function and get the result
states, capitals = separate_states_and_capitals(input_data)

# Output the lists
print("States:", states)
print("Capitals:", capitals)
