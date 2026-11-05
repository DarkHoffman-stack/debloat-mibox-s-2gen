# Xiaomi Mi Box S (2nd gen)

Device under test: `oneday` (`ro.product.model = MIBOX4`), Android 12 / Google TV, global firmware.

## ADB access (the "no Network debugging" mystery)

Developer options have no wireless/network debugging toggle, but none is needed:

1. Settings → Device Preferences → About → press OK on **Build** seven times.
2. Developer options → **USB debugging** → ON.
3. USB debugging *alone* makes the box listen on `tcp:5555` on the LAN.
4. `adb connect <box-ip>:5555` and accept the fingerprint prompt on the TV.

## debloat.txt

18 packages, `pm disable-user --user 0`, one per shell call:

```
com.xiaomi.statistic                      # usage statistics upload
com.miui.tv.analytics                     # analytics SDK host
com.xiaomi.tvqs.overseas                  # crash/perf quality uploads
com.xiaomo.tv.milegal                     # legal screens
com.xm.webcontent                         # promo web container / screensaver ads
com.mitv.download.service                 # OTA push-downloads
com.mitv.tvhome.atv                       # PatchWall home (unused)
com.mitv.tvhome.michannel                 # Mi recommendation channels
com.mitv.tvhome.mitvplus                  # Xiaomi TV+ FAST channels
com.google.android.tvrecommendations      # the ad "recommended for you" rows
com.google.android.feedback
com.google.android.play.games
com.google.android.videos
com.google.android.youtube.tvmusic
android.autoinstalls.config.xioami.mibox3 # partner auto-installer
com.mitv.milinkservice                    # MiLink cast (Google Chromecast kept)
com.mitv.dream                            # Mi screensaver
com.google.android.backdrop               # Ambient/Backdrop
```

Kept by owner's choice: `com.google.android.katniss` (voice), `com.google.android.apps.mediashell`
(Chromecast built-in), `com.xiaomi.mitv.updateservice` (firmware OTA), `mitv.service`,
`com.mitv.videoplayer` (USB playback).

## Undo

```bash
DEVICE=<box-ip>:5555 tools/restore.sh debloat.txt
```

## Launcher

The stock Google TV home was replaced with the
[cleanyourtv launcher](https://github.com/Gathin23/cleanyourtv) built from source
(allows 4-7 columns; the launch script rolls back automatically if Home does not
land on it). A cleaned theme (Aurora) is applied via its `tools/theme.sh`.
