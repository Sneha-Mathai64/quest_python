import sys
Veg_food_items  = {
    1: 'mysuru filter coffee',
    2: 'yummy idly vada',
    3: 'mysuru mailari dosa',
    4: 'bhupal special poha',
    5: 'bengaluru tomato peanut upma'
    }
Non_Veg_food_items = {
    1: 'Egg pakoda',
    2: 'Chicken Biriyani',
    3: 'Fish Fry'
    }
food_type = {
    1: ' Veg_food_items ',
    2: 'Non_Veg_food_items '
    }
food_items = {
    1:'1: coffee 2: idly-vada 3:dosa 4: poha 5: upma',
    2:'1:Egg pokoda 2: Chicken biriyani 3: fish fry'
    }
print('welcome to Hotel THE TASTE ')
user_choice = int(input('1: Veg 2: Non-Veg\t your choice: '))
items = food_items.get(user_choice,'invalid')
if items == 'invalid':
    sys.exit('invalid choice entered')
    print(items)
food_item_number = int(input('Enter the food item number of your choice'))
print('your ' + food_type.get(user_choice).get(food_item_number) + ' is here ')
print('Thank You Visit Again')
    
