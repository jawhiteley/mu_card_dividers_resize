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

## Spider-Geddon

```
  pdf_file: spider-geddon_horiz_dividers.pdf
  extract_images: TRUE
```

* divider index list
```
[
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
```

## Multiverse

```
  pdf_file:  mu_season3_horiz_dividers.pdf, mu_horiz_update1.pdf
  extract_images: TRUE 
```

* divider index list; sort order:
  - by Box (custom order, depending on what fits best)
  - Kickstarter Exclusive items grouped together at the end or beginning 
    (in case a user is printing for a retail edition and doesn't need these, 
    they can be on a separate page, if necessary).
  - Heroes, Villains, Anti-Heroes, [Other]
    - Anti-Hero alts are sorted by name (Hero first, then Villain for each character): 
      I figure those wanting to use these are grouping them by character name 
      more than Hero / Villain; 
      plus, it looks nice with 2 columns and each row is a character.
  - Alphabetical by name
```
[
  c(# Alphabetical, by box: Heroes, Villains, Anti-Hero alts, Other, KS exclusives (if retail)
    # Core Box (1:13) [13-14]
    2, 1, 10, 3, 6, 4, 5, NA, 12, 7:9,
    11, 13,  # Anti-Hero alts
    # Galactus (14:23) [10]
    14, 16, 
    19:20, 22, 21, 17, 23, 
    15, 18,  # Anti-Hero alts
    # Pets (184:191) [8]
    184:191,
    # Promos (87:171) [63+7+9+7=85-86]
    ## Heroes
    97:98, 91, 96, 95, 89, 94, 88, 92:93, 
    112, 114, 116, 108, 99, 172, 100, 90, 120:121, 
    124, 126, 127, 129, 131, 134, 132, 140, 142, 152, 
    154, 155, 156, 157, 162, 160, 159, 164, 166, 170, 
    ## Villains
    167, 101, 103:106, 113, 107, 115, 109, 111, 
    118:119, 102, 122, 123, 125, 128, 130, 135, 133,
    153, 141, 158, 163, 165, 169, 171, 110, 
    ## Other
    173,     # Generic Equipment (Other or Promos? Wherever fits)  
    ## Anti-Heroes
    147, 146, 145, 144, 136, 137, 138, 139, 150, 151, 149, 148, 
    168,     # Winter Guard (Villain)
    117, 143, 161,  # Winter Guard (Heroes)
    # Civil War (49:58) [10-11; 12] - missing Mission, Event, Cell, Last Player cards? (Registration Clash, Clash of Heroes)
    58, 57,  # KS Exclusives
    53, 56, 49, 54, 55, 50, 51, 52,
    239, NA, # Population cards; placeholder for "Registration Clash"?
    # Maximum Carnage (64:73) [10]
    70, 
    67, 72, 64:66, 68,
    69,      # KS Exclusive
    71, 73,  # Anti-Hero Alts
    # World War Hulk (74:87) [14-15] - missing Anti-Hero alt for The Void? (present in vertical dividers)
    78, 77, 75, 74, 79,
    86, 87, 83,  # Villain Hulk (83) is "World Breaker Hulk"
    81, 85, 80, 84, 82, NA,  # Anti-Hero alts (placeholder for The Void)
    76,      # KS Exclusive
    # Age of Apocalypse (36:42) [7]
    38, 37, 39, 36,
    40:42,   # 40 = Apocalypse, to be replaced with correction (AOA)
    # Annihilation (59:63, 174) [6]
    62, 59:61, 63, 
    174,     # Complications Challenge
    # Secret Invasion (43:48) [6]
    44, 43, 45:46,
    47:48,
    # War of Kings (24:35) [12]
    24, 26, 32, 27:28, 30, 25, 29,
    34, 31,
    33, 35,  # Anti-Hero alts
    # Team Decks (192:222, 231:238) [39]
    192,
    193, 195:198, 200, 204, 209, 211, 214:218, 222,     # Retail
    231:233, 237, 234:236, 238,                         # Promos
    194, 199, 201:203, 205:208, 210, 212:213, 219:221,  # KSE optional buy
    ## 223-230 are from the equipment card pockets page (not accurately cropped): skip
    # Campaigns (175:183) [9]
    175:183,
    # Other
    NA
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c(13, 24) # 64, 112)
# Add Apocalypse (AOA) correction (standalone .jpg file)
img_tmp <- 
  magick::image_read('input/apocalypse.jpg') |> 
  magick::image_crop("541x390+1+1") |>
  magick::image_strip() |>
  magick::image_write(path = 'pdf_images/div-aoa.png', format = 'png')
# Replace image #40 with the corrected image
img_files <- sub("div-040.png", "div-aoa.png", img_files)
```

