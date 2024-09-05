#!/bin/bash

# Array of folders to omit
omit_folders=("backup" "folder1" "folder2")

# Initial message
echo "Starting image conversion to white background..."

# Build the find command with omitted folders
omit_paths=""
for folder in "${omit_folders[@]}"; do
    omit_paths="$omit_paths ! -path \"./$folder/*\""
done

# Count the total number of JPG images that are not thumbnails and not in the omitted folders
total_images=$(eval "find . -type f -iname \"*.jpg\" $omit_paths" | while read -r img; do
    if [[ ! "$img" =~ -[0-9]+x[0-9]+\.jpg$ ]]; then
        echo "$img"
    fi
done | wc -l)

if [ "$total_images" -eq 0 ]; then
    echo "No images to process."
    exit 0
fi

converted_images=0
processed=0

# Find and convert all JPG images to a white background
eval "find . -type f -iname \"*.jpg\" $omit_paths" | while read -r img; do
    if [[ ! "$img" =~ -[0-9]+x[0-9]+\.jpg$ ]]; then
        processed=$((processed + 1))

        # Calculate the progress percentage
        progress=$((processed * 100 / total_images))

        # Display the progress bar
        echo -ne "["
        for i in $(seq 1 $((progress / 2))); do echo -n "#"; done
        for i in $(seq $((progress / 2 + 1)) 50); do echo -n " "; done
        echo -n "] $progress% ($processed/$total_images) - Processing $img\r"

        # Convert the image and add a white background, replace the original file
        magick "$img" -background white -alpha remove -alpha off "$img" 2>>error.log
        if [ $? -eq 0 ]; then
            converted_images=$((converted_images + 1))
            echo "Image converted: ${img#./}"
        else
            echo "Error converting $img. Check error.log for details."
        fi
    fi
done

# Display the final progress bar
progress=$((processed * 100 / total_images))
echo -ne "["
for i in $(seq 1 $((progress / 2))); do echo -n "#"; done
for i in $(seq $((progress / 2 + 1)) 50); do echo -n " "; done
echo -n "] $progress% ($processed/$total_images) - Completed\n"

# Final message with the number of processed and remaining images
remaining_images=$((total_images - converted_images))
echo "Process completed."
echo "Total images processed: $total_images"
echo "Converted images: $converted_images"
echo "Remaining images (not processed): $remaining_images"
