import os
from time import sleep

path = r"C:\Users\L12X17W33\Documents\TASM"

while True:
    for i in os.listdir(path):
        if not i.endswith(".LOG"):
            continue
        print("\n\n")
        with open(path + '\\' + i, "r") as r:
            print(r.read())
        os.remove(path + '\\' + i)
    sleep(1)