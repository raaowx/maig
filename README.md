# MAIG (Mobile App Icon Generator)

## What is MAIG?
MAIG (_Mobile App Icon Generator_) is a bash script that automatically generates all necessary icons for Android or iOS platforms. The icons will be generated in all the resolutions needed for an Android or iOS app.

<img src="./maig.png" width="25">

## How it works?
MAIG first analyze the parameters and look for the third party software it needs. If everything is correct, MAIG will check if the resolution of the original image is the minimal required for the selected platform. After that the generation will begin. When the scripts end, you can find all the generated icons in a folder called `MAIG` in the same location as the original image.

**_Example:_**  
Path to the original image: `/path/to/original/image/foo.ext`  
Path to the MAIG folder where generated icons will be stored: `/path/to/original/image/MAIG`

### Third Party Software
In the generation process, MAIG uses the [identify](https://www.imagemagick.org/script/identify.php) and [convert](https://imagemagick.org/script/convert.php) utilities for resizing the original image several times. Those utilities are included in the [Image Magick](https://imagemagick.org) software.

## Parameters
`-A` : This parameter sets MAIG as Android icon generator.  
`-I` : This parameter sets MAIG as iOS icon generator.  
`-i` : This parameter sets the original image.  
`-h` : Show the help message.

## Usage
`maig.bash [-A|-I] -i /path/to/image/foo.ext`

**_Example:_**  
`maig.bash -A -i /path/to/image/foo.ext` : This will generate all necessary Android icons from `foo.ext`  
`maig.bash -A -i foo.ext` : This will generate all necessary iOS icons from `foo.ext`  

## Android Icons
Android minimal resolution is 512x512 pixels (WxH).  
For Android platform the following icons will be generated:  

Name|Resolution|Filename
:---:|:---:|:---:
LDPI|36x36px|foo-LDPI.ext
MDPI|48x48px|foo-LDPI.ext
TVDPI|64x64px|foo-LDPI.ext
XHDPI|72x72px|foo-LDPI.ext
XXHDPI|96x96px|foo-LDPI.ext
XXXDPI|144x144px|foo-LDPI.ext
WEB|512x512px|foo-WEB.ext

**_Reference:_** [Android Documentation](https://material.io/design/iconography/)

## iOS Icons
iOS minimal resolution is 1024x1024 pixels (WxH).  
For iOS platform the following icons will be generated:  

Name|Resolution|Filename
:---:|:---:|:---:
20-1x|20x20px|foo-20-1x.ext
20-2x|40x40px|foo-20-2x.ext
20-3x|60x60px|foo-20-3x.ext
29-1x|29x29px|foo-29-1x.ext
29-2x|58x58px|foo-29-2x.ext
29-3x|87x87px|foo-29-3x.ext
40-1x|40x40px|foo-40-1x.ext
40-2x|80x80px|foo-40-2x.ext
40-3x|120x120px|foo-40-3x.ext
60-1x|60x60px|foo-60-1x.ext
60-2x|120x120px|foo-60-2x.ext
60-3x|180x180px|foo-60-3x.ext
76-1x|76x76px|foo-76-1x.ext
76-2x|152x152px|foo-76-2x.ext
83_5-1x|84x84px|foo-83_5-1x.ext
83_5-2x|167x167px|foo-83_5-2x.ext
1024-1x|1024x1024px|foo-1024-1x.ext

**_Reference:_** [iOS Documentation](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)

## Exit Codes

Code|Description|
:---:|---
1|MAIG script needs parameters to work correctly
2|Invalid option `-foo`
3|Option `-i` require an argument
4|MAIG is already set to create Android or iOS icons
5|MAIG script needs utility `identify` or `convert`. It can be found in the ImageMagick software.
6|MAIG script needs parameter `-i` with an input file for work correctly.
7|Seems like you don't have read or write permissions over the original image or image's folder
8|Original image should be squared
9|For generating icons for Android or iOS the original image should be at least `foo x foo` pixels (WxH)
10|Generic error 1: Generating app icons
255|Generic error 2: Check help using parameter `-h` for more info



## License
The script is licensed with MIT License.

## Project Icon
[Icon](https://www.flaticon.com/free-icon/smartphone_148998) made by [Smashicons](https://www.flaticon.com/authors/smashicons) is licensed by [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/)

Copyright © 2019 **Álvaro López de Diego {raaowx}** <raaowx@icloud.com>
