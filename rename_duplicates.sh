#!/bin/bash

# Use an associative array to track filenames without extensions
declare -A filenames

# First, populate the array with file base names (without extensions)
for file in test_folder/*; do
    # Extract the base name without the extension
    base_name="${file%.*}"
    extension="${file##*.}"
    if [[ -z "${filenames["$base_name"]}" ]]; then
        filenames["$base_name"]=0
    else
        ((filenames["$base_name"]++))
        new_name="${base_name}_${filenames["$base_name"]}.$extension"
        mv "$file" "$new_name"
        echo "Renamed $file to $new_name"
    fi
done

echo $filenames