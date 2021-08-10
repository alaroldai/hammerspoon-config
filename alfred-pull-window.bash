locale=$(defaults read -g AppleLanguages | tr -d [:space:] | sed 's/[^a-zA-Z-]//g')
info_plist="$1/Contents/Info.plist"
info_plist_strings="$1/Contents/Resources/$locale.lproj/InfoPlist.strings"
if [ "$(/usr/local/bin/PlistBuddy -c 'Print :LSHasLocalizedDisplayName' "$info_plist")" = "true" ]; then
  name=$(/usr/local/bin/PlistBuddy -c "Print :CFBundleDisplayName" "$info_plist_strings")
  source="localized"
fi

if [ -z "$name" ]; then
  name=$(/usr/local/bin/PlistBuddy -c "Print :CFBundleDisplayName" "$1/Contents/Info.plist")
  source="bundle"
fi

if [ -z "$name" ]; then
  name=$(basename "$1" | sed 's/\.[^.]*$//')
  source="path"
fi

open -g "hammerspoon://pullWindow?appName=$name"