This is a place to record parameter values used to reproduce certain outputs.

# Complete sets for sharing

## Season 1 

```
  pdf_file: mu_card_dividers_v2.pdf
  extract_images: TRUE
  page_breaks: 59
```

Villians start at **59**.  Adding a page break here will not use extra pages, since the number of dividers pushed to the next page (2) would fit on the last page anyway.

## X-Men

```
  pdf_file: mu_x-men_horiz_dividers.pdf, mu_x-men_horiz_dividers_legion.pdf
  extract_images: TRUE
```

+ For X-Men (including the separate Legion file), I suggest the following page breaks (these will add as many as 4 pages, depending on which ones are used):

    - 4: Heroes (after missing Legion dividers)
    - 74: Alpha Flight (alternates)
    - 79: X-Men First Class (alternates)
    - 84: Fantastic Four (alternates)
    - 89: Villains
      - 119: Challenges, Misc. (only 3 cards)
    - 122: Phoenix 5 (alternates)
    - 127: Anti-Heroes (as Heroes)
      - 137: Anti-Heroes (as villains)
    - 146: Anti-Heroes (Hero alternates)
      - 156: Anti-Heroes (Villain alternates)
    - 165: Anti-Heroes (alternates, combined)

+ For X-Men (including Legion in the appropriate locations):

    - 71: Alpha Flight (alternates)
    - 76: X-Men First Class (alternates)
    - 81: Fantastic Four (alternates)
    - 86: Villains
      - 116: Challenges, Misc. (only 3 cards)
    - 119: Phoenix 5 (alternates)
    - 124: Anti-Heroes (as Heroes)
      - 134: Anti-Heroes (as villains)
    - 144: Anti-Heroes (Hero alternates)
      - 154: Anti-Heroes (Villain alternates)
    - 164: Anti-Heroes (alternates, combined)


For the file posted on BGG, I used `page_breaks` designed to work with a custom order of divider images, which groups heroes & villains that have alternates together (to make it easier to choose one set over another), inserts Legion tabs where they are missing, and moves the Challenges and Misc. dividers.  The custom order and page breaks only results in 1 extra page.  

The extracted images can be re-ordered by renaming them manually, or in the code by adding an index to line 94 (as of this writing) in the R Markdown file: `img_files <- list.files(...)[**HERE**]`

* divider index list & page breaks (easier to paste into R chunk): 
```
[
  c(# Heroes
    setdiff(
      c(1:70),
      c(c(26, 46, 53, 55, 58),  # skip Alpha Flight
        c(1, 4, 14, 31, 41),    # skip X-Men: First Class
        c(30, 33, 43, 57, 64)   # skip Fantastic Four
      )
    ),
    c(26, 46, 53, 55, 58),  # Alpha Flight
    c(1, 4, 14, 31, 41),    # X-Men: First Class
    c(30, 33, 43, 57, 64),  # Fantastic Four
    71:85,   # alternates (Alpha Flight, X-Men: First Class, Fantastic Four)
    # Villains
    86:102, 108:115,
    103:107, # Phoenix 5 with Super-Skrull
    119:123, # Phoenix 5 alts
    # Ant-Heroes (as standard heroes, villains)
    124:137, 171, # insert Legion villain
    138:142,
    116, 117, 118, # Challenges, Misc.
    # Anti-Heroes alts
    143:156, 172, # insert Legion villain alt
    157:165, 173, # insert Legion combined
    166:170
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c(61, 66, 71, 76, 81, 86, 116, 121, 144)
```




# Personal Settings (just what I want to print)

## Season 1 

```
  pdf_file: mu_card_dividers_v2.pdf
  extract_images: TRUE
```

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
    88,  # Missions, Challenges, Misc. (put these here as a separator, regardless of even or odd number of heroes)
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

* Enter the Spider-Verse
```
[
  c(# Heroes
    c(28, 43, 45, 46)   # Spider-Verse.  Spider-Gwen: , 44
    ,
    # Villains
    c(68, 72)   # Bullseye? , 61
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary
```


* Rise of the Black Panther
```
[
  c(# Heroes
    c(6, 42, 57)  # Black Panther
    ,
    # Villains
    71
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c() # unnecessary
```


 
## X-Men

```
  pdf_file: mu_x-men_horiz_dividers.pdf, mu_x-men_horiz_dividers_legion.pdf
  extract_images: TRUE
```

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


