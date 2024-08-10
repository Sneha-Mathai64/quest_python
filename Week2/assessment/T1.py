#Write a program to move a file in directory
# 'source' and copy it to 'destination'. 
# Handle necessary exceptions:
#1. if file does not exists in source, print "no file found in source".
#2. if same file already exists in target, print "file with same name already exists"


import shutil
import os
print(os.getcwd())
try:
    os.mkdir("source")
except:
    print("No file found in source")

try:
    os.mkdir("destination")
except:
    print("file with same name already exists")

file = open("source/NEWfile.txt","w")
file.close()

shutil.copyfile("source/Newfile.txt", "destination/file1.txt")
