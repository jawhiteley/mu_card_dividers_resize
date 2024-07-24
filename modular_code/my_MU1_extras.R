# R v4.4.1        Jonathan Whiteley        2024-07-24
# Modular code for processing a specific set of files
# Marvel United (season 1) - extras ====
# personal file for printing: extra content I decided to keep after all

## ---- modular-setup ----
pdf_file <- "mu_card_dividers_v2.pdf"

## ---- modular-processing ----
# Enter the Spider-Verse
img_files <- img_files[
  c(# Heroes
    c(28, 43, 45, 46)   # Spider-Verse.  Spider-Gwen: , 44
    ,
    # Villains
    c(68, 72)   # Bullseye? , 61
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary


## ---- modular-processing-alt ----
# Rise of the Black Panther
img_files <- img_files[
  c(# Heroes
    c(6, 42, 57)  # Black Panther
    ,
    # Villains
    71
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary

