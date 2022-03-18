locale=$(defaults read -g AppleLanguages | tr -d [:space:] | sed 's/[^a-zA-Z-]//g')
info_plist="$1/Contents/Info.plist"
info_plist_strings="$1/Contents/Resources/$locale.lproj/InfoPlist.strings"
if [ "$(/usr/libexec/PlistBuddy -c 'Print :LSHasLocalizedDisplayName' "$info_plist")" = "true" ]; then
  name=$(/usr/libexec/PlistBuddy -c "Print :CFBundleDisplayName" "$info_plist_strings")
  source="LSHasLocalizedDisplayName"
fi

if [ -z "$name" ]; then
  name=$(/usr/libexec/PlistBuddy -c "Print :CFBundleDisplayName" "$1/Contents/Info.plist")
  source="CFBundleDisplayName"
fi

if [ -z "$name" ]; then
  name=$(/usr/libexec/PlistBuddy -c "Print :CFBundleName" "$1/Contents/Info.plist")
  source="CFBundleName"
fi

if [ -z "$name" ]; then
  name=$(basename "$1" | sed 's/\.[^.]*$//')
  source="path"
fi

echo "Input: $1. Pulling $name" >&2

open -g "hammerspoon://pullWindow?appName=$name"