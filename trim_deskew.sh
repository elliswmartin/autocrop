#!/bin/bash -x

mv ~/Desktop/Crop/TIFF/* ~/Desktop/Crop/

# copy files from source to destination
cp ~/Desktop/Crop/* ~/Desktop/Processed/

echo Files copied. Now going to work !

cd ~/Desktop/Processed/

# trim and deskew images using ImageMagick
mogrify -background black -fuzz 60% -trim -deskew 20% +repage -type TrueColor *.tif

echo Trim and Deskew complete. Renaming now.

# rename string indicating edit level within filename
for file in *.tif
do
  mv "$file" "${file/J1/J2}"
done

echo Processing completed. 

# to run in terminal:
# </path/to/your/script/>/trim_deskew.sh

