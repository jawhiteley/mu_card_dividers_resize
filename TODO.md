# To Do

- Try to preserve original color profile (Adobe RGB 1998)?
  - Use ImageMagick to slice images directly from command-line (using a call from within R)?

- Try a different method of preserving 150 ppi / dpi from the original to final output.
  - set dpi to 150 in extracted images?  Then images can be placed at scale = 100%
    - make this the default if divider width = blank?
  - set dpi to 150 in pdf (LaTeX)?
  - set image width to precisely n_pixels / 150 ppi?

- Group parameters together in YAML header to facilitate pasting options from `parameters.md`?
  - File options: pdf_file, extract_images, page_breaks
  - Divider options: dimensions, border_colour, spacing

- Add a parameter for custom divider order?
  - I currently keep custom R code in `parameters.md`.
    It is actually a bit easier to build the indices in R using c() and subset() to skip desired dividers.
  - It would be a bit complicated to allow R code in this parameter, or a straight list.  Maybe require R code (`c(...)`)?
  - This is very much a 'power user' option, and not really necessary for push-button useage.  Maybe it's fine to leave it as-is.

- Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
  - If the code is simple enough, just include it directly in the R Markdown file for simplicity.  The block itself can still be run or not, but there would only be 1 file needed to do everything.


+ `pdfimages -all` extracts jpg files from X-Men files.
  - The classic file seems to include embedded pngs, whereas the X-Men files are embedded jpgs.
  - jpgs include a bit more metadata (Adobe Photoshop as creator, correct resolution of 150 dpi), but come already with a standard sRGB color profile.  Whereas exporting from the original pdf to jpg from Preview includes the Adobe RGB color profile (as with exporting to png).
  - Doesn't seem to make much difference. ImageMagick (magick) can still read & slice the image in whichever format it's in (the R function returns a list of the paths and filenames, so it can automatically find the extracted files, which is convenient), and still export to png.  The color profile seems to be lost during the initial extraction (by pdfimages) either way.




# Notes on image and print quality

