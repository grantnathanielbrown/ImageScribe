import exifread
import os

# Set the path to the folder containing the images
folder_path = '.'

# Iterate over all images in the folder
for file_name in os.listdir(folder_path):
    # Check if the file is an image
    # if file_name.endswith('.jpg') or file_name.endswith('.jpeg') or file_name.endswith('.png'):
    # Open the image file
    with open(os.path.join(folder_path, file_name), 'rb') as image_file:
        # Extract the EXIF data from the image
        exif_data = exifread.process_file(image_file)
        # Print the EXIF data
        print(exif_data)
