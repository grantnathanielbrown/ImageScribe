#!/bin/bash

EXIFTOOL_PATH=$1
EXIF_TAG=$2

echo_output=true

conditional_echo() {
    local input=$1
    if [ "$echo_output" = true ]; then
        echo $input
    fi
}

output_execution_status() {
  if ! [ $? -eq 0 ]; then
    echo "Error processing image: $image"
  fi
}

rename_duplicates() {
  # Use an associative array to track filenames without extensions
  declare -A filenames

  # First, populate the array with file base names (without extensions)
  for file in input_images/*; do
      # Extract the base name without the extension
      base_name="${file%.*}"
      extension="${file##*.}"
      if [[ -z "${filenames["$base_name"]}" ]]; then
          filenames["$base_name"]=0
      else
          ((filenames["$base_name"]++))
          new_name="${base_name}_${filenames["$base_name"]}.$extension"
          mv "$file" "$new_name"
          conditional_echo "Renamed $file to $new_name"
      fi
  done
}

detect_jpegs() {
  # Loop through each PNG file in the directory
for image in ../consolidated_images/*.{png,PNG}; do
    conditional_echo "$image"
    filetype=$(file --brief --mime-type "$image")
    conditional_echo "$filetype"
    # If the mime type is JPEG, rename it
    if [[ "$filetype" == "image/jpeg" ]]; then
        "$EXIFTOOL_PATH" "-filename=%f.jpg" "$image"
    fi
done
}

while getopts "dje" opt; do
  case ${opt} in 
    d )
      rename_duplicates
      ;;
    j )
      test2
      ;;
    e )
      echo "doing it"
      echo_output=false
      ;;
    \? )
      echo "Usage: cmd [-d] [-j] [-e]"
      exit 1
      ;;
  esac
done

exec &> output.txt

for image in ./input_images/*; do
  filetype=$(file --brief --mime-type "$image")
  conditional_echo $filetype
  conditional_echo $image
    # If image is a PNG, convert it to a JPG before processing it
    if [[ $filetype == "image/png" ]]; then
      new_image="${image%.*}.jpg"
      convert "$image" "$new_image"
      image="$new_image"
      text=$(tesseract "$image" stdout)
      output_execution_status
      "$EXIFTOOL_PATH" -overwrite_original "$EXIF_TAG"="$text" "$image" -o ./output_images/"$(basename "$image")"

      else 
      text=$(tesseract "$image" stdout)
      output_execution_status
      "$EXIFTOOL_PATH" "$EXIF_TAG"="$text" "$image" -o ./output_images/"$(basename "$image")"
    fi
done

exit