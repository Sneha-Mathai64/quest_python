#write a code to demonstrate use of inheritance and polymorphism using below example:
#1. Eatable
#1.1 Vegetarian
#1.2 Non-Vegetarian

#properties to be used: carbs, fat, protein, isPeelable, isBoneless

#Place appropriate properties in parent class or child class and assign the values in __init__

class Eatable:
    def __init__(self, carbs, fat, protein):
        self.carbs = carbs
        self.fat = fat
        self.protein = protein

class Vegetarian(Eatable):
    def __init__(self, carbs, fat, protein, isPeelable):
        Eatable.__init__(self, carbs, fat, protein) 
        self.isPeelable = isPeelable

class Non_Vegetarian(Eatable):
    def __init__(self, carbs, fat, protein, isBoneless):
        Eatable.__init__(self, carbs, fat, protein, isBoneless)
        self.isBoneless = isBoneless
veg1 = Vegeterian()
NonVeg1 = NonVegeterian()
