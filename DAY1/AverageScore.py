average_score = int(input('Enter your average score to print the result: '))
if (average_score >= 0 and average_score <= 49):
    print('Result is Fail')
elif( average_score <=74):
    print('Result is Second class')
elif(average_score <= 90):
    print('Result is First class')
elif(average_score <= 100):
    print('Result is Distinction')
else:
    print('Invalid input enetered')
