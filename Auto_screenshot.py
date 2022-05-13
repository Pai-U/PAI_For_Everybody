#import pyautogui
#pyautogui.displayMousePosition()

import os
import sys
import time
from PIL import Image
from PIL import ImageGrab
import pyautogui

x = 0
SaveDirectory = r'C:\Users\yuyup\EXCELSTA'
for i in range (620):
    pyautogui.moveTo(1851,552,1)
    pyautogui.click()
    pyautogui.PAUSE=0.75
    img = ImageGrab.grab()
    x += 1
    saveas = os.path.join(SaveDirectory,'ScreenShot_P.'+str(x)+".jpg")
    #saveas = os.path.join(SaveDirectory,'ScreenShot_'+time.strftime("%Y-%m-%d_%H-%H-%M-%S")+".jpg")
    img.save(saveas)



#im = Image.open(r"C:\Users\yuyup\photoname.jpg')

     #   for eachphoto in path.is_file():
# Setting the points for cropped image
     #       left = 927
     #       top = 132
      #      right = 1583
     #       bottom = 1012
# Cropped image of above dimension
# (It will not change original image)
      #      im1 = im.crop((left, top, right, bottom))
 
# Shows the image in image viewer
#im1.show()

#Save in the file
     #       i = 0
      #      i += 1
     #       Count = i 
     #       saveit = im1.save(r'C:\Users\yuyup\Python Ebook\Python王者歸來'+str(Count)+'.jpg')



