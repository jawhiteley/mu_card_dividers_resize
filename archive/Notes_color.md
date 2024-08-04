# Notes on colour and color profiles

Still learning — but becoming clearer. :)

# Terms

-   **color model**: a mathematical model describing the way [colors](https://en.wikipedia.org/wiki/Color "Color") can be represented as [tuples](https://en.wikipedia.org/wiki/Tuples "Tuples") of numbers, typically as three or four values or color components.[^notes_color-1]

    -   **CMYK** (Cyan, Magenta, Yellow, blacK): subtractive color model, used in (offset) printing to define colours based on mixes of inks.

    -   **RGB** (Red, Green, Blue): Additive colour model, based on combinations of different amounts of light in each range of wavelengths.

    -   Cylindrical models:[^notes_color-2]

        -   **HSL** (Hue, Saturation, Lightness)

        -   **HSV** (Hue, Saturation, Value)

    -   3 dimensions of colour[^notes_color-3] (in a *cylindrical* '**color model**'):

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

-   **CIE X, Y, Z**: tristimulus values of colour-matching response function[^notes_color-4],[^notes_color-5]

    -   Weighting values for wavelengths of red (X), green (Y), and blue (Z)?

        -   Also described as Long (red), Medium (green) and Short (blue) wavelengths[^notes_color-6]

    -   aka "CIE Standard Observer"

    -   2º observer (small area, narrow viewing angle) (1931)

    -   10º observer (large area, wider viewing angle) (1964)

    -   Y is luminance. Z and X are related to human cone response curves.[^notes_color-7] ?

-   **CIELAB** scale: CIE 1976 Lºaºbº scale or L\*a\*b\* ("opponent-colours" theory based on human perception of colour)[^notes_color-8]

    -   L = Lightness (non-linear function of CIE Y value; square or cube root)

        -   black (0) -\> white (1)

    -   a = red (+) -\> green (-) dimension (response)

        -   also described as green to magenta[^notes_color-9]

    -   b = yellow (+) -\> blue (-) dimension

-   ∆E (CMC): total color difference[^notes_color-10]

    -   differences in lightness, chroma, hue, based on CIELAB color scale

-   **ICC**: **I**nternational **C**olor **C**onsortium[^notes_color-11]

-   **color gamut**: the range of all possible colors which can be represented or produced on a device.[^notes_color-12]

-   **Profile Connection Space (PCS)** / Profile Conversion space: a standard colour space that provides an interface between input and output profiles.

    -   It is the virtual destination for input transforms and the virtual source for output transforms.[^notes_color-13]

    -   If the input and output transforms are based on the same PCS definition, even though they are created independently, they can be paired arbitrarily at run time by the color-management engine (CMM) and will yield consistent and predictable results when applied to color values.[^notes_color-14]

    -   Often defined in terms of an "absolute color space", such as CIELAB or CIEXYZ.

        -   These depend on viewing conditions.[^notes_color-15],[^notes_color-16]

    -   The [CIE 1976 L\*, a\*, b\* color space](https://en.wikipedia.org/wiki/CIELAB_color_space "CIELAB color space") is sometimes referred to as absolute, though it also needs a [white point](https://en.wikipedia.org/wiki/White_point "White point") specification to make it so.[^notes_color-17]

    -   Pairing a color space like RGB with an ICC profile (a "working space"), allows the RGB color values to refer to 'absolute colors'.[^notes_color-18]

[^notes_color-1]: <https://en.wikipedia.org/wiki/Color_model>

[^notes_color-2]: <https://en.wikipedia.org/wiki/HSL_and_HSV>

[^notes_color-3]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-4]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-5]: <https://en.wikipedia.org/wiki/Color_model#CIE_XYZ_color_space>

[^notes_color-6]: <https://en.wikipedia.org/wiki/Color_model#Tristimulus_color_space>

[^notes_color-7]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

[^notes_color-8]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-9]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

