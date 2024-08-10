


import shutil
import os
print(os.getcwd())
os.mkdir("A")
os.mkdir("B")
file = open("A/my_file.txt", "x")
file.close()

shutil.copyfile("A/my_file.txt", "B/my_files.txt")
