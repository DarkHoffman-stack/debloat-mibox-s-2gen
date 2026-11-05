# Mi Box S (2nd gen) debloat

A fully reversible ADB debloat list, tested on a real device, with
double-click runners for Windows and Linux/macOS.

Nothing here is truly uninstalled. Every entry is undone by
[restore](#running) with one command per package.

## Running

You need `adb` once:

| OS | Install adb |
|---|---|
| Windows | [platform-tools](https://developer.android.com/tools/releases/platform-tools) from Google, unzip, put `adb.exe` in PATH (or the folder you keep the files in) |
| Linux | `sudo apt install android-tools-adb` (Debian/Ubuntu), `sudo dnf install android-tools` (Fedora), `brew install android-platform-tools` (macOS via brew tap homebrew/cask if needed) |

Then:

| OS | Debloat (apply) | Restore (undo everything) |
|---|---|---|
| Windows | double-click `debloat.bat` | double-click `restore.bat` |
| Linux/macOS | `./debloat.sh` | `./restore.sh` |

Both ask for the target once (network `IP:PORT` or a USB serial), print
one line per package, and never loop retries.

## the "no Network debugging" toggle

Developer options on this box have no wireless/network debugging entry — and none
is needed. With plain **USB debugging** on (About → Build × 7 → Developer options),
the box listens on network ADB port 5555:

```text
adb connect <box-ip>:5555
```

accept the prompt on the TV screen, then run `debloat.bat` / `debloat.sh`.

## the launcher

The stock Google TV home was replaced with the
[cleanyourtv launcher](https://github.com/Gathin23/cleanyourtv) (built from source,
4-7 columns, rollback guaranteed if Home does not land on it). The Aurora theme
applies over it with that repo's `tools/theme.sh`.

## Safety notes

- disable and reversible user-0 removal only; snapshot nothing is un-installed for real
- lists are per-device: using another device's list can break parts you need
- read the list first; every line says what the package does
- if an entry refuses with a security exception, that device's firmware blocks
  the route — don't loop, read the stock-launcher home and ADB come back per its README

> tested on `oneday` / `MIBOX4`, Android 12 global firmware.

> See also: [debloat-xiaomi-14t](https://github.com/DarkHoffman-stack/debloat-xiaomi-14t) — same method for a HyperOS 3 phone.
