# Notes on colour and color profiles

Still learning :)

# Terms

-   3 dimensions of colour[^notes_color-1]:

    -   **Hue**

        -   position / angle
        -   red, blue, green, yellow, orange, etc. (circle)

    -   **Saturation** / chroma

        -   distance from the vertical (lightness) axis
        -   grey -\> full colour (inner -\> outer)

    -   **Lightness** / value / *"brightness" [incorrect]*

        -   height along the vertical axis
        -   black -\> white (bottom -\> top)

-   **CIE**: Commission Internationale de l’Eclairage

-   **CIE X, Y, Z**: tristimulus values of colour-matching response function[^notes_color-2]

    -   Weighting values for wavelengths of red (X), green (Y), and blue (Z)

    -   aka "CIE Standard Observer"

    -   2º observer (small area, narrow viewing angle) (1931)

    -   10º observer (large area, wider viewing angle) (1964)

-   **CIELAB** scale: CIE 1976 Lºaºbº scale ("opponent-colours" theory based on human perception of colour)[^notes_color-3]

    -   L = Lightness (non-linear function of CIE Y value; square or cube root)

        -   black (0) -\> white (1)

    -   a = red (+) -\> green (-) dimension (response)

    -   b = yellow (+) -\> blue (-) dimension

-   ∆E (CMC): total color difference[^notes_color-4]

    -   differences in lightness, chroma, hue, based on CIELAB color scale

-   **ICC**: **I**nternational **C**olor **C**onsortium[^notes_color-5]

-   **color gamut**: the range of all possible colors which can be represented or produced on a device.[^notes_color-6]

[^notes_color-1]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-2]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-3]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-4]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-5]: <https://www.color.org/>

[^notes_color-6]: <https://www.color.org/profile.xalter>

# Reading list

<https://www.color.org/ss84.pdf>

<https://www.color.org/profile.xalter>

<https://www.color.org/iccprofile.xalter>

<https://www.colourmanagement.net/advice/about-icc-colour-profiles>

<https://en.wikipedia.org/wiki/ICC_profile>

<https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

<https://en.wikipedia.org/wiki/ColorSync>

<https://apple.stackexchange.com/questions/235930/how-do-i-remove-a-colorsync-profile-from-a-jpeg-image-from-terminal-in-el-capita>

## Questions

-   RGB vs sRGB vs CMYK

    -   I know CMYK is often used for print (based on amounts of each colour ink)

    -   But what is the relationship between them? How is one converted to another?

    -   What is the impact of assuming one when colours were specified with another?

-   'color space' vs 'color profile'?

-   What exactly does a color profile do?

    -   What is the impact of stripping it from the image file? (i.e., no color profile)

    -   Are there different types of color profiles? What is ICC? Are there others?

-   color + color profile? screen vs print? device-dependent vs device-independent?

-   Is a "ColorSync profile" in Preview the same thing as a "color profile" (i.e., in Finder)?

    -   <https://en.wikipedia.org/wiki/ColorSync>

    -   <https://support.apple.com/en-ca/guide/colorsync-utility/csyncad0012c/mac>

    -   Finder shows only broadest "color space" information: "RGB" = color, but it doesn't distinguish between RGB and sRGB\
        <https://apple.stackexchange.com/questions/445640/which-exact-color-space-is-rgb-in-macos-finders-get-info>

-   "Intent"?
