#!/bin/bash
EXIFTOOL_PATH=$1

# Loop through each PNG file in the directory
for image in ../consolidated_images/*.{png,PNG}; do
    echo "$image"
    filetype=$(file --brief --mime-type "$image")
    echo "$filetype"
    # If the mime type is JPEG, rename it
    if [[ "$filetype" == "image/jpeg" ]]; then
        "$EXIFTOOL_PATH" "-filename=%f.jpg" "$image"
    fi
done