---
Title: General
---
libDeusPrefs is a preferences library I've created to reduce the amount of copy-pasting I have to do each time I need to make a preference bundle. Supports iOS 13 to 14 currently.

Documentation website generated using [Docuowl](https://github.com/docuowl/docuowl), since I hate HTML.

#- Installing libDeusPrefs to Theos
- Pre-Compiled `Method 1`
- Avoid having to compile `libDeusPrefs`
  - `Step 1`
  - Download `libDeusPrefs` bundle from Packix

  - `Step 2`
  - Copy `/usr/lib/libDeusPrefs.dylib` to `$THEOS/lib/`

  - `Step 3`
  - Download `libDeusPrefs.h` from [GitHub](https://github.com/LacertosusRepo/libDeusPrefs/releases/latest) and place in `$THEOS/include/`


- Compiling From Source `Method 2`
- Compile `libDeusPrefs` library manually
  - `Step 1`
  - Download `libDeusPrefs`'s source code from [GitHub](https://github.com/LacertosusRepo/libDeusPrefs)

  - `Step 2`
  - Compile with `make do install-to-theos`

---

#- Adding libDeusPrefs to a Project
- Step 1
- Add the `libDeusPrefs` library to your preference bundle makefile:
```makefile
prefs_LIBRARIES = DeusPrefs
```

- Step 2
- Add `com.lacertosusrepo.libDeusPrefs` to the `Depends:` field of your control file:
```control
Depends: com.lacertosusrepo.libdeusprefs (>= 1.0)
```

---

#- Previewing Features
- Pre-Compiled `Method 1`
- Avoid having to compile `libDeusPrefs`
  - `Step 1`
  - Download `libDeusPrefsExample` bundle from [GitHub](https://github.com/LacertosusRepo/libDeusPrefs/tree/main/source/ExamplePreferenceBundle)

  - `Step 2`
  - Copy `libDeusPrefsExample.bundle` to `/Library/PreferenceBundles/` on your device

  - `Step 3`
  - Copy `libDeusPrefsExample.plist` to `/Library/PreferenceLoader/Preferences` on your device

  - `Step 4`
  - Restart the settings app

- Compiling From Source `Method 2`
- Compile `libDeusPrefsExample` bundle manually
  - `Step 1`
  - Download `libDeusPrefs`'s source code from [GitHub](https://github.com/LacertosusRepo/libDeusPrefs/tree/main/source)

  - `Step 2`
  - Compile with `make do install-bundle`

#- License
Licensed under the [Apache License](https://github.com/LacertosusRepo/libDeusPrefs/blob/main/LICENSE).
