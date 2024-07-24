# R v4.4.1        Jonathan Whiteley        2024-07-24
# Modular code for processing a specific set of files
# Marvel United: Spider-Geddon core box (retail exclusive) ====

## ---- modular-setup ----
pdf_file <- "spider-geddon_horiz_dividers.pdf"

## ---- modular-processing ----
img_files <- img_files[
  c(
    1:8,
    ## Anti-Venom: Hero, Villain
    9, 11,
    ## Superior Spider-Man: Hero, Villain
    13, 15,
    ## Anti-Hero (purple) dividers on separate page
    10, 12, 14, 16
  )
]