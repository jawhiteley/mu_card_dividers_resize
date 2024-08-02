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

-   **CIELAB** scale: CIE 1976 Lºaºbº scale or L\*a\*b\* ("opponent-colours" theory based on human perception of colour)[^notes_color-3]

    -   L = Lightness (non-linear function of CIE Y value; square or cube root)

        -   black (0) -\> white (1)

    -   a = red (+) -\> green (-) dimension (response)

        -   also described as green to magenta[^notes_color-4]

    -   b = yellow (+) -\> blue (-) dimension

-   ∆E (CMC): total color difference[^notes_color-5]

    -   differences in lightness, chroma, hue, based on CIELAB color scale

-   **ICC**: **I**nternational **C**olor **C**onsortium[^notes_color-6]

-   **color gamut**: the range of all possible colors which can be represented or produced on a device.[^notes_color-7]

[^notes_color-1]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-2]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-3]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-4]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

[^notes_color-5]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-6]: <https://www.color.org/>

[^notes_color-7]: <https://www.color.org/profile.xalter>

## Working Space 

> Back in the late 1990's, with Photoshop 5, Adobe introduced an invaluable concept to its users, the RGB working space. These "device independent working spaces" are designed to be used for editing and storage or archiving of images. Unlike printer, scanner, camera or display screen profiles, working spaces are not used to describe
> specific devices.[^notes_color-8]

[^notes_color-8]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

> In summary, the RGB working space functions as a container for tonal and colour data independently of any specific device.[^notes_color-9]

[^notes_color-9]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

A working space essentially maps RGB codes to XYZ or L\*a\*b\*, allowing for more accurate reproduction across output colour profiles.[^notes_color-10]

[^notes_color-10]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

### **Example Working Spaces**[^notes_color-11]

[^notes_color-11]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

> **AdobeRGB(1998).icc**, intended to encompass most of the colours found in a photographic image on film, but a little restricted for that purpose.
>
> **sRGB Color Space Profile.icc,** designed to contain all the colours we can expect to see on an average PC monitor.
>
> **Chrome Space 100, J. Holmes.icc**, meticulously designed to enclose virtually all the colours an Ektachrome film can record.

The Adobe RGB working space has a slightly wider colour gamut than sRGB (especially in the greens).

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

    -   I know CMYK is often used for print (based on amounts of each colour ink). It is primarily an output profile, and not recommended as a "working space" (or device-independent color profile stored with an image).

    -   But what is the relationship between them? How is one converted to another?

    -   What is the impact of assuming one when colours were specified with another?

-   ~~'color space'~~ vs 'color model' vs ~~'color profile'~~?

    -   The macOS Finder reports a 'color space', which is simply 'RGB' for colour or 'Gray' for Greyscale.[^notes_color-12]

    -   The Finder also reports a "Color profile", which is the (a?) icc color profile, which Preview reports as the "ColorSync profile".

-   Can an image have more than one embedded profile? Why? How are they used?

    -   Different "intents"?

-   ~~What exactly does a color profile do?~~

    -   What is the impact of stripping it from the image file? (i.e., no color profile)

    -   Are there different types of color profiles? What is ICC? Are there others?

-   ~~color + color profile? screen vs print? device-dependent vs device-independent?~~

    -   An icc colour profile converts RGB information into an exact meaning related to human vision ('unequivocal').[^notes_color-13]

    -   A "device independent" profile is a "working space" used for editing.

    -   A "device independent" profile acts as a reference to define XYZ or L\*a\*b\* values used in a *Profile Conversion Space* when applying other profiles, such as a "device-dependent" *output* profile. This can also allow for "soft-proofing" where one output device (a monitor) can mimick another (print) by adjusting the colours.[^notes_color-14]

-   Is a "ColorSync profile" in Preview the same thing as a "color profile" (i.e., in Finder)?

    -   I assume so: ColorSync is simply the colour management system used by Preview and other macOS applications.

    -   <https://en.wikipedia.org/wiki/ColorSync>

    -   <https://support.apple.com/en-ca/guide/colorsync-utility/csyncad0012c/mac>

    -   Finder shows only broadest "color space" information: "RGB" = color, but it doesn't distinguish between RGB and sRGB\
        <https://apple.stackexchange.com/questions/445640/which-exact-color-space-is-rgb-in-macos-finders-get-info>

-   "Intent"?

[^notes_color-12]: <https://apple.stackexchange.com/questions/445640/which-exact-color-space-is-rgb-in-macos-finders-get-info>

[^notes_color-13]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

[^notes_color-14]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>
