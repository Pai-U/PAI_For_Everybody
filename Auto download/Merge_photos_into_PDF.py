import os 
import pathlib
from os import path
from typing import Counter
from PIL import Image
from typing import List
from PIL import Image

for path in pathlib.Path(r"C:\Users\yuyup\lepoint").iterdir():
    if path.is_file():
        im = Image.open(path, "r") #open then read = read 
        im_list = [path]

im1 = Image.open(r'C:\Users\yuyup\lepoint\done\Capture d’écran 2021-08-26 220728.jpg', "r")
pdf1_filename = r"C:\Users\yuyup\lepoint\Capture d’écran 2021-08-26 220728.pdf"
im1.save(pdf1_filename, "PDF" ,resolution=100.0, save_all=True, append_images=im_list)
