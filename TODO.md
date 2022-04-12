# To Do

* Test and finalize sizes
* Confirm if there is a loss in image quality.  Try to figure out why and prevent it.
  - only apparent in Inkscape, but could just be anti-aliasing or lack thereof.  Not apparent in Preview?
* Cleanup unnecessary commands in LaTeX
+ Figure out how to handle different paper orientation (season 1 vs X-Men)
+ Automatically check extracted graphics to confirm that they are dividers, and not 'empty space' (X-Men file has pages with <8 dividers on the page for variations and other collections).
  - I should be able to do with by running image_trim() on the extracted image and checking to see if the width is the same or not.  If not, remove it from the list.
* Collect all the parameters in one place (in a way that is accessible to both R and LaTeX): 
  - Divider height, width, border thickness; run external script; etc.
  - Currently not used in R, but now I'm curious, just in case.  LaTeX is the priority.
+ Make output file name based on input file name, to reduce the number of parameters, and make it easier to run on multiple input files?
+ Create a sub-folder for input files that be ignored by git.
    + Allow the program to iterate over a list of input files (i.e., to combine Legion into the main X-Men file, or season 1 and X-Men, in a single pass).
+ Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
