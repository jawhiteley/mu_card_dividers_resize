Automatically re-size Spiffworld's horizontal dividers for Marvel United, in Rmarkdown.

Spiffworld has created some excellent horizontal dividers for all the cards in Marvel United on [BGG](https://boardgamegeek.com/):

* https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
* https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

These dividers look great and are very space-efficient: they only extend above unsleeved cards by about 3-4 mm, yet are still readable (and look great).  Recent versions even include handy reference information, like the number of symbols, and starting tokens for Super-Villain Mode.

I am thinking of sleeving some cards for this game, but as some have noted, the original dividers are so efficient that they barely extend above sleeved cards, or not at all in the case of some premium sleeves.  Many have asked for a version that was taller, but that's a lot of work to maintain for someone in their spare time.  Like others, I have considered various hacks, like printing them onto paper and gluing to a tall card back, but ultimately decided I wanted the simplicity of printing & cutting directly onto cardstock, and decided to challenge myself to see if I could resize them programmatically.

I used [R](https://www.r-project.org/) and [R Markdown](https://rmarkdown.rstudio.com/) to output to PDF via LaTeX, because that's what I'm familiar with.  I have no doubt this could be done in python, probably more efficiently.  I just haven't learned enough python to do it yet.


# Requirements

* [R](https://www.r-project.org/), with packages:
  + [rmarkdown](https://rmarkdown.rstudio.com/)
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

[RStudio](https://www.rstudio.com/) is not required, but makes it easier to edit and compile the R Markdown file.  All the code was tested in RStudio.

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
* Dimensions of dividers in output: `div_height`, `div_width`, and `border` (border thickness)
  + The originals are "3.620 inches wide and 2.613 inches tall" (according to Spiffworld's comment [here](https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men)), which includes a 1 pixel wide black border (confirmed in a personal communication).  That's about **9.2 cm** wide, and **6.6 cm** tall.

In practice, I found 7 cm (2.76 inches) is the minimum height to be readable above sleeved cards, and still fit resonably in the inserts from [TinkeringPaws](https://www.etsy.com/ca/listing/997029350/marvel-united-board-game-insert). The core box only allows for 6.8 cm clearance, but 7 cm tall fits at a slight angle, which also leaves extra space for grabbing cards between dividers.  The current settings might be a bit taller than 7 cm, since I can always cut them shorter than printed.  The beauty of this tool is that they can be resized to whatever height you prefer.

Note that because of how R Markdown and LaTeX handle images, the code here allows you to _increase the height_ relative to the original width, but not decrease it (i.e., it can only _decrease_ the aspect ratio).  It is possible to make the dividers even shorter in LaTeX, but would require additional code and clipping the original graphics, which isn't necessary for making them bigger.  If you want shorter dividers, you can just cut some off the bottom (up to a point): the main purpose of this tool is to allow **taller** dividers, which the original files don't allow.

## 3. Compile the Rmarkdown file

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

# License

This source code is licensed under the license found in the `LICENSE` file in the root directory of this repository (MIT License).
