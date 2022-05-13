#import pyautogui
#pyautogui.displayMousePosition()
import os 
import pathlib
from os import path
from typing import Counter
from PIL import Image


# Opens a image in RGB mode
i = 0 #記數順序
for path in pathlib.Path(r"C:\Users\yuyup\Python Ebook\Nouveau dossier").iterdir(): #文件目錄
    if path.is_file():
        im = Image.open(path, "r") #open then read = read 
#im = Image.open(r"C:\Users\yuyup\photoname.jpg')
# Setting the points for cropped image
        left = 554
        top = 6
        right = 1301
        bottom = 1078
# Cropped image of above dimension
# (It will not change original image)
        im1 = im.crop((left, top, right, bottom))
# Shows the image in image viewer
#im1.show()
#Save in the file 
#新增圖片儲存處
        i += 1
        count = i
        saveit = im1.save(r'C:\Users\yuyup\Python Ebook\Nouveau dossier\S'+str(count)+".jpg")




