
#Accept the food item number from the user and serve him the food.

food_items = {
    1 : 'Mysuru Filter Coffee',
    2 : 'Yummy Idly-vada',
    3 : 'Worlds soft Mysuru Mailari Dosa',
    4 : 'Bhupal Special Poha',
    5 : 'Bengaluru tamato-peanuts Upama'
}
print('Welcome to our hotel Rameshwaram Cafe')
print('1:Coffee 2:Idly-Vada 3:Dosa 4:Poha 5:Upama')
food_item_number = int(input('Enter the food item number that you wish:'))
if food_item_number < 1 or food_item_number > 5:
    print('Invalid choice entered')
else:
    print('Your ' + food_items.get(food_item_number) + ' is here')
print('Thank you, Visit again')
