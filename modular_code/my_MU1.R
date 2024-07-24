# R v4.4.1        Jonathan Whiteley        2024-07-24
# Modular code for processing a specific set of files
# Marvel United (season 1) ====
# personal file for printing

## ---- modular-setup ----
pdf_file <- "mu_card_dividers_v2.pdf"

## ---- modular-processing ----
img_files <- img_files[
  c(# Heroes: skip Black Panther, Spider-Verse, and unwanted Promos
    setdiff(
      1:58,
      c(c(2, 5, 11, 13, 14, 17, 20, 22, 32, 36, 49, 58),  # skip unwanted Promos
        #c(26, 35, 55),  # less certain about skipping these
        c(6, 42, 57),  # skip Black Panther
        c(28, 43, 44, 45, 46)   # skip Spider-Verse
      )
    ),
    88,  # Missions, Challenges, Misc. (put these here as a separator, regardless of even or odd number of heroes)
    # Villains: skip Black Panther, Spider-Verse, and unwanted Promos
    setdiff(
      59:87, 
      c(
        #c(79, 80, 86),  # less certain about skipping these
        c(61, 68, 71, 72) # skips
      )
    )
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary
