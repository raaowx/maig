#!/usr/bin/env bash
# === === === FUNCTIONS === === === #
function help() {
  echo
  echo "Mobile App Icon Generator (MAIG) is a bash script to generate all necessary icons for Android or iOS apps and stores."
  echo
  echo "# === Description === #"
  echo
  echo "  MAIG will generate icons in all the resolutions needed for an Android or iOS app."
  echo "  In this process, MAIG uses the 'identify' and 'convert' utilities for resizing the original image several times. Those utilities are included in the Image Magick software."
  echo "  The original image should be squared. For Android the minimal resolution is 512x512 pixels (WxH), for iOS the minimal resolution is 1024x1024 pixels (WxH)."
  echo "  Generated icons will be stored on a folder called MAIG. This folder will be generated in the same location as the original image."
  echo
  echo "# === Parameters === #"
  echo
  echo "  -A : This parameter sets MAIG as Android icon generator."
  echo "  -I : This parameter sets MAIG as iOS icon generator."
  echo "  -i : This parameter sets the original image."
  echo "  -h : Show this message."
  echo
  echo "# === Usage === #"
  echo
  echo "  maig.bash [-A|-I] -i image"
  echo
  echo "# === Examples === #"
  echo
  echo "  maig.bash -A -i foo.png -> This will generate all necessary Android icons from foo.png"
  echo
  echo "  maig.bash -I -i foo.jpg -> This will generate all necessary iOS icons from foo.jpg"
  echo
  echo "# === Android icon list === #"
  echo
  echo "  For Android platform the following icons will be generated:"
  echo "    * LDPI    : 36x36   px"
  echo "    * MDPI    : 48x48   px"
  echo "    * TVDPI   : 64x64   px"
  echo "    * HDPI    : 72x72   px"
  echo "    * XHDPI   : 96x96   px"
  echo "    * XXHDPI  : 144x144 px"
  echo "    * XXXHDPI : 192x192 px"
  echo "    * WEB     : 512x512 px"
  echo "  Reference: https://material.io/design/iconography/"
  echo
  echo
  echo "# === iOS icon list === #"
  echo
  echo "  For iOS platform the following icons will be generated"
  echo "    * 20-1x   : 20x20     px --- 20-2x   : 40x40   px --- 20-3x : 60x60   px"
  echo "    * 29-1x   : 29x29     px --- 29-2x   : 58x58   px --- 29-3x : 87x87   px"
  echo "    * 40-1x   : 40x40     px --- 40-2x   : 80x80   px --- 40-3x : 120x120 px"
  echo "    * 60-1x   : 60x60     px --- 60-2x   : 120x120 px --- 60-3x : 180x180 px"
  echo "    * 76-1x   : 76x76     px --- 76-2x   : 152x152 px"
  echo "    * 83_5-1x : 84x84     px --- 83_5-2x : 167x167 px"
  echo "    * 1024-1x : 1024x1024 px"
  echo "  Reference: https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/"
  echo
  exit 0
}
function errorMessages() {
  case $1 in
    1)
      echo
      echo "[ERROR] MAIG script needs parameters for work correctly. Please, refer to help using '-h' parameter for more info."
      echo
      exit 1
      ;;
    2)
      echo
      echo "[ERROR] Invalid option '-$2'. Please, refer to help using parameter '-h' for more info."
      echo
      exit 2
      ;;
    3)
      echo
      echo "[ERROR] Option '-$2' requires an argument. Please, refere to help using parameter '-h' for more info."
      echo
      exit 3
      ;;
    4)
      echo
      echo "[ERROR] MAIG is already set to create $2 icons. Please, run the script again using only '-A' or '-I'. Refer to help with '-h' for more info."
      echo
      exit 4
      ;;
    5)
      echo
      echo "[ERROR] MAIG script needs utility '$2'. It can be found in the ImageMagick software. Please, install it or include it on PATH variable. Refer to help using parameter '-h' for more info."
      echo
      exit 5
      ;;
    6)
      echo
      echo "[ERROR] MAIG script needs parameter '-i' with an input file for work correctly. Please, refer to help using parameter '-h' for more info."
      echo
      exit 6
      ;;
    7)
      echo
      echo "[ERROR] Seems like you don't have read or write permissions over $INPUTFILE or $INPUTPATH. Please, check the permissions and try again."
      echo
      exit 7
      ;;
    8)
      echo
      echo "[ERROR] Original image should be squared. The given image have $2x$3 pixels (WxH)."
      echo
      exit 8
      ;;
    9)
      echo
      echo "[ERROR] For generating icons for $2 the original image should be at least $3x$3 pixels (WxH)."
      echo
      exit 9
      ;;
    10)
      echo
      echo "[ERROR] Generating app icons. Please, try again."
      echo
      exit 10
      ;;
    *)
      echo
      echo "[ERROR] Check 'help' using parameter '-h' for more info."
      echo
      exit 255
      ;;
  esac
}
function genIcons() {
  echo "Starting $1 icon generation..."
  echo
  cd "$INPUTPATH"
  COUNT=0
  for i in ${ICONLIST[@]}; do
    convert "$INPUTFILE" -resize $ix$i "$OUTPUTDIR/${INPUTFILE%%.*}-${ICONNAME[$COUNT]}.${INPUTFILE#*.}"
    if [[ $? -eq 0 ]]; then
      echo "[SUCCESS] Generating icon with size $ix$i."
    else
      echo "[ERROR] Generating icon with size $ix$i."
    fi
    COUNT=$(( $COUNT + 1 ))
  done
  goodbye
}
function cleanMaig() {
  rmdir "$INPUTPATH/$OUTPUTDIR"
}
function goodbye() {
  if [[ $? -eq 0 ]]; then
    echo
    echo "All generated icon are stored in '$INPUTPATH/$OUTPUTDIR'."
    echo
    echo "# === Icons successfully generated === #"
  else
    errorMessages 10
  fi
}
# === === === VARIABLE DECLARATION === === === #
ANDROID=false
IOS=false
INPUTPATH=""
INPUTFILE=""
OUTPUTDIR="MAIG"
declare -a ICONLIST
declare -a ICONNAME
# === === === SCRIPT INIT === === === #
echo "# === ==== === #"
echo "      MAIG     "
echo "# === ==== === #"
if [[ $# -eq 0 ]]; then
  errorMessages 1
fi
while getopts ":AIhi:" opt; do
  case ${opt} in
    A)
      if [[ "$IOS" == "false" ]]; then
        ANDROID=true
      else
        errorMessages 4 iOS
      fi
      ;;
    I)
      if [[ "$ANDROID" == "false" ]]; then
        IOS=true
      else
        errorMessages 4 Android
      fi
      ;;
    h)
      help
      ;;
    i)
      INPUTPATH=$(dirname "$OPTARG")
      INPUTFILE=$(basename "$OPTARG")
      ;;
    *)
      if [[ "$opt" == "?" ]]; then
        errorMessages 2 "$OPTARG"
      elif [[ "$opt" == ":" ]]; then
        errorMessages 3 "$OPTARG"
      else
        errorMessages
      fi
      ;;
  esac
