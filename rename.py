# rename files

import os
import os
cwd = os.getcwd()

print ("CWD" + str(cwd))

print("")
for item in os.listdir('.'):
    if (os.path.isfile(item)):
        print("IS FILE: " + str(item))
    if (os.path.isdir(item)):
        print("IS DIR: " + str (item))
    

# os.rename('a.txt', 'b.kml')