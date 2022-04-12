# To Do

* Tweak and finalize sizes
* Confirm if there is a loss in image quality.  Try to figure out why and prevent it.
  - only apparent in Inkscape, but could just be anti-aliasing or lack thereof.  Not apparent in Preview?
* Cleanup unnecessary commands in R, LaTeX
+ Figure out how to handle different paper orientation (season 1 vs X-Men)
+ Automatically check extracted graphics to confirm that they are dividers, and not 'empty space' (X-Men file has pages with <8 dividers on the page for variations and other collections).
  - I should be able to do with by running image_trim() on the extracted image and checking to see if the width is the same or not.  If not, remove it from the list.
* Collect all the parameters in one place (in a way that is accessible to both R and LaTeX): 
  - Divider height, width, border thickness; run external script; etc.
* Make R script use parameters from the Rmarkdown file, meaning it could not be run independently.  You can run individual R chunks from the Rmarkdown file, like a notebook, so this should still be functional.  Maybe I'll add a block of necessary parameters in an `if` block so it won't run when source()d, but is still available if running it separately.
+ Make output file name based on input file name, to reduce the number of parameters, and make it easier to run on multiple input files?
+ Create a sub-folder for input files that be ignored by git.
    + Allow the program to iterate over a list of input files (i.e., to combine Legion into the main X-Men file, or season 1 and X-Men, in a single pass).