done
which convert &> /dev/null
if [[ $? -ne 0 ]]; then
  errorMessages 5 convert
fi
which identify &> /dev/null
if [[ $? -ne 0 ]]; then
  errorMessages 5 identify
fi
if [[ "$INPUTPATH" == "" ]] || [[ "$INPUTFILE" == "" ]]; then
  errorMessages 6
fi
echo "Checking permission on the given file and path..."
if [[ -w $INPUTPATH ]] && [[ -r "$INPUTPATH/$INPUTFILE" ]]; then
  if ! [[ -d "$INPUTPATH/$OUTPUTDIR" ]]; then
    mkdir "$INPUTPATH/$OUTPUTDIR"
  fi
  echo "Checking image size..."
  W=$(identify -format %w "$INPUTPATH/$INPUTFILE") # Width (x)
  H=$(identify -format %h "$INPUTPATH/$INPUTFILE") # Height (y)
  if [[ $W -eq $H ]]; then
    if [[ "$ANDROID" == true ]]; then
      if [[ $W -ge 512 ]] && [[ $H -ge 512 ]]; then
        # Reference: https://material.io/design/iconography/
        ICONLIST=(36 48 64 72 96 144 192 512)
        ICONNAME=("LDPI" "MDPI" "TVDPI" "HDPI" "XHDPI" "XXHDPI" "XXXHDPI" "WEB")
        genIcons Android
      else
        cleanMaig
        errorMessages 8 Android 512
      fi
    elif [[ "$IOS" == true ]]; then
      if [[ $W -ge 1024 ]] && [[ $H -ge 1024 ]]; then
        # Reference: https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/
        ICONLIST=(20 40 60 29 58 87 40 80 120 60 120 180 76 152 83.5 167 1024)
        ICONNAME=("20-1x" "20-2x" "20-3x" "29-1x" "29-2x" "29-3x" "40-1x" "40-2x" "40-3x" "60-1x" "60-2x" "60-3x" "76-1x" "76-2x" "83_5-1x" "83_5-2x" "1024-1x")
        genIcons iOS
      else
        cleanMaig
        errorMessages 9 iOS 1024
      fi
    else
      cleanMaig
      errorMessages
    fi
  else
    cleanMaig
    errorMessages 8 $W $H
  fi
else
  errorMessages 7
fi