* Colours in output appear a little "washed out" (not as dark / vivid) compared to originals when printed.  Not sure I can tell the difference on screen, but it is noticeable in print.  Is there a colour profile or pdf setting that I'm missing?
  - Could be an optical illusion due to lighter borders in my output vs black in originals?  Looking at test prints, it looks like a lot of variation in printer output (even from the same printer).  My final print on cardstock is noticeably paler than the originals, but it might just be the particular printer used and toner quality at the time?
  - Using pdfimages on the original (`pdfimages -list ...`) reveals all images have an 'icc' color profile (color 'icc').  The outputs have color = 'rgb', which does suggest a different color profile. :(
    - The original also has "interp = yes"
  - pdfimages extraction to png?  (-png or -all)
      - Color space: RGB
      - No ColorSync profile
  - Image Magick slicing of png?
      - Color Space: RGB
      + Color Profile: sRGB IEC61966-2.1
      - ColorSync profile: sRGB IEC61966-2.1
      + Also Chromaticities and Gamma attributes not present in the original
  - LaTeX output to pdf?
    - seems unlikely: https://askubuntu.com/questions/776679/why-are-the-images-produced-by-pdfimages-different-when-using-the-all-flag
  - When saving the original pdf as png (Preview), the output has a ColorSync profile of "Adobe RGB (1998)"
  - If I use ImageMagick (in R) to read a png extracted by pdfimages, then export it again without any modification, the exported file has the same color profile, chromaticities and gamma added as other outputs from ImageMagick.
    - ImageMagick is definitely making some changes to the color profile, but it's not clear whether pdfimages is also dropping the original color profile (or if that is causing ImageMagick to add a default).
  - Original pdf contains a reference to "[ /ICCBased 7 0 R ]", but only once, and it's not clear if this is a property of the image(s) or pdf file.
    - It might just be a 'tag' in the pdf file, with a specific RGB profile (Adobe RGB 1998) embedded in each image?
    - Or, the Adobe RGB profile is only being 'tagged' as metadata, without being embedded.  It is likely being tagged as the working space (Adobe RGB has a wider gamut than sRGB).
    - also "/Interpolate true"
    - also "/ColorSpace 6 0 R ", whereas my output has "/ColorSpace /DeviceRGB" :(
  - I want to preserve the color profile from the original to the final output, without converting the pixel colour values.  How do I do that?
  - Can I embed a color profile in the pdf file or does it have to be in the images? (apparently, yes, based on `pdfx` documentation and other info on PDF/X | PDF/A standards)
    - 'colorspace' package? https://ctan.math.washington.edu/tex-archive/macros/latex/contrib/colorspace/colorspace.pdf
      
- https://www.colourmanagement.net/advice/about-icc-colour-profiles
- https://helpx.adobe.com/ca/acrobat/using/color-managing-documents.html
- https://helpx.adobe.com/ca/photoshop/using/working-with-color-profiles.html

- https://imagemagick.org/script/color-management.php
- https://www.rigacci.org/wiki/doku.php/doc/appunti/software/imagemagick_color_management
- https://legacy.imagemagick.org/discourse-server/viewtopic.php?t=33378
- https://legacy.imagemagick.org/discourse-server/viewtopic.php?t=8812

- https://stackoverflow.com/questions/31591554/embed-icc-color-profile-in-pdf
- https://weber.itn.liu.se/~karlu20/div/howto/LaTeX_colour_management.php
* https://tex.stackexchange.com/questions/61217/latex-color-and-icc-color-profiles
* https://tex.stackexchange.com/questions/146517/how-to-improve-color-consistency-of-bitmap-pictures-from-native-format-to-target

- https://tex.stackexchange.com/questions/576/how-to-generate-pdf-a-and-pdf-x
  - `pdfx` and `hyperxmp` packages.
  - https://mirrors.mit.edu/CTAN/macros/latex/contrib/pdfx/pdfx.pdf (s2.6)
      
R magick package in R include bindinge to ImageMagick, but not always clear how to access all the features.  Options:

* image_strip() # removes sRGB color profile and other metada (chromaticities, gamma, etc.)
  * image_write(image_strip(...), ...)
* image_read() options: strip = FALSE, defines? etc.
- image_convert() ? I don't really want to change pixel values, just tag with the Adobe RGB color profile


ImageMagick & color profiles?

    convert input/mu_card_dividers_v2.pdf AdobeRGB.icc

This produced an icc file (actually 1 per page), but applying it did not change appearance.  

    convert pdf_images/tests/img-000-pdfimages.png -profile input/AdobeRGB-0.icc pdf_images/tests/img-000-imagick-adobe.png

Worse, the output png still has the default sRGB profile in the metadata!  `identify -verbose` confirms that an Artifex sRGB icc profile was added instead.  Suggests this icc profile is not valid.

Instead, I tried extracting the color profile from a png exported from Preview, which had the original Adobe profile intact:

    convert 'pdf_images/tests/mu_card_dividers_v2 (Preview-Adobe).png' input/AdobeRGB.icc
        
Apply that to an image without a profile did change the colours.  "Adobe RGB (1998)" shows up in Finder info and Preview info, and `identify -verbose`.  Also includes chromaticity chunk, which I'm not sure I want.

    convert pdf_images/tests/img-000-pdfimages.png -profile input/AdobeRGB.icc pdf_images/tests/img-000-imagick+adobe.png

Suggests at least partial success, and that the extracted icc profile is valid.

Adding `-strip` to the command results in no color change, and no color profile appearing anywhere. ??

    convert 'pdf_images/tests/img-000-pdfimages.png' -strip -profile 'input/AdobeRGB.icc' 'pdf_images/tests/img-000-imagick-strip+adobe.png'

The output is identical to the command with only `-strip` and no `-profile` option?

This is supposed to apply the profile, without changing any pixel values (which is what I want); without the `-strip`, an sRGB profile might be assumed, then Adobe RGB is applied, and pixel values converted.



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
