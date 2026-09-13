#!/bin/bash
# Build a double-clickable macOS launcher for Lunch Call.
# Opens Chrome in app mode (no tabs, no address bar) when available,
# otherwise falls back to the default browser.
set -euo pipefail
URL="${1:-https://dhwdue.github.io/lunch-call/}"
DEST="${2:-$HOME/Desktop}"
APP="$DEST/Lunch Call.app"
HERE="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/launcher.applescript" <<APPLESCRIPT
on run
	set theURL to "$URL"
	try
		do shell script "open -na '/Applications/Google Chrome.app' --args --app=" & quoted form of theURL
	on error
		open location theURL
	end try
end run
APPLESCRIPT

rm -rf "$APP"
osacompile -o "$APP" "$TMP/launcher.applescript"

# app icon from the same source as the web app icons
mkdir -p "$TMP/i.iconset"
for sz in 16 32 128 256 512; do
  sips -z $sz $sz "$HERE/icon-512.png" --out "$TMP/i.iconset/icon_${sz}x${sz}.png" >/dev/null
  sips -z $((sz*2)) $((sz*2)) "$HERE/icon-512.png" --out "$TMP/i.iconset/icon_${sz}x${sz}@2x.png" >/dev/null
done
iconutil -c icns "$TMP/i.iconset" -o "$APP/Contents/Resources/applet.icns"

/usr/libexec/PlistBuddy -c "Set :CFBundleName 'Lunch Call'" "$APP/Contents/Info.plist" 2>/dev/null || true
touch "$APP"   # nudge Finder to re-read the icon
echo "built: $APP"
