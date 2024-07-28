# To Do

+ [x] Find a way to add PATH to homebrew binaries (pdfimages) permanently
  + This should be set in your .Rprofile

- [ ] Try to preserve original color profile (Adobe RGB 1998)?
  - Use ImageMagick to slice images directly from command-line (using a call from within R)?

- Try a different method of preserving 150 ppi / dpi from the original to final output.
  - set dpi to 150 in extracted images?  Then images can be placed at scale = 100%
    - make this the default if divider width = blank?
  - set dpi to 150 in pdf (LaTeX)?
  - set image width to precisely n_pixels / 150 ppi?

- Vertical version (as requested)?
  - https://boardgamegeek.com/filepage/221561/vertical-card-dividers
  - https://boardgamegeek.com/filepage/228931/vertical-card-dividers-x-men
  * https://drive.google.com/drive/folders/13GJDg8u0EQPtyufb4QNH2CoMHwnT4GTD?usp=sharing

- Group parameters together in YAML header (to facilitate pasting options from `parameters.md`)?  [lower priority, now that I have added 'modular code' to collect all relevant parameters and code in a single file.]
  - File options: pdf_file, extract_images, page_breaks
  - Divider options: dimensions, border_colour, spacing

- Convert external script to a user-defined function that can be called directly from the R Markdown file.
  - That would allow default values for parameters / arguments that can easily be overidden, and avoid having a script that also needs to be able to run stand-alone.
  - If the code is simple enough, just include it directly in the R Markdown file for simplicity.  The block itself can still be run or not, but there would only be 1 file needed to do everything.


+ `pdfimages -all` extracts jpg files from X-Men files.
  - The classic file seems to include embedded pngs, whereas the X-Men files are embedded jpgs.
  - jpgs include a bit more metadata (Adobe Photoshop as creator, correct resolution of 150 dpi), but come already with a standard sRGB color profile.  Whereas exporting from the original pdf to jpg from Preview includes the Adobe RGB color profile (as with exporting to png).
  - Doesn't seem to make much difference. ImageMagick (magick) can still read & slice the image in whichever format it's in (the R function returns a list of the paths and filenames, so it can automatically find the extracted files, which is convenient), and still export to png.  The color profile seems to be lost during the initial extraction (by pdfimages) either way.


