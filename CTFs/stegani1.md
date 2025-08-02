# Notes on basic steganography exercise

The ctf has, apparently, 2 images.

Started by doing diff on them. No difference.

They are EXIF files.

An EXIF file contains metadata embedded in image files (like JPEG/PNG), storing info such as camera settings, timestamps, and GPS coordinates. It's part of the image, not separate.

So I downloaded exiftools and used it on the file, creating a metadata file.

stegano1.png show the result. GPS coordinates, which I pasted into google maps.
This resulted in... Marseille.

That was the flag.
