#!/usr/bin/env bash
# Runs bundletool from the jars Gradle already cached (no separate download).
# Set BUNDLETOOL=/path/to/bundletool-all.jar to use a standalone copy instead.
set -euo pipefail
if [ -n "${BUNDLETOOL:-}" ]; then exec java -jar "$BUNDLETOOL" "$@"; fi
cache="$HOME/.gradle/caches/modules-2/files-2.1"
cp=""
for a in bundletool guava failureaccess protobuf-java protobuf-java-util gson jose4j dagger javax.inject auto-value-annotations aapt2-proto apksig apkzlib slf4j-api kotlin-stdlib common ddmlib sdk-common sdklib annotations; do
  j="$(find "$cache" -name "$a-[0-9]*.jar" ! -name '*sources*' 2>/dev/null | sort -V | tail -1)"
  [ -n "$j" ] && cp="$cp:$j"
done
exec java -cp "${cp#:}" com.android.tools.build.bundletool.BundleToolMain "$@"