[^notes_color-10]: Harold, R. W. 2001. [An Introduction to Appearance Analysis](https://www.color.org/ss84.pdf)

[^notes_color-11]: <https://www.color.org/>

[^notes_color-12]: <https://www.color.org/profile.xalter>

[^notes_color-13]: <https://www.color.org/iccprofile.xalter>

[^notes_color-14]: <https://www.color.org/iccprofile.xalter>

[^notes_color-15]: <https://en.wikipedia.org/wiki/Color_space#Conversion_errors>

[^notes_color-16]: <https://www.color.org/iccprofile.xalter>

[^notes_color-17]: <https://en.wikipedia.org/wiki/Color_space#Absolute_color_space>

[^notes_color-18]: <https://en.wikipedia.org/wiki/Color_space#Absolute_color_space>

## Working Space 

> Back in the late 1990's, with Photoshop 5, Adobe introduced an invaluable concept to its users, the RGB working space. These "device independent working spaces" are designed to be used for editing and storage or archiving of images. Unlike printer, scanner, camera or display screen profiles, working spaces are not used to describe
> specific devices.[^notes_color-19]

[^notes_color-19]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

> In summary, the RGB working space functions as a container for tonal and colour data independently of any specific device.[^notes_color-20]

[^notes_color-20]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

A working space essentially maps RGB codes to XYZ or L\*a\*b\* [an absolute colour space[^notes_color-21], which can serve as a Profile Connection Space], allowing for more accurate reproduction across output colour profiles.[^notes_color-22]

[^notes_color-21]: <https://en.wikipedia.org/wiki/Color_space#Absolute_color_space>

[^notes_color-22]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

### **Example Working Spaces**[^notes_color-23]

[^notes_color-23]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#workingspaces>

> **AdobeRGB(1998).icc**, intended to encompass most of the colours found in a photographic image on film, but a little restricted for that purpose.
>
> **sRGB Color Space Profile.icc,** designed to contain all the colours we can expect to see on an average PC monitor.
>
> **Chrome Space 100, J. Holmes.icc**, meticulously designed to enclose virtually all the colours an Ektachrome film can record.

**sRGB IEC61966-2.1 (sRGB)** is a RGB color space proposed by HP and Microsoft because it approximates the color gamut of the most common computer display devices. [^notes_color-24]

[^notes_color-24]: <https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

The **Adobe RGB** working space has a slightly wider colour gamut than sRGB (especially in the greens).[^notes_color-25]

[^notes_color-25]: <https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

-   A larger gamut also means that available bit depth (e.g., 8-bit) has to cover a wider range of colours. If all the colours in use are within a smaller gamut, using a larger colour space ends up in 'wasted' bits, and fewer unique colours that are actually used.[^notes_color-26]

    -   "Using larger gamuts just wastes 'color precision' on unused colors."[^notes_color-27]

-   With more bit-depth, this trade-off is less important, and using a working space with a larger gamut is not as much of an issue.[^notes_color-28]

[^notes_color-26]: <https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

[^notes_color-27]: [https://discussions.apple.com/thread/574176](https://discussions.apple.com/thread/574176?sortBy=rank){.uri}

[^notes_color-28]: <https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

# Reading list

<https://www.color.org/ss84.pdf>

<https://www.color.org/profile.xalter>

<https://www.color.org/iccprofile.xalter>

<https://www.colourmanagement.net/advice/about-icc-colour-profiles>

<https://www.cambridgeincolour.com/tutorials/srgb-adobergb1998.htm>

<https://en.wikipedia.org/wiki/ICC_profile>

<https://en.wikipedia.org/wiki/ColorSync>

<https://apple.stackexchange.com/questions/235930/how-do-i-remove-a-colorsync-profile-from-a-jpeg-image-from-terminal-in-el-capita>

## Questions

-   ~~RGB vs sRGB vs CMYK~~

    -   ~~But what is the relationship between them? How is one converted to another?~~

-   ~~'color space'~~ vs ~~'color model'~~ vs ~~'color profile'~~ (in Preview and Finder on macOS)?

    -   The macOS Finder reports a 'color space', which is simply 'RGB' for colour or 'Gray' for Greyscale.[^notes_color-29]

    -   The Finder also reports a "Color profile", which is the (/a?) icc color profile, which Preview reports as the "ColorSync profile".

    -   I'm assuming the 'color model' reflects how the color values are specified in the file: RGB, CMYK, etc.[^notes_color-30]

-   Can an image have more than one embedded profile? Why? How are they used?

    -   Different "intents"?

-   ~~What exactly does a color profile do?~~

    -   What is the impact of stripping it from the image file? (i.e., no color profile)

    -   What is the impact of assuming one when colours were specified with another?

    -   Are there different types of color profiles? ~~What is ICC?~~ Are there others?

-   ~~color + color profile? screen vs print? device-dependent vs device-independent?~~

    -   An icc colour profile converts RGB information into an exact meaning related to human vision ('unequivocal').[^notes_color-31]

    -   A "device independent" profile is a "working space" used for editing.

    -   A "device independent" profile acts as a reference to define XYZ or L\*a\*b\* values used in a *Profile Conversion Space* when applying other profiles, such as a "device-dependent" *output* profile. This can also allow for "soft-proofing" where one output device (a monitor) can mimick another (print) by adjusting the colours.[^notes_color-32]

-   Is a "ColorSync profile" in Preview the same thing as a "color profile" (i.e., in Finder)?

    -   I assume so: ColorSync is simply the colour management system used by Preview and other macOS applications.

    -   <https://en.wikipedia.org/wiki/ColorSync>

    -   <https://support.apple.com/en-ca/guide/colorsync-utility/csyncad0012c/mac>

    -   Finder shows only broadest "color space" information: "RGB" = color, but it doesn't distinguish between RGB and sRGB\
        <https://apple.stackexchange.com/questions/445640/which-exact-color-space-is-rgb-in-macos-finders-get-info>

-   "Intent"?

    -   See: <https://www.colourmanagement.net/advice/about-icc-colour-profiles>

    -   But how is it specified in a file, and what impact does it have?

    -   Are certain profiles implicitly one type of "intent"?

    -   I have seen references to some software ignoring profiles or intent (or both) - what does this mean, and why does it happen?

-   Can a profile be tagged / embedded in a pdf file, embedded images, or both?

    -   <https://www.color.org/profile_embedding.xalter>

        -   <https://www.color.org/technotes/ICC-Technote-ProfileEmbedding.pdf>

    -   <https://stackoverflow.com/questions/31591554/embed-icc-color-profile-in-pdf>

    -   <https://www.littlecms.com/> (part of poppler-utils)

[^notes_color-29]: <https://apple.stackexchange.com/questions/445640/which-exact-color-space-is-rgb-in-macos-finders-get-info>

[^notes_color-30]: See also: <https://developer.apple.com/design/human-interface-guidelines/color#Color-management>

[^notes_color-31]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>

[^notes_color-32]: <https://www.colourmanagement.net/advice/about-icc-colour-profiles#what_profiles_do>
