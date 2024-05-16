## ABOUT

ImageScribe is a bash script that takes a batch of images, scans them for text with Tesseract OCR, and adds any detected text to a metadata tag of your choosing.

My motivation for making this is that I frequently have trouble finding specific memes in my collection. This is intended to make it easier, because you can search for images based on the text contained in their metadata in the Windows 10 (W10) file explorer.

Please feel free to suggest improvements or mention any bugs you notice.

## SCRIPT USAGE

Thus far, I've designed this script to work with Windows 10. The script itself can be run in any bash terminal, but I don't know how the searching would work on other operating systems. I may add support for other OS's later.

Download the following:

[Tesseract OCR] (https://github.com/UB-Mannheim/tesseract/wiki)
[ImageMagick] (https://imagemagick.org/script/download.php#windows)
[EXIFTOOL] (https://exiftool.org/)

Move all images that you want to be tagged to the input_images folder. I'd recommend keeping backup copies just in case something weird happens. I squashed bugs that showed up on my end but who knows what kind of weird images people have.

Run the script with 2 arguments, the first argument being the path to EXIFTOOL on your machine, the 2nd argument being the metadata tag that you want to be updated with the text detected by Tesseract. I recommend -Title for reasons described in the Q & A

Example: bash ImageScribe.sh "../EXIFTOOL/exiftool" "-Title"

After the script finishes running, you can find your modified images in the output_images folder.

## SEARCHING

Open up an instance of file explorer.

If you haven't already, click the "View" option in the top left => click "Details pane". This pops up a little section on the right-hand side that will give you extra details about any file you click on in the explorer. For images, the pane will display (some) of the metadata tags. Any images that have been run through ImageScribe should have some values in the fields.

![W10 File Explorer](file_explorer.jpg "JPG with metadata")


To search for an image based on its metadata, use the search bar in the top right with the following syntax: ${tag}: ${value}. The search is case insensitive, and will match partial strings.

So for example, title: cat could return images with the following values in their title tag: "cat", "CAT", "cute kittycat", "he will catch the ball".

## Q & A

### Why not just use Google Photos to search for images?

AFAICT, Google Photos does a great job visually identifying objects in photos, but it's inconsistent when it comes to detecting text. Google Photos also doesn't display any metadata on an image except for the location.

### What image formats can I use?

JPG/JPEG/PNG. Any PNGs will be converted to JPGs before they are scanned by Tesseract.

### Why does it convert PNG to JPEG’s?

While EXIFTOOL has the capability of updating metadata tags on PNGs - I don’t know of a way to search for PNGs based on their metadata via the Windows 10 UI, so I convert them to JPEGS. If you happen to know of a way to do so, please let me know.

## EXIF/METADATA KNOWLEDGE

In Windows, manually modifying the "tags" attribute on an image causes the following tags listed by EXIFTOOL to change:

XP Keywords
Last Keyword XMP
Subject

If you run EXIFTOOL and modify the "Subject" tag, that will change its value, but will not affect the value of XP Keywords or Last Keyword XMP

Due to some annoying things with the w10 UI we will just change the title tag as opposed to this subject, description, or comments tag

Assuming our understanding is correct:

When you view the EXIF metadata of an image via EXIFTOOL it only lists tags which are already populated with values. In other words, if I modify the "tags" attribute of an image in the w10 UI, those 3 tags will pop up next time I view the image with EXIFTOOL again. Also, you can run EXIFTOOL with an option to populate empty tags with values so they show up next time. But you CANNOT, for example, create tag - value pairs that aren't in the EXIF specification.

## WINDOWS 10 SEARCH KNOWLEDGE

For whatever reason, if a metadata tag contains text that is more than 1,000 characters, the w10 UI won't be able to search it

### How come this doesn't have [insert feature here]

90% chance I couldn't figure out how to do it and/or didn't feel it was worth the time investment. Please feel free to suggest improvements or mention any bugs you notice! As of May 2024 I'm unemployed and working on personal coding projects for fun right now so I have the time.