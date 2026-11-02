#!/usr/bin/env bash
# packaging/android/build.sh: Antinode as a signed Android App Bundle for Google Play.
#
# No Gradle: the app is one Activity and one WebView, so this runs the same steps
# a build system would, where they can be read. Output: dist/antinode-<ver>-<code>.aab
#
# Needs ANDROID_HOME (default ~/Android/Sdk) with platform android-36.
# The upload key is read from ANTINODE_KEY_DIR (default ~/.config/antinode).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$here/../.." && pwd)"
MIN_SDK=24
TARGET_SDK=36

# versionCode must only ever go up. Hours since 2000 in UTC does that with no counter.
VERSION_NAME="${VERSION_NAME:-$(tr -d '[:space:]' < "$root/packaging/VERSION")}"
VERSION_CODE="${VERSION_CODE:-$(( ($(date -u +%s) - 946684800) / 3600 ))}"

SDK="${ANDROID_HOME:-$HOME/Android/Sdk}"
JAR="$SDK/platforms/android-$TARGET_SDK/android.jar"
BT="$(ls -d "$SDK"/build-tools/* | sort -V | tail -1)"
KEY_DIR="${ANTINODE_KEY_DIR:-$HOME/.config/antinode}"
for need in "$JAR" "$BT/aapt2" "$BT/d8" "$KEY_DIR/upload.jks" "$KEY_DIR/keystore-password.txt"; do
  [ -e "$need" ] || { echo "STOP: missing $need" >&2; exit 1; }
done

out="$root/dist"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$out" "$work/assets" "$work/gen" "$work/classes" "$work/module/manifest" "$work/module/dex"

echo "== 1. the game"
( cd "$root" && node app/build-drifter.mjs )
cp "$root/app/antinode.html" "$work/assets/index.html"

echo "== 2. resources (proto format, as a bundle requires)"
"$BT/aapt2" compile --dir "$here/res" -o "$work/res.zip"
"$BT/aapt2" link --proto-format -o "$work/base.apk" -I "$JAR" --manifest "$here/AndroidManifest.xml" \
  --min-sdk-version "$MIN_SDK" --target-sdk-version "$TARGET_SDK" \
  --version-code "$VERSION_CODE" --version-name "$VERSION_NAME" \
  -A "$work/assets" --java "$work/gen" --auto-add-overlay "$work/res.zip"

echo "== 3. code"
javac -source 8 -target 8 -Xlint:-options -encoding UTF-8 \
  -bootclasspath "$JAR" -classpath "$JAR" -d "$work/classes" \
  $(find "$here/java" "$work/gen" -name '*.java')
"$BT/d8" --release --min-api "$MIN_SDK" --lib "$JAR" --output "$work/module/dex" \
  $(find "$work/classes" -name '*.class')

echo "== 4. bundle"
unzip -q "$work/base.apk" -d "$work/linked"
mv "$work/linked/AndroidManifest.xml" "$work/module/manifest/"
mv "$work/linked/resources.pb" "$work/module/"
mv "$work/linked/res" "$work/linked/assets" "$work/module/"
python3 -c 'import shutil,sys; shutil.make_archive(sys.argv[1], "zip", sys.argv[2])' "$work/base" "$work/module"
aab="$out/antinode-$VERSION_NAME-$VERSION_CODE.aab"
rm -f "$aab"
"$here/bundletool.sh" build-bundle --modules="$work/base.zip" --output="$aab"

echo "== 5. sign with the upload key"
ANTINODE_KS_PASS="$(cat "$KEY_DIR/keystore-password.txt")"; export ANTINODE_KS_PASS
jarsigner -keystore "$KEY_DIR/upload.jks" -storepass:env ANTINODE_KS_PASS \
  -sigalg SHA256withRSA -digestalg SHA-256 "$aab" antinode-upload
jarsigner -verify "$aab" | tail -1
echo "== $aab  $(du -h "$aab" | cut -f1)  version $VERSION_NAME ($VERSION_CODE)"
