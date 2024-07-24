# R v4.4.1        Jonathan Whiteley        2024-07-24
# Modular code for processing a specific set of files
# Marvel United season 1 ====

## ---- modular-setup ----
pdf_file <- "mu_card_dividers_v2.pdf"

## ---- modular-processing ----
# Villians start at **59**.  Adding a page break here will not use extra pages, 
# since the number of dividers pushed to the next page (2) would fit on the last page anyway.
page_breaks <- 59
