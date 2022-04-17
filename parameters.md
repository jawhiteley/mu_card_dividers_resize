This is a place to record settings to reproduce certain outputs.

# Complete sets for sharing

## Season 1 

  pdf_file: mu_card_dividers_v2.pdf
  extract_images: TRUE
  page_breaks: 59


## X-Men

  pdf_file: mu_x-men_horiz_dividers.pdf, mu_x-men_horiz_dividers_legion.pdf
  extract_images: TRUE

The `page_breaks` are designed to work with a custom order of divider images, which inserts Legion tabs where they are missing, and moves the Challenges and Misc. dividers, resulting in only 1 extra page.  The extracted images can be re-ordered by renaming them manually, or in the code by adding an index to line 92 in the R Markdown file: `img_files <- list.files(...)[**HERE**]`

The code below is intended to make it easier to paste in temporarily to produce a desired output.

* divider index list (based on order of files in `pdf_file`): 
```
[
  c(1:115, # heroes, alts, villains
    119:123, # Phoenix 5
    118, 116, 117, # Misc, Challenges
    124:137, 171, # insert Legion villain
    138:156, 172, # insert Legion villain alt
    157:165, 173, # insert Legion combined
    166:170
    )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c(71, 76, 81, 86, 116, 122, 144)
```




# Personal Settings (just what I want to print)

## Season 1 

  pdf_file: mu_card_dividers_v2.pdf
  extract_images: TRUE

* divider index list & page breaks (easier to paste into R chunk): 
```
[
  c(# Heroes: skip Black Panther, Spider-Verse, and unwanted Promos
    setdiff(
      c(1:58),
      c(c(2, 5, 11, 13, 14, 17, 20, 22, 32, 36, 49, 58),  # skip unwanted Promos
        #c(26, 35, 55),  # less certain about skipping these
        c(6, 42, 57),  # skip Black Panther
        c(28, 43, 44, 45, 46)   # skip Spider-Verse
        )
    ),
    88,  # Missions, Challenges, Misc. (put these here as a separator, regardless of even or odd number of heroes.)
    # Villains: skip Black Panther, Spider-Verse, and unwanted Promos
    setdiff(59:87, 
      c(
        #c(79, 80, 86),  # less certain about skipping these
        c(61, 68, 71, 72) # skips
      )
    )
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary
```

 
## X-Men

  pdf_file: mu_x-men_horiz_dividers.pdf, mu_x-men_horiz_dividers_legion.pdf
  extract_images: TRUE

* divider index list & page breaks (easier to paste into R chunk): 
```
[
  c(# Heroes: skip FF & P5, and ones with alts that I'm using instead
    setdiff(
      c(1:70),
      c(c(26, 46, 53, 55, 58),  # skip Alpha Flight
        c(1, 4, 14, 31, 41),    # skip X-Men: First Class
        c(30, 33, 43, 57, 64),  # skip Fantastic Four
        29, 47  # skip Hope, Old Man Logan
        )
    ),
    71:75,   # Alpha Flight alts
    76:80,   # X-Men: First Class alts
    # 81:85, # skip Fantastic Four
    118, 116, 117, # Misc, Challenges
    # Villains: skip FF & P5
    setdiff(86:115, 
      c(103:107, 115)  # skip Phoenix 5, Super-Skrull
    ),  
    # 119:123, # skip Phoenix 5
    # Anti-heroes
    c(124:133)[-3], # skip Dr. Doom
    c(134:137, 
      171,          # insert Legion villain
      138:142)[-3], # skip Dr. Doom
    c()      # skip the rest
    # 143:156, # anti-heroes alts
    # 172, # insert Legion villain alt
    # 157:165, 
    # 173, # insert Legion combined
    # 166:170
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c()  # c(67, 91) unnecessary
```