* Alternate layout:
  - bundle retail content together
  - then all the Kickstarter Exclusive content (in a separate file)
```
[
  c(# Alphabetical, by box: Heroes, Villains, Anti-Hero alts, Other, KS exclusives (if retail)
    # Core Box (1:13) [13-14]
    2, 1, 10, 3, 6, 4, 5, NA, 12, 7:9,
    11, 13,  # Anti-Hero alts
    # Maximum Carnage (64:73) [10]
    70, 
    67, 72, 64:66, 68,
    69,      # KS Exclusive
    71, 73,  # Anti-Hero Alts
    # Civil War (49:58) [10-11; 12] - missing Mission, Event, Cell, Last Player cards? (Registration Clash, Clash of Heroes)
    53, 56, 49, 54, 55, 50, 51, 52,
    58, 57,  # KS Exclusives
    239, # NA, # Population cards; placeholder for "Registration Clash"?
    # World War Hulk (74:87) [14-15] - missing Anti-Hero alt for The Void? (present in vertical dividers)
    76,      # KS Exclusive
    78, 77, 75, 74, 79,
    86, 87, 83,  # Villain Hulk (83) is "World Breaker Hulk"
    81, 85, 80, 84, 82, NA,  # Anti-Hero alts (placeholder for The Void)
    # Team Decks [15-16]
    192,
    193, 195:198, 200, 204, 209, 211, 214:218, 222,     # Retail
    # Galactus (14:23) [10]
    14, 16, 
    19:20, 22, 21, 17, 23, 
    15, 18,  # Anti-Hero alts
    # Pets (184:191) [8]
    184:191,
    # Promos (87:171) [63+7+9+7=85-86]
    ## Heroes
    97:98, 91, 96, 95, 89, 94, 88, 92:93, 
    112, 114, 116, 108, 99, 172, 100, 90, 120:121, 
    124, 126, 127, 129, 131, 134, 132, 140, 142, 152, 
    154, 155, 156, 157, 162, 160, 159, 164, 166, 170, 
    ## Villains
    167, 101, 103:106, 113, 107, 115, 109, 111, 
    118:119, 102, 122, 123, 125, 128, 130, 135, 133,
    153, 141, 158, 163, 165, 169, 171, 110, 
    ## Other
    173,     # Generic Equipment (Other or Promos? Wherever fits)  
    ## Anti-Heroes
    147, 146, 145, 144, 136, 137, 138, 139, 150, 151, 149, 148, 
    168,     # Winter Guard (Villain)
    117, 143, 161,  # Winter Guard (Heroes)
    # Age of Apocalypse (36:42) [7]
    38, 37, 39, 36,
    40:42,   # 40 = Apocalypse, to be replaced with correction (AOA)
    # Annihilation (59:63, 174) [6]
    62, 59:61, 63, 
    174,     # Complications Challenge
    # Secret Invasion (43:48) [6]
    44, 43, 45:46,
    47:48,
    # War of Kings (24:35) [12]
    24, 26, 32, 27:28, 30, 25, 29,
    34, 31,
    33, 35,  # Anti-Hero alts
    # Team Decks (192:222, 231:238) [39]
    192,
    231:233, 237, 234:236, 238,                         # Promos
    194, 199, 201:203, 205:208, 210, 212:213, 219:221,  # KSE optional buy
    ## 223-230 are from the equipment card pockets page (not accurately cropped): skip
    # Campaigns (175:183) [9]
    175:183,
    # Other
    NA
  )
]
# Custom page breaks based on custom divider list above.
page_breaks <- c(13, 125, 178)
# Add Apocalypse (AOA) correction (standalone .jpg file)
img_tmp <- 
  magick::image_read('input/apocalypse.jpg') |> 
  magick::image_crop("541x390+1+1") |>
  magick::image_strip() |>
  magick::image_write(path = 'pdf_images/div-aoa.png', format = 'png')
# Replace image #40 with the corrected image
img_files <- sub("div-040.png", "div-aoa.png", img_files)
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


