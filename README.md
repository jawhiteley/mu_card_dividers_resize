Automatically re-size Spiffworld's horizontal dividers for Marvel United in Rmarkdown.

Spiffworld has created some excellent horizontal dividers for all the cards in Marvel United on BGG:

* https://boardgamegeek.com/filepage/220250/horizontal-card-dividers
* https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men

These dividers look great and are very space-efficient: they only extend above unsleeved cards by about 4 mm, yet are still readable (and look great).  Recent versions even include handy reference information, like the number of symbols, and tokens for Super-Villain Mode.

As some have noted, the original dividers are so efficient that they barely extend above sleeved cards, or not at all in the case of some premium sleeves.  Many have asked for a version that was taller, but that's a lot of work to maintain for someone in their spare time.  Like others, I have considered various craft hacks, but ultimately decided I wanted the simplicity of printing & cutting, and decided to challenge myself to see if I could resize them programmatically.

I used [R](https://www.r-project.org/) and [R Markdown](https://rmarkdown.rstudio.com/) to output to PDF via LaTeX, because that's what I'm familiar with.  I have no doubt this could be done in python, probably more efficiently.  I just haven't learned enough python to do it yet.


# Requirements

* [R](https://www.r-project.org/), with packages:
  + [rmarkdown](https://rmarkdown.rstudio.com/)
  + knitr
  + [pdfimager](https://sckott.github.io/pdfimager/)
  + [magick](https://cran.r-project.org/web/packages/magick/vignettes/intro.html) (ImageMagick)
  + magrittr (pipe operator)
* the pdfimager package also requires the pdfimages command-line tool, which is part of the [poppler](https://poppler.freedesktop.org/) library.
  + This can be installed on a Mac with [homebrew](https://brew.sh/) using the command:
    
        brew install poppler



# How to Use

Everything you need is in the `mu dividers resize.Rmd` file.  This is an R Markdown file that was designed to be able to run in one step, but if you want, you can do the process in 2 steps:

1. Extract images from input pdf file (i.e., the originals on BGG)
2. Re-size and output to pdf

Step 1 is performed by the R script `mu dividers resize.r`: all the relevant parameters for this step are in the R script file, not in the Rmarkdown file.  The Rmarkdown file can run this script automatically, but you don't have to: see the comments in the second r chunk (`extract`) to disable the external script if it has already run, or enable it to do everything in 1 step.

## Set Parameters

* Name of input pdf file
  + this needs to be set in the R script file
* Name of the output pdf file
  + this needs to be set in the Rmarkdown file
* Dimensions of dividers in output
  + The originals are "3.620 inches wide and 2.613 inches tall" (according to Spiffworld's comment [here](https://boardgamegeek.com/filepage/228893/horizontal-card-dividers-x-men)), though I'm not sure if that includes the borders or not.
  + That's **9.19 cm** wide, and **6.64 cm** tall.  In practice, I have been approximating as 9.2 cm \times 6.6 cm.
  + In practice, I found **7 cm** (2.76 inches) is the minimum height to be readable above sleeved cards.

## Compile the Rmarkdown file

Once the parameters have been set, you just need to `knit` the R Markdown file.  In Rstudio, you can simply click on the **Knit** button: see "[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/compile.html)" for more details.

The compilation process will:

1. Run the R code embedded in the R Markdown file, producing a Markdown file.
2. Compile the Markdown file into LaTeX.
3. Compile the LaTeX file into the final pdf.
4. Clean-up and remove the intermediary (Markdown, LaTeX) files.

This means that there are several places where things can go wrong: in R (step 1), in Markdown (step 2), or LaTeX (step 3).

The R Markdown file uses a lot of custom LaTeX to achieve the desired result, which is to able to layout the pages dynamically, with no horizontal or vertical space between dividers.  This may not always work on other systems, especially if you have different LaTeX parameters.  

# To Do

* Collect all the parameters in one place.
* Make R script use parameters from the Rmarkdown file, meaning it could not be run independently.  You can run individual R chunks from the Rmarkdown file, like a notebook, so this should still be functional.  Maybe I'll add a block of necessary parameters in an `if` block so it won't run when source()d, but is still available if running it separately.


# License

This source code is licensed under the license found in the `LICENSE` file in the root directory of this repository (MIT License).
