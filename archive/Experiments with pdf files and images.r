# R v4.1.3        Jonathan Whiteley        2022-04-12
# Trying to automatically resize Spiffworld's card dividers for Marvel United
# https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
# https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

# https://www.thepythoncode.com/article/extract-pdf-images-in-python
# https://rdrr.io/cran/metagear/src/R/PDF_extractImages.R
# https://www.r-bloggers.com/2016/08/extracting-content-from-pdf-files/
# https://sckott.github.io/pdfimager/
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html

## PARAMETERS

# Set Working Directory
setwd("~/_MyFiles/Play/Board Games/Marvel United/mu_card_dividers_resize")

pdf_file <- "mu_card_dividers_v2.pdf"
img_dir <- "pdf_images"

# Not used for final output (only experimental code here): see `mu dividers resize.Rmd` for these
file_out <- "mu_card_dividers_new.pdf"
new_size <- c(7, 9.2)    # new dimensions of output tabs (in cm): height, width; to specify using inches, use cm(num_inches)


## LIBRARIES
# library(metagear) # requires hexView - ERRORS


# Download pdf file? 
# BGG file links are dynamic and expire, probably to prevent exactly this type of automated request.
# download.file(pdf_url, pdf_file)

if (F)
{
  
# Explore downloaded file
library(pdftools)
# pdf_info(pdf_file)
pdf_pages <- pdf_data(pdf_file)
pdf_attachments(pdf_file)  # no attachments found :(
# pdf_convert just converts the page to an image: I want the raw image :(
if (F)
  pdf_convert(pdf_file, page = 1, format = "png")

# Trying out some of the raw code in metagear pkg
rawFile <- hexView::readRaw(pdf_file, human = "char")
# collapse ASCII to a single string
theStringFile <- paste(hexView::blockValue(rawFile), collapse = '')
if (F)
  write.table(theStringFile, "pdf_string.txt", sep = "\n", row.names = FALSE)

}




################################################################
## Extract images from pdf file
# each page is one big image of tabs (created in Photoshop)

library(pdfimager)  # remotes::install_github("sckott/pdfimager")    ; requires 'poppler' to be installed on your system (homebrew: brew install poppler)

pdimg_help()  # check that poppler and pdfimages is installed and accessible.  You will get (command-line) help output if it is, and an error if it's not.
# extract all images as png files to destination folder (pdfimager automatically creates a sub-folder with the pdf file name).
# returned value is a table with the relative path to each extracted image file.
pdf_img <- pdimg_images(pdf_file, base_dir = img_dir, "-png")

# using pdfimages directly from the command-line works, too: extracts each image as a png to desired location with base name
# pdfimages -png mu_card_dividers.pdf pdf_images/img




################################################################
## Slice extracted images to extract each divider

library(magick)
library(magrittr)

# container list to hold image objects for each divider (put something into the first item to make it easier to append() objects in the loop)
img_list <- list(0)

for (p in 1:nrow(pdf_img[[1]])) {
  path_p <- unlist( pdf_img[[1]][p, "path"] )
  cat(paste("processing page", p, "of", nrow(pdf_img[[1]]), "\n"))
  page <- image_read(path_p)
  # crop out each divider and use image_trim to remove the black borders (not reliable for some dividers)
  # divider 1
  #image_crop(page, "543x392") %>% image_trim()
  img_list <- append(img_list, image_crop(page, "541x390+1+1") )
  # divider 2
  img_list <- append(img_list, image_crop(page, "541x390+544+1") )
  # divider 3
  img_list <- append(img_list, image_crop(page, "541x390+1+393") )
  # divider 4
  img_list <- append(img_list, image_crop(page, "541x390+544+393") )
  # divider 5
  img_list <- append(img_list, image_crop(page, "541x390+1+785") )
  # divider 6
  img_list <- append(img_list, image_crop(page, "541x390+544+785") )
  # The last 2 dividers are rotated - in the X-Men file, they may be missing from some pages
  # divider 7
  img_list <- append(img_list, image_crop(page, "390x541+1087+1") %>% image_rotate(90) )
  # divider 8
  img_list <- append(img_list, image_crop(page, "390x541+1087+544") %>% image_rotate(90) )
}

# drop first placeholder item
img_list <- img_list[-1]

# export individual dividers as separate images (for use in LaTeX or Rmarkdown?)
div_paths <- lapply(1:length(img_list), function (i) {
  div_path <- sprintf("%s/div-%03i.png", img_dir, i)
  image_write(img_list[[i]], path = div_path, format = "png")
  div_path    # return path to created file
})



# ImageMagick can seemingly read pdf files directly
# Does this preserve the color profile?
# - when ImageMagick reads the pdfimages output, or pdf file directly, or exported sliced images (from ImageMagick), they all have 'sRGB' colorspace, but I'm not sure this is the same as a color profile?
# I think it's actually converting the pdf page to a bitmap, and losing a lot of image detail in the process.

test_pdf <- image_read("input/mu_card_dividers_v2.pdf")
test_pdf[1]
image_info(test_pdf[1])
image_attributes(test_pdf[1])  # Artifex sRGB Profile??

