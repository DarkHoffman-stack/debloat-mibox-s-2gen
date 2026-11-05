#!/bin/bash
# Restore the disabled packages on a Mi Box S 2nd gen.
# usage: DEVICE=<box-ip>:5555 bash restore.sh
set -euo pipefail
LIST="$(dirname "$0")/debloat.txt"
DEV="${DEVICE:?set DEVICE=<box-ip>:5555}"
ADB="${ADB:-adb}"
tr -d '\r' < "$LIST" | grep -vE '^\s*(#|$)' | while read -r pkg; do
  state=$($ADB -s "$DEV" shell "pm list packages -d" | grep -F "package:$pkg" || true)
  if [ -n "$state" ]; then
    echo "$pkg -> $($ADB -s "$DEV" shell "pm enable --user 0 $pkg" 2>&1 | tr -d '\r')"
  else
    echo "$pkg already enabled"
  fi
done
