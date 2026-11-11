#!/usr/bin/env bash
# packaging/itch/build.sh: Antinode as a zip for itch.io.
#
# The game is one self-contained page, so the zip is that page as index.html
# (itch.io wants it at the root) plus the license. No network, no other files.
# Output: dist/antinode-web-<version>.zip. Needs the zip command.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$here/../.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$root/packaging/VERSION")"
command -v zip >/dev/null || { echo "STOP: the zip command is needed" >&2; exit 1; }

( cd "$root" && node app/build-drifter.mjs )

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
cp "$root/app/antinode.html" "$work/index.html"
cp "$root/LICENSE" "$work/LICENSE.txt"

mkdir -p "$root/dist"
out="$root/dist/antinode-web-$VERSION.zip"
rm -f "$out"
( cd "$work" && zip -qX "$out" index.html LICENSE.txt )
echo "$out  $(du -h "$out" | cut -f1)"
