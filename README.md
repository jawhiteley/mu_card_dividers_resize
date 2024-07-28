Automatically re-size Spiffworld's horizontal dividers for Marvel United, in Rmarkdown.

Spiffworld has created some excellent horizontal dividers for all the cards in Marvel United on [BGG](https://boardgamegeek.com/):

* https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
* https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

These dividers look great and are very space-efficient: they only extend above unsleeved cards by about 3-4 mm, yet are still readable (and look great).  Recent versions even include handy reference information, like the number of symbols, and starting tokens for Super-Villain Mode.

I am thinking of sleeving some cards for this game, but as some have noted, the original dividers are so efficient that they barely extend above sleeved cards, or not at all in the case of some premium sleeves.  Many have asked for a version that was taller, but that's a lot of work to maintain for someone in their spare time.  Like others, I have considered various hacks, like printing them onto paper and gluing to a tall card back, but ultimately decided I wanted the simplicity of printing & cutting directly onto cardstock, and decided to challenge myself to see if I could resize them programmatically.

I used [R](https://www.r-project.org/) and [R Markdown](https://rmarkdown.rstudio.com/) to output to PDF via LaTeX, because that's what I'm familiar with.  I have no doubt this could be done in python, probably more efficiently.  I just haven't learned enough python to do it yet.

**NOTE:** *This workflow is unable to retain the color profile in the original pdf files (Adobe RGB (1998)).*  The result looks fine on screen, but the colours may appear 'washed out' or less vivid when printed. If anyone knows how to retain the color profile in extracted images, or re-apply it somehow in the final output (without changing pixel values), please let me know!


# Requirements

* [R](https://www.r-project.org/), with packages:
  + [rmarkdown](https://rmarkdown.rstudio.com/)
    + [RStudio](https://www.rstudio.com/) or [pandoc](http://pandoc.org/)
    + PDF output requires an installation of [LaTeX](https://www.latex-project.org/get/) for your system.
    + See [R Markdown installation notes](https://bookdown.org/yihui/rmarkdown/installation.html) for suggested LaTeX options.
  + [knitr](https://yihui.org/knitr/)
  + [pdfimager](https://sckott.github.io/pdfimager/) (not on CRAN)
  + [magick](https://cran.r-project.org/web/packages/magick/vignettes/intro.html) (ImageMagick)
  + [dplyr](https://dplyr.tidyverse.org/) (part of [tidyverse](https://www.tidyverse.org/); makes manipulating lists and tables easier)
  + magrittr (pipe operator, also included if you install tidyverse)
  + shiny (required for parameters in the R Markdown header, for [some reason](https://github.com/rstudio/rstudio/issues/4779))
* the pdfimager package also requires the pdfimages command-line tool, which is part of the [poppler](https://poppler.freedesktop.org/) library.
  + This can be installed on a Mac with [homebrew](https://brew.sh/) using the command:
    
        brew install poppler

## Suggestions

[RStudio](https://www.rstudio.com/) is not required, but makes it easier to edit and compile the R Markdown file.
All the code was tested in RStudio.

# How to Use

Everything you need is in the `mu dividers resize.Rmd` file.  This is an R Markdown file that was designed to be able to run in one step, but if you want, you can do the process in 2 steps:

1. Extract images from input pdf file (i.e., the originals on BGG)
2. Re-size and output to pdf

Step 1 is performed by the R script `mu dividers resize.r`: this file includes all the relevant parameters for this step, but will use any defined in the R Markdown file if run from there.  The main result of this script is a bunch of png files and sub-folders created in the `pdf_images` folder, including a separate image file for each divider.  These are used by the R Markdown file to layout dividers on a page in the desired size.

The R Markdown file can run the script automatically, but you don't have to: see the `extract_images` parameter, and comments in the second r chunk (`extract`) to disable the external script if it has already run, or enable it to do everything in 1 step.

Splitting the process into the two steps above allows you the opportunity to make any manual changes you want to the extracted images before producing the final pdf output: remove some dividers, change the order, etc.  The second step (in the R Markdown file) will automatically detect all `png` files in the `pdf_files` directory and put them all in the output file.

## 1. Setup

Put the pdf file of the dividers into the `input` sub-directory.
Currently, if there is more than one file in this directory, the script will only process the first one (sorted by name).

## 2. Set Parameters

These can all be set in the header of the R Markdown file for 1-step execution (under `params:`).  Any required in the R script have definitions there, too, if you want to run it independently.

* `pdf_file` (*optional*): Name of input pdf file (or path relative to `input` directory)

  + You can leave this blank and R will automatically detect all pdf files in the `input` directory, and extract images from all of them.
  + If you only want to use one file, put the name here.
  + If you want to use a subset of files in this folder (or control the order), list the names, separated by a comma and space (no quotes).  R will check that they exist and throw an error if it can't find any of them.

* `extract_images`: run the R script to extract images from the pdf all in 1 step?

  + set to `TRUE` if the script hasn't been run, to extract images from the input pdf.
  + set to `FALSE` to save time if it was already run.

* `page_breaks` (*optional*): comma-separated list of numbers.  Page breaks will be added *before* each divider number in this list.  In case you want to group dividers manually.

* Dimensions of dividers in output: `div_height`, `div_width`, and `border_width` (border thickness)

  + The originals are "3.620 inches wide and 2.613 inches tall", including a 1 pixel wide black border.  That's about **92 mm** wide, and **66 mm** tall.  
  + I have set the current width to **91.6 mm**, to preserve the original size and quality as much as possible, and a height of **76 mm**, which is plenty for most sleeves, and taller than I need.  You can always cut them shorter, if you prefer.
  + See [below](#divider-dimensions) for notes on dimensions, and suggested settings.

* `border_colour`: I prefer a light grey border (`lightgray`), which is visible enough to see when cutting, but doesn't leave behind such high-contrast edges.  Change to 'black' (or leave blank) for the same black border as the original.

* `spacing` (*optional*): Distance between dividers.  If blank, the default is for no space (overlapping borders).  Adding some space makes it easier to cut the borders completely away from the dividers, but requires more cuts (4 / divider).

* `modular_code`: this is the path to an external file with code and settings used to used to produce files posted on BGG.  You can specify any of the files in that folder here.  These files include custom order of dividers, recommended page breaks, and other parameter values for the available divider sets. The code in these files will overwrite some of the parameters described above.  


## 3. Compile the R Markdown file

Once the parameters have been set, you just need to `knit` the R Markdown file.  In Rstudio, you can simply click on the **Knit** button: see "[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/compile.html)" for more details.

The **output** will be a pdf file with the same name as the R Markdown file name, but with a `.pdf` file extension, and spaces replaced by dashes: i.e., `mu-dividers-resize.pdf`.

The compilation process will:

1. Run the R code embedded in the R Markdown file, producing a Markdown file.
    - This will produce a bunch of png files in the `pdf_images` folder.
2. Compile the Markdown file into LaTeX.
3. Compile the LaTeX file into the final pdf.
4. Clean-up and remove the intermediary (Markdown, LaTeX) files.

This means that there are several places where things can go wrong: in R (step 1), in Markdown (step 2), or LaTeX (step 3).

The R Markdown file uses a lot of custom LaTeX to achieve the desired result, which is to layout the pages dynamically, fitting as many dividers as possible on a page, with no horizontal or vertical space between dividers.  This may not always work on other systems, especially if you have different default LaTeX parameters.  

# Divider Dimensions

* Dividers in the original file are 3.620 in wide x 2.613 in tall (according to Spiffworld's comment [here](https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men)), including a 1 px border on all sides (confirmed in a personal communication).
  - 91.9 x 66.4 mm; approximately 92 x 66.5 mm in practice when printed.

* Original images (1 per page) are 1500 x 1200 px, scaled to 254 mm wide on the page (according to Inkscape).
  - 1480 x 1176 pixels trimmed: about 250.5 x 199 mm when printed.  

* Each divider image is 541 x 390 px (without the border).


* Marvel United cards are 63 x 88 mm (roughly standard poker size).

* Dragon Shield (one of the largest) [specifications](https://daviscardsandgames.com/products/dragon-shield-clear-matte-sleeves-standard-size) are "up to 66.5 x 92.5 mm" (vertical orientation width x height, so horizontal height x width).

## Divider Width

To reproduce the original **width** (and resolution) as closely as possible: 
* (254 mm / 1500 px) * 541 px = 91.61 mm | (250.5 / 1480) * 541 = 91.57
  - Including the border, the width would be (254 mm / 1500 px) * 543 px = 91.95 mm (very close to the dimensions from Spiffworld and when printed).
  - In this tool, the border is added to the outside, so I'm not including it in the calculation of the output image size.
* **91.6 mm** wide seems to be the closest to the original width (and resolution on the page: 150 ppi).
  <!-- as revealed with `pdfimages -list` -->

The output width can be changed to a desired width if you don't mind a bit of image scaling:

* **92 mm** wide is close to the original, and about the same as large premium sleeves.  In my testing, there was no difference in quality compared to the original, though minor differences were visible under 2x magnification.

* You might want to remove the width of 1 border to achieve a desired final cut size, if you care about variations of that magnitude. ;)

## Divider Height

Original dividers only project about 3-4 mm above the top of cards (66.5 vs 63 mm), which is barelyh enough to read the labels.

* Sleeves vary in size, but I have found that premium sleeves (e.g., Dragon Shield) are about as wide as the original dividers are tall.  
* Dragon Shield (one of the largest) [specifications](https://daviscardsandgames.com/products/dragon-shield-clear-matte-sleeves-standard-size) are "up to 66.5 x 92.5 mm" (vertical orientation width x height, so horizontal height x width).

* My insert from [TinkeringPaws](https://www.etsy.com/ca/listing/997029350/marvel-united-board-game-insert) only has a vertical clearance of 70 mm (2.76 in), and the core box only has 68 mm (2.68 in) clearance. 

* In practice, I found **7 cm** (2.76 inches) is the minimum height to be readable above sleeved cards, and still fit resonably in the inserts. 70 mm fits in the core box at an angle, but I wouldn't want to go much taller for my use.

* For reference, horizontal dividers from [Tesseract Games](https://www.tesseractgames.co.uk/marvel-united) are 74mm H x 87mm W.  As noted on the website, they do not fit in the Core Box without some box lift.  The layout also makes the titles unreadable if more than 4 mm is cut from the bottom (i.e., 70 mm height), even with unsleeved cards.

* Some have [requested](https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men) an additional 1/4-inch above the original height, which would be 72.7 mm (2.863 in, including the border).  Other [examples](https://boardgamegeek.com/geeklist/271344/marvel-legendary-dividers-finnsea15-style) are even larger, at about 93 x 75 mm.  

**76 mm** (about 3 inches, even including a 0.25 mm border) seems tall enough for large sleeves, and a convenient size for most.  They can always be cut shorter, if preferred. ;)


Note that because of how R Markdown and LaTeX handle images, the code here allows you to _increase the height_ relative to the original width, but not decrease it (i.e., it can only _decrease_ the aspect ratio).  It is possible to make the dividers shorter in LaTeX, but would require additional code and clipping the original graphics, which isn't necessary for making them bigger.  If you want shorter dividers, you can just cut some off the bottom (up to a point): the main purpose of this tool is to allow **taller** dividers, which the original files don't allow.

## Borders

* Originals have a 1 pixel border on all sides without overlap, so 1 px around the outside and 2 pixels between each divider, 
in an image 1500 x 1200 px, scaled to 254 mm wide on the page = 0.3387 mm between dividers?
* In this tool, all borders are the same width, as they overlap 100% between adjacent dividers: i.e., one border width between dividers instead of two.

* With a thicker border, it's easier to place the cut within the border, leaving some behind around the edge of each divider.  If the colour is lighter, a thicker border might be less noticeable anyway, and easier to use when cutting.
* With a thinner border, it's easier to place the cut inside the border, removing as much as possible from the divider; for lines between dividers, there is a greater risk that the border will end up entirely on one of the neighbouring dividers, with none on the other.  This can be avoided by leaving space between dividers, but that also means more cuts.

* **0.33-0.35 mm** would be closer to the original thickness between dividers, and would preserve the original dimensions and functionality.  0.33 mm is also close to '1 pt'.
* **0.25 mm** is a little thinner between dividers, but a bit thicker around the outside, compared with the originals. This is no more difficult to cut than 0.33mm, but is less likely to leave a lot behind if the cut misses.  
  + I think I prefer a slightly thinner border. The borders are meant to be cut away, not intended to be part of the final result.




# License

This source code is licensed under the license found in the `LICENSE` file in the root directory of this repository (MIT License).
