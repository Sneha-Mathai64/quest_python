customer_name = input("Enter you name :")
customer_age  = int(input("Enter age: "))
customer_gender = input("Enter your gender\nM.male\nF. Female \n Enter your choice: ").lower()
customer_occupation = input("Enter your occupation\nS.student\nW. working\n Enter your choice: ").lower()
customer_pin_code   = [10001,10002,10003,10004]
customer_residence_pin = int(input("Enter the residence pincode"))
customer_residence  = input("Enter your residence\nH. hosteller\nL.locallite\n Enter your choice : ").lower()

#priority levels: Age - Low, Occupation- Med , Residency-High
 #senior citizen male 

if(customer_age >= 60 and customer_gender == "m"):
    if(customer_occupation == "s"):
        print("Person not elgible for any discounts")
    elif(customer_occupation == "w"):
        if(customer_residence == "h"):
            print("10% discount on grocery")
        elif(customer_residence == "l"):
            printf("15% discount on all products")
        else:
            printf("Error : invalid residence input")

    else:
        print("Error: invalid customer occupational input" )

#senior citizen female

elif(customer_age >= 45 and customer_gender == "f"):
    if(customer_occupation == "s"):
        print("Person not elgible for any discounts")
    elif(customer_occupation == "w"):
        if(customer_residence == "h"):
            print("10% discount on grocery")
        elif(customer_residence == "l"):
            printf("15% discount on all products")
        else:
            printf("Error : invalid residence input")

    else:
        print("Error: invalid customer occupational input" )

#male under the age 60

elif(customer_age < 60 and customer_gender == "m"):
    if(customer_occupation == "s"):
        print("eligible for coupons of books,Thank you for shopping")
    elif(customer_occupation == "w"):
        if(customer_residence == "h"):
            print("10% discount on grocery,Thank you for shopping")
        elif(customer_residence == "l"):
            printf("Discount on coupon fastrack,Thank you for shopping")
        else:
            printf("Error : invalid residence input,Thank you for shopping")

    else:
        print("Error: invalid customer occupational input" )

        #female under the age 45
elif(customer_age < 45 and customer_gender == "f"):
    if(customer_occupation == "s"):
        print("eligible for coupons of books,Thank you for shopping")
        if(customer_residence_pin in customer_pin_code):
             print("eligible for discount worth 500 off on books,thanks for shopping ")
        else:
            pass
    elif(customer_occupation == "w"):
        if(customer_residence == "h"):
            print("10% discount on grocery,Thank you for shopping")
        elif(customer_residence == "l"):
            printf("100 rupees discount on nykaa,Thank you for shopping")
        else:
            printf("Error : invalid residence input,Thank you for shopping")

    else:
        print("Error: invalid customer occupational input,Thank you for shopping" )

# elif(customer_occupation == "s"and customer_age < 45 ):
#     if(customer_residence_pin in customer_pin_code):
#         print("eligible for discount worth 500 off on books,thanks for shopping ")
#     else:
#         print("not eligible for discount")
else:
    print("invalid customer age and gender,Thank you for shopping")