# To Do

* X-Men complete set: figure out divider indices to group regular versions of alt heroes together (to make it easier to not print the original versions if you are using the alts)

- Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
  - If the code is simple enough, just include it directly in the R Markdown file for simplicity.  The block itself can still be run or not, but there would only be 1 file needed to do everything.




# Notes on image and print quality

## Width and image quality

* Some pixellation apparent in Inkscape, but could just be the way the images are being rendered.  The appearance can be changed with "Object Properties: rendering" - setting it to 'auto' or 'OptimizeQuality' makes it look just like the original.  No difference in Preview.

* 92 mm width:
  - No obvious difference in quality when printed and viewed with the naked eye.  
  - Magnification suggests a little more pixellation or graininess in the output files compared with the originals, using a width of 92 mm, which might be _slightly_ wider than the originals, resulting in some resizing and resampling.  
  - Might try a slightly different approach to reproducing the original size based on pixels and resolution (dpi)? Basically good enough, though.

* 91.6 mm width:
  - Maybe a little less, or just different pixellation compared with original.  The original is a raster image (bitmap) itself, there is already some pixellation.  
  - Resizing just means resampling, but 91.6 mm is not noticeably better or worse than 92 mm, even under magnification.  Maybe the resampling artifacts are a little cleaner, but it's pretty minor.

* Editing in Preview (removing pages) seems to have no noticeable impact on images.


## Other artifacts

- Some visual artifacts visible in the bottom part of vertical borders between adjacent dividers in some viewers (when using an empty \parbox within a \fbox): looks like a shadow or anti-aliasing of the border from the divider on the left is visible under the image for the divider on the right, so the border appears slightly thicker under the right divider image.  This effect is not visible at certain zoom levels and disappears when zooming in.  It happens starting at about 70% overlap between borders (`\spaceskip=-0.7\fboxrule` or higher).  Not sure if this will affect printing.
  - The border artifact is **not** visible when printed (at 100% scale).
  - No longer appears after adding a white background to the \fcolorbox.

* When printed, the border does not appear to be fully 'tight' to the image, with a tiny area (<1 px?) of lighter colours between the black border and outside of the image.  Mostly visible under magnification, but still there.
  - This is **NOT** visible in the pdf files they were printed from. :(  But I do remember seeing similar artifacts in some versions at some magnifications.
  - Less apparent with lighter borders (gray or lightgray). The printer renders these as diagonal lines of varying thickness and density.  If a black border is just adjacent diagonal lines, it might explain the light colours if the border is not totally 'solid' next to the image, with a tiny gap between some of the diagonal lines and the images.  
  - Is this a possible drawback of vector graphics?
  - Ironically, it is more pronounced for borders for the same box than overlapping borders from adjacent boxes.  In close-ups, the effect is visible to the right of vertical borders between dividers (the border for the same box), but not to the left (the adjacent divider, whose border is actually covered by the border from the next object.  The same is true for top borders, which are from the same box, covering the border from the divider above.
  - Try an \fboxsep with a tiny negative value? (-0.5\fboxrule)?  
    - Should have tested with a thicker border.  Nevertheless, it is less pronounced, though still visible, when printed (0.25 mm black border with \fboxsep = -0.5\fboxrule).
    - Still visible at some magnifications in RStudio previewer on screen. Less so (if at all) with a \fboxsep <0.
  - I think this is a product of how the printer is rendering the border as a layer on top of the bitmap (raster) image.  
  - I could probably get rid of it by adding the border directly into the bitmap image itself, but that would make expanding the border around a desired height more difficult.  The difference in quality is probably not noticeable after cutting, anyway (the goal is to cut the borders away, not have them visible in the final dividers).  I really like the flexibility of the current approach, and the ability to specify desired lengths on the page, rather than figuring out number of pixels and sizing the final image on the page.


## Border Colour

Black is easier to see, but also around the margin of the divider if it's not cut away.  Around the very top, it's not too objectionable, because the divider tops have fairly dark / deep colours already.

Light grey (`lightgray`) is still visible when cutting, but not as high contrast if not fully cut away.  On the other hand, it's not as visible around the top of the divider images, due to lower contrast. It is not as nice as the black if not cut away, as it does look a bit like uncut paper.  Then again, it is not as high contrast with the paper edge as black would be.

It comes down to a choice between reducing contrast with blank paper and edges (lightgray) or with the divider graphics along the top (black).
I would prefer to cut the top border away completely anyway, so light grey should be fine.