test_pdf2 <- image_read_pdf("input/mu_card_dividers_v2.pdf", pages = 1, density = 150) # convert at original dpi: doesn't mean rendered pixels align with originals. :P
test_pdf2
image_info(test_pdf[1])
image_attributes(test_pdf[1])  # Artifex sRGB Profile??

test_pdfh <- image_read_pdf("input/mu_card_dividers_v2.pdf", pages = 1, density = 600) # "High-resolution" capture: each original pixel is about 4 pixels here. :D


test_page <- image_read("pdf_images/mu_card_dividers_v2/img-000.png") # extracted using pdfimages: should have 'rgb' colorspace, and maybe "Adobe RGB (1998)" color profile
test_div  <- image_read("pdf_images/div-001.png")  # cropped with ImageMagick (R magick) with default options
test_png  <- image_read("pdf_images/tests/mu_card_dividers_v2 (Preview-Adobe).png")  # , defines = c('png:preserve-iCCP' = "true"))  # original pdf exported to PNG in Preview (macOS) with "Adobe RGB (1998)" color profile; only page 1 is read here

image_info(test_png) # why is the colorspace = 'sRGB"?
image_attributes(test_png) # shows Adobe RGB icc profile, as expected! also IHDR.color_type = 6 (RGBA) (might correspond to "/ColorSpace" in original pdf)
image_attributes(test_page) # has "png:sRGB 'intent=0 (Perceptual Intent)'" ?? But no gamma or chromaticity added.  IHDR.color_type = 2 (Truecolor)
image_attributes(image_strip(test_page)) # no change
image_attributes(test_div)  # this was exported by magick and has gamma & chromaticity added

test_comp <- image_compare(test_pdf[1], test_page, metric="AE")
attributes(test_comp)

test_comp2 <- image_compare(image_trim(test_page), image_trim(test_png), metric="AE")
attributes(test_comp2)
image_info(image_trim(test_page)) # why is the colorspace = 'sRGB"?
image_info(image_trim(test_png)) # different 'density'?  Why is the colorspace='sRGB'? matte = TRUE, which might refer to opacity (RGBA colorspace?)  https://www.imagemagick.org/Magick++/Enumerations.html#ImageType
image_info(image_strip(test_png)) # different 'density'?  Why is the colorspace='sRGB'?

image_write(test_pdf[1], path = "pdf_images/tests/pdf_page1.png", format = "png")  # resampled to lower resolution :(  but pdfimages shows icc color profile (probably Artifex sRGB ICC profile)
image_write(test_pdf[1], path = "pdf_images/tests/pdf_page1.pdf")  # resampled to lower resolution :(  Default sRGB color profile applied. :(

image_write(image_trim(test_png), path = "pdf_images/tests/test-png.png", format = "png")  # Adobe RGB profile retained :)
image_write(test_page, path = "pdf_images/tests/test-page.png", format = "png") # sRGB color profile and other metadata added. :(
image_write(image_strip(test_page), "pdf_images/tests/test-page-strip.png") # sRGB color profile and other metadata (Chromaticities, gamma, etc.) removed! :)
test_page_strip <- image_read("pdf_images/tests/test-page-strip.png")
image_attributes( image_strip(test_page_strip) ) # no pHYs chunk (resolution), still has a sRGB chunk (seems to be required)
image_attributes( image_strip(test_page) )

# image_write(image_strip(test_page), "pdf_images/tests/test-page-stripd.png", density=150) # with declared dpi (density)? Nope





################################################################
## Layout new pages with resized dividers & output pdf
if (F) 
{
  
library(grid)
library(gridExtra)

# https://github.com/baptiste/gridextra/wiki/arrangeGrob

div <- rectGrob(width = new_size[2], height = new_size[1], default.units="cm",
  gp=gpar(col="#000000", fill=NA, lwd=1) )
page_div <- lapply(1:11, function (x) { div })
grid.arrange(grobs=page_div, ncol=2)
marrangeGrob(grobs=page_div, nrow=3, ncol=2)

# use image_graph and image_composite to add space around the original image?
# sort of works, but not ideal.  I suspect this is changing the resolution of the original image, which is not quite what I want
div2 <- image_graph(width = 541, height = 541, res = 96)
grid.arrange(div)
dev.off()
div_comp <-image_composite(div2, image_border(img_list[[1]], "black", "1x1"))
image_border(div_comp, "grey", "2x2")

# open output pdf file: the width & height specify the size of the *graphics region* within the page.
# Leaving 0.25-inch margin on all sides
pdf(file=file_out, paper="letter", width = 8, height = 10.5)
marrangeGrob(page_div, nrow=3, ncol=2)
lapply(img_list, function(x) { plot(as.raster(x)) } )
dev.off()

}

# R Markdown & LaTeX will give me more precise control over layout, especially treating each image as an inline box.
# I also don't trust R's native handling of raster images (see `magick` vignette), 
#  so I would rather do the resizing in LaTex/Markdown to preserve as much of the original image quality as possible.
# See R Markdown file for final output.
