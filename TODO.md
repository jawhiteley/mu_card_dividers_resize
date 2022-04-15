# To Do

* Test and finalize sizes

* Confirm if there is a loss in image quality.  Try to figure out why and prevent it.
  - only apparent in Inkscape, but could just be anti-aliasing or lack thereof.  Not apparent in Preview?
    - No obvious difference in quality when printed and viewed with the naked eye.  
    - Magnification suggests a little more pixellation or graininess in the output files compared with the originals, using a width of 92 mm, which might be _slightly_ wider than the originals, resulting in some resizing and resampling.  Might try a slightly different approach to reproducing the original size based on pixels and resolution (dpi)? Basically good enough, though.
  - Some visual artifacts visible in the bottom part of vertical borders between adjacent dividers in some viewers: looks like a shadow or anti-aliasing of the border from the divider on the left is visible under the image for the divider on the right, so the border appears slightly thicker under the right divider image.  This effect is not visible at certain zoom levels and disappears when zooming in.  It happens starting at about 70% overlap between borders (`\spaceskip=-0.7\fboxrule` or higher).  Not sure if this will affect printing.
    - The border artifact is **not** visible when printed (at 100% scale).

* Add a way to specify page breaks after certain divider numbers
  - So that dividers can be grouped, if desired.
  - Increasing the size (height) of the dividers means fewer will fit on a page, so the same page groupings as the original won't necessarily work, but it might be nice to allow some grouping, if desired.

* Allow coloured borders (and maybe even add a white background under the image to hide overlaps).  I do like the idea of a (light) grey border that is more subtle than black.
  - Might be as simple as one or two additional LaTeX packages.
  - Add parameters for _border colour_ and background colour?

- Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
  - If the code is simple enough, just include it directly in the R Markdown file for simplicity.  The block itself can still be run or not, but there would only be 1 file needed to do everything.
