# R v4.4.1        Jonathan Whiteley        2024-07-24
# Modular code for processing a specific set of files
# TEMPLATE ====

## ---- modular-setup ----
pdf_file <- "mu_card_dividers_v2.pdf"
unlockBinding("params", env = .GlobalEnv)  # `params` in knitr is usually locked during rendering.
params$extract_images <- TRUE
lockBinding("params", env = .GlobalEnv)  # lock `params` again.


## ---- modular-processing ----
page_breaks <- 59
