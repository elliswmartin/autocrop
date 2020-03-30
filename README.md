# Autocrop
A short bash script that helps with batch editing image files based on background color. Written for Mac.

## How It Works
This script uses ImageMagick mogrify program to crop a file and overwrite it. Since the lightpad background can be visually distinguished from the negative, this became the way to custom crop each negative based on color difference rather than size. 

    mogrify -background black -fuzz 60% -trim -deskew 20% +repage -type TrueColor *.tif
  
Various aspects of the code will be highlighted below. 

`-background black`: Sets the background color to black. 

`-fuzz 60%`: Adjusts what is considered black based on a percentage. 

`-trim`: Crop function.

`-deskew 20%`: Deskews the image. 

`+repage`: Resets the image virtual canvas to the actual image.

`-type TrueColor`: Forces TIFF image to be saved as a full color RGB.

`*.tif`: Sets the file format as TIFF

To distinguish levels of editing within variations of files, OMCA historically uses a scale of 1-3 paired with a letter that distinguishes individual imaging equipment. The for loop below renames the files from J1 to J2 to note the additional editing. 

    for file in *.tif
    do
      mv "$file" "${file/J1/J2}"
    done

## Usage (Mac Only)
1. Make sure you have Homebrew and ImageMagick installed. 

Download [Homebrew](https://brew.sh/ "Homebrew"). 

Use Homebrew to install [ImageMagick](https://imagemagick.org/ "ImageMagick"):

    $ brew install imagemagick

1. This script ships assuming the following folder structure. You are welcome to modify this for your needs within the /trim_deskew.sh script.

        ├── Desktop
        │   ├── Crop
        │   ├── Processed

1. Add your images to be processed into the "/Desktop/Crop" folder.

1. Open Terminal and navigate to the location of the /trim_deskew.sh script:

        $ cd <path/to/autocrop/folder>

1. Run the script. Trimmed and deskewed images will appear in the "/Desktop/Processed" folder.

        $ trim_deskew.sh

## Background
I developed this script while working at Oakland Museum of California in collaboration with two colleagues to batch edit photonegatives. I was brought on to catalog and image Dorothea Lange's 50,000 negatives. As the negatives are stored in cold storage, I would process about 500 to 700 negatives at a time. 

### Image Setup
The negatives were staged on a lightpad and imaged using a DSLR (Pentax K1) mounted on a copystand. 

The negatives vary in format from 35mm to 4x5in, and even within each format there are minor size variations. The negatives were not separated by film format or size. I needed a script that could edit based on something other than size (which could be done in Camera Raw, Photoshop, etc).   

TIFF files processed by the script are in the following state prior to processing: inverted to positive, converted to black & white, flipped on the vertical edge, and have OMCA metadata appended to them in a custom Photoshop Action. Photoshop saves them to a subfolder within Crop called TIFF.   
