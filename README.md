# Autocrop
A short bash script that helps with batch editing image files written for use on a Mac.

## Background
I developed this script while working at Oakland Museum of California in collaboration with two colleagues to batch edit photonegatives. I was brought on to catalog and image Dorothea Lange's 50,000 negatives. As the negatives are stored in cold storage, I would process about 500 to 700 negatives at a time. 

### Image Setup
The negatives were imaged on a lightpad using a DSLR (Pentax K1) on a copystand. 

The negatives vary in format from 35mm to 4x5", and even within each format there are minor size variations. The negatives were not separated by film format or size. I needed a script that could edit based on something other than size (which could be done in Camera Raw, Photoshop, etc).   

## How It Works
This script uses ImageMagick mogrify program to crop a file and overwrite it. Since the lightpad background can be visually distinguished from the negative, this became the way to custom crop each negative based on color difference rather than size. 

    mogrify -background black -fuzz 60% -trim -deskew 20% +repage -type TrueColor *.tif
  
Various aspects of the code will be highlighted below. 

`-background black`: Sets the background color to black. 

`-fuzz 60%`: Adjusts what is considered black based on a percentage. 

`-trim`: Crop function.

`-deskew 20%`: Deskews the image. 

`+repage`: Resets the image virtual canvas to the actual image.

`-type TrueColor`: Force a TIFF image to be saved as a full color RGB.

`*.tif`: Sets the file format as .tif

## Mac Setup 
Download [Homebrew](https://brew.sh/ "Homebrew"). 

Use Homebrew to install [ImageMagic](https://imagemagick.org/ "ImageMagick"):

    brew install imagemagick

### File Structure 
This script relies on a particular file structure which described below so that users can replicate or adjust according to their own needs. 

#### Desktop/Crop
Desktop folder where partially-processed images are saved. These TIFF files have been previously inverted to positive, converted to black & white, flipped on the vertical edge, and have OMCA metadata appended to them in a custom Photoshop Action. Photoshop saves them to a subfolder within Crop called TIFF.   

#### Desktop/Processed
The script copies all files from the Crop folder to the Processed folder. Through the execution of the script, these TIFF files become the final reference-level TIFF files that get backed up to the server (as well as the Master DNG files). 
