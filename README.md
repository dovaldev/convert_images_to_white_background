# Image Background Converter

This project contains two Bash scripts designed to batch process `.jpg` images by converting them to have a white background. The scripts are compatible with different versions of ImageMagick (v6 and v7), allowing flexibility based on the installed version.

## Why I Created This Script
In a project I worked on, WordPress was generating thumbnails with a black background, which often looked unappealing since the theme used a white background.

After investigating the cause of this issue, I discovered that the client was using PrestaShop, which doesn't support WebP images. To work around this limitation, the client was renaming WebP images to .jpg. As a result, many of the images we encountered had a .jpg extension but retained transparency.

To solve this problem, I developed this script, which can be run directly from the terminal in cPanel. It processes all the images, converting them to have a white background.

Once the script has been executed, you can regenerate the thumbnails, and the issue is resolved. Since implementing this solution, I no longer encountered thumbnails with black backgrounds.

## Features
- Converts all `.jpg` images to have a white background.
- Allows specifying folders to omit from processing.
- Skips thumbnail images based on their naming pattern (`-[0-9]+x[0-9]+.jpg`).
- Provides a real-time progress bar indicating the percentage of images processed.
- Logs errors to an `error.log` file if any images fail to process.

## Versions

### ImageMagick v7
For systems with ImageMagick v7, use the script:

```bash
convert_images_to_white_background.sh
```

### ImageMagick v6
For systems with ImageMagick v6, use the script:

```bash
convert_images_to_white_background_imagemagic_v6.sh
```

## Requirements
- [ImageMagick](https://imagemagick.org): Ensure the appropriate version (v6 or v7) is installed on your system.
- Bash shell environment.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/image-background-converter.git
   cd image-background-converter
   ```

2. Ensure that ImageMagick is installed:

   On Ubuntu/Debian:
   ```bash
   sudo apt-get install imagemagick
   ```

   On macOS (via Homebrew):
   ```bash
   brew install imagemagick
   ```

3. Make the script executable:

   ```bash
   chmod +x convert_images_to_white_background.sh
   chmod +x convert_images_to_white_background_imagemagic_v6.sh
   ```

## Usage

1. Open the relevant script for your version of ImageMagick in a text editor.
2. Edit the `omit_folders` array at the top of the script to list any directories you want to exclude from the conversion process.

   Example:
   ```bash
   omit_folders=("backup" "other_folder_to_omit")
   ```

3. Run the appropriate script in the directory containing the images:

   For ImageMagick v7:
   ```bash
   ./convert_images_to_white_background.sh
   ```

   For ImageMagick v6:
   ```bash
   ./convert_images_to_white_background_imagemagic_v6.sh
   ```

4. Check the `error.log` file for any issues with individual images.

## Output
- Progress will be displayed in the terminal with a visual progress bar.
- The final output will summarize how many images were processed, converted, and how many remain unconverted.

## Script Details

### Folder Omission
The script allows you to define folders that should be excluded from the image conversion. You can add or remove folder names in the `omit_folders` array.

### Thumbnails Skipped
Images with filenames that match the pattern `-[0-9]+x[0-9]+.jpg` are assumed to be thumbnails and are excluded from processing.

### Progress Bar
A progress bar is shown in the terminal as images are processed, showing the current percentage of completion.

### Error Logging
Any images that fail to convert are logged in an `error.log` file for later review.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
