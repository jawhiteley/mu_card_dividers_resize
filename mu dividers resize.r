# R v4.1.3        Jonathan Whiteley        2022-04-12
# Extract images from Spiffworld's card dividers for Marvel United
# https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
# https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

# https://sckott.github.io/pdfimager/
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html


## PARAMETERS
input_dir <- "input"

if (!exists("img_dir")) {
  # Not source()d from the R Markdown file
  img_dir   <- "pdf_images"
  
  ## Working Directory: all paths are relative to here
  # If source()d from the R Markdown file being rendered, the default working directory is the same directory as the file.
  # The code here is for cases where this code is being run outside the R Markdown file (debugging, 2-step process, etc.)
  # Detect the directory of this file (on source()) and set the working directory automatically?
  # https://stackoverflow.com/questions/13672720/r-command-for-setting-working-directory-to-source-file-location-in-rstudio
  here <- utils::getSrcDirectory(function(x) {x})
  if (here == "") {
    # didn't work, or not being source()d
    # try Rstudio API - works if running interactively in RStudio (not on source)
    if (require(rstudioapi, quietly = TRUE)) {
      here <- dirname(rstudioapi::getActiveDocumentContext()$path)
    }
  }
  setwd(here)
}

library(magrittr)


# Download pdf file directly? 
# BGG file links are dynamic and expire, probably to prevent exactly this type of automated request.
# download.file(pdf_url, pdf_file)

# Instead, copy the file manually into the working directory (this folder), and set 'pdf_file' to the name of the file
pdf_files <- paste(input_dir, list.files(input_dir, '.pdf$'), sep="/") %>% sort()
pdf_file <- pdf_files[1]    # keep the first file only, for now

# Check that the pdf file exists, and throw an error if it does not.
if (file.exists(pdf_file) == FALSE) {
  stop(sprintf("file '%s' not found: check the 'input_dir' parameter and working directory.", pdf_file))
}



################################################################
## Extract images from pdf file
# Each page is one big image of tabs (created in Photoshop)

library(pdfimager)  # remotes::install_github("sckott/pdfimager")
# Requires 'poppler' to be installed on your system (homebrew: `brew install poppler`)

if (F)    # do not run on source()
  pdimg_help()  # check that poppler and pdfimages is installed and accessible: you will get (command-line) help output if it is, and an error if it's not.

# Extract all images as png files to destination folder (pdfimager automatically creates a sub-folder with the pdf file name).
# + returned value is a table with the relative path to each extracted image file.
pdf_img <- pdimg_images(pdf_file, base_dir = img_dir, "-png")




################################################################
## Slice images from each page to extract each divider

library(magick)

# Initialize a ontainer list to hold image objects for each divider 
# + put something into the first item to make it easier to append() objects in the loop
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

# Cleanup: drop first placeholder item
img_list <- img_list[-1]


#==============================================================#
# Export individual dividers as separate images (
# + for use in Rmarkdown / LaTeX
div_paths <- lapply(1:length(img_list), function (i) {
  div_path <- sprintf("%s/div-%03i.png", img_dir, i)
  image_write(img_list[[i]], path = div_path, format = "png")
  div_path    # return path to created file
})




################################################################
## Layout new pages with resized dividers & output pdf?
# See R Markdown file for final output, using the images output above.

# R Markdown & LaTeX give more precise control over layout and sizing.
# I also don't trust R's native handling of raster images (see `magick` vignette), 
#  so I would rather do the resizing in LaTex/Markdown to preserve as much of the original image quality as possible.
