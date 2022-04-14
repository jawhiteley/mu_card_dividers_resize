# To Do

* Test and finalize sizes

* Confirm if there is a loss in image quality.  Try to figure out why and prevent it.
  - only apparent in Inkscape, but could just be anti-aliasing or lack thereof.  Not apparent in Preview?
  - Some visual artifacts visible in the bottom part of vertical borders between adjacent dividers: looks like a shadow or anti-aliasing of the border from the divider on the left is visible under the image for the divider on the right, so the border appears slightly thicker under the right divider image.  This effect is not visible at certain zoom levels and disappears when zooming in.  It happens starting at about 70% overlap between borders (`\spaceskip=-0.7\fboxrule` or higher).  Not sure if this will affect printing.

+ Create a sub-folder for input files that be ignored by git.
    - Allow the program to iterate over a list of input files (i.e., to combine Legion into the main X-Men file, or season 1 and X-Men, in a single pass).

* Updates for X-Men:

  - Figure out how to handle different paper/image orientation (season 1 vs X-Men)
    - Can I automatically detect if the top-left pixel is black (border)?

  - Automatically check extracted graphics to confirm that they are dividers, and not 'empty space' (X-Men file has pages with <8 dividers on the page for variations and other collections).
    - I should be able to do this by running `image_trim()` on the extracted image and checking to see if the width is the same or not.  If not, remove it from the list.

- Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
  - If the code is simple enough, just include it directly in the R Markdown file for simplicity.  The block itself can still be run or not, but there would only be 1 file needed to do everything.
