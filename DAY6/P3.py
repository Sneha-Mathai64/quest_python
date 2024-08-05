import sys
import pdb
class Queue:

        def __init__(self, size = 5):

                self.queue = [] #create an empty list to impliment the Stack

                self.fp = -1

                self.rp = -1

                self.size = size

                print("An empty Queue of size ", size, " is created")



        def en_queue(self):

                if self.rp == self.size-1:

                        print("Queue is full")

                        return

                self.rp += 1

                self.queue.insert(self.rp, input("Enter data to be inserted: "))



        def de_queue(self):

                if self.fp == self.rp:

                        print("Queue is empty")

                        return

                self.fp += 1

                print("Deleted element is ", self.queue[self.fp])

                #self.queue.pop(self.fp)

                if self.fp == self.rp:

                        self.fp = self.rp = -1



        def display_Q(self):

                if self.fp == self.rp:

                        print("Queue is empty")

                        return

                print("Queue elements are: ", self.queue[self.fp+1:self.rp+1])



def invalid_choice():

        print("Invalid choie entered")



que = Queue(6)



que_oprs = {

        1 : que.en_queue,

        2 : que.de_queue,

        3 : que.display_Q,

        4 : sys.exit

}



choice = 0

while True:

        print("\n1:Insert 2:Delete 3:Display 4:Exit")

        choice = int(input("Enter your choice: "))

        que_oprs.get(choice, invalid_choice)()
