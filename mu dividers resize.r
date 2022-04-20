# R v4.1.3        Jonathan Whiteley        2022-04-14
# Extract images from Spiffworld's card dividers for Marvel United
# https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
# https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

# https://sckott.github.io/pdfimager/
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html

library(magrittr)
library(dplyr)    # allows bind_rows, which is more convenient than a fixed number of unlist() calls

## PARAMETERS
input_dir <- "input"

if (!exists('img_dir')) {
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


# Download pdf file directly? 
# BGG file links are dynamic and expire, probably to prevent exactly this type of automated request.
# download.file(pdf_url, pdf_file)

# Instead, copy the file manually into the `input` directory, 
#  and set 'pdf_file' to the name of the file (automatically use all of them if blank)
# Check if pdf_file is empty and get all files in `input` if it is
if (!exists('pdf_file'))
  pdf_file <- ""
if (length(pdf_file) < 1)  # a blank parameter in R Markdown is assigned NULL: checking length also captures empty vectors
  pdf_file <- ""
if (is.na(pdf_file) || pdf_file == "") {   # these expressions would fail (empty results) if NULL
  pdf_file <- list.files(input_dir, '.pdf$')  # auto-detect all pdf files in the `input` directory
} else {
  # Split text into individual items
  pdf_file <- unlist( strsplit(pdf_file, ", ") )
  # Check that the specified pdf files exist, and throw an error if any do not.
  for (file in pdf_file) {
    if (file.exists(paste(input_dir, file, sep="/")) == FALSE) {
      stop(sprintf("file '%s' not found: check the `pdf_file` parameter, 'input_dir' parameter and working directory.", file))
    }
  }
}
# Stop if there is still no pdf_file available (e.g., the `input` directory is empty)
if (length(pdf_file) < 1 || pdf_file == "")
  stop(sprintf("No input pdf file found (in directory `%s/%s/`): check the `pdf_file` and `input_dir` parameters, and working directory.", getwd(), input_dir))

# Prepend input directory to make full relative paths
pdf_file <- paste(input_dir, pdf_file, sep="/")

if (F)
  pdf_file <- pdf_file[1:2]    # keep a subset for testing




################################################################
## Extract images from pdf files
# Each page is one big image of tabs (created in Photoshop)

library(pdfimager)  # remotes::install_github("sckott/pdfimager")
# Requires 'poppler' to be installed on your system (homebrew: `brew install poppler`)

if (F)    # do not run on source()
  pdimg_help()  # check that poppler and pdfimages is installed and accessible: you will get (command-line) help output if it is, and an error if it's not.

# Extract all images as png files to destination folder (pdfimager automatically creates a sub-folder with the pdf file name).
# + "-all" option extracts the image in its native format, apparently: https://askubuntu.com/questions/776679/why-are-the-images-produced-by-pdfimages-different-when-using-the-all-flag
# + most tutorials recommend "-png": the result appears to be the same as "-all" in this case.  "-all" is equivalent to `-png -tiff -j -jp2 -jbig2 -ccitt`
# + returned value is a table (within a list) with the relative path to each extracted image file.
# pdimg_images() is vectorized for a list of paths. :)
pdf_img <- pdimg_images(pdf_file, base_dir = img_dir, "-all") %>%
  bind_rows    # collapse nested lists into 1 data frame



################################################################
## Slice images from each page to extract each divider

library(magick)

# Create a reference image to check if dividers are blank (all-white)
# px_white <- image_blank(1, 1, color="white")

image_isblank <- function(img, px_white = image_blank(1, 1, color="white")) {
  img_diff <- img %>% image_scale("1x1") %>%    # collapse image to 1 pixel with average colour
    image_compare(px_white, metric="AE") %>%    # compare to reference (white pixel)
    attributes()
  # return logical: TRUE if blank (all-white), FALSE otherwise
  return(img_diff$distortion == 0)
}

# Define vector of cropping coordinates for each divider on a page (to loop over)
page_crops <- c(
  "541x390+1+1", 
  "541x390+544+1",
  "541x390+1+393",
  "541x390+544+393",
  "541x390+1+785",
  "541x390+544+785",
  # the last two are rotated 90º at the end of the page
  "390x541+1087+1",
  "390x541+1087+544"
  )
# The cropping is manual and was figured out by trial and error.
# I am taking advantage of the fact that the layout of tabs in each page image is very consistent. :)

crop_page <- function(page, img_crops = page_crops) {
  lapply(1:length(img_crops), function (d) {
    # extract 1 divider
    img <- image_crop(page, img_crops[d])
    # the last two are rotated 90º at the end of the page
    if (d > 6)  
      img <- image_rotate(img, 90)
    # check if it's blank
    if (image_isblank(img))
      return()
    else
      img
  })
}

# Loop over pages and extract dividers, using lapply and nested functions
#   this is a bit faster than a for loop, and easier to collect results. ;)
img_list <- lapply(1:nrow(pdf_img), function (p) {
  path_p <- unlist( pdf_img[p, "path"] )
  cat(paste("processing page", p, "of", nrow(pdf_img), "\n"))
  page <- image_read(path_p)
  crop_page(page)
})
# Cleanup: collapse list to one level (the nested `lapply` produces a nested list)
#  this also conveniently drops the NULL entries from blank dividers. :)
img_list <- unlist(img_list)


#==============================================================#
# Export individual dividers as separate images
# + for use in R Markdown / LaTeX

# Remove existing output png files, if any
#  In case you are processing a new pdf file, this ensures there are no leftovers from the previous one.
png_files <- list.files(img_dir, '.png$', recursive = FALSE, full.names = TRUE)
if (length(png_files) > 0)
  file.remove(png_files)
  

# Export images
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
