---
Title: General
---
libDeusPrefs is a preferences library I've created to reduce the amount of copy-pasting I have to do each time I need to make a preference bundle. Supports iOS 13 to 14 currently.

Documentation website generated using [Docuowl](https://github.com/docuowl/docuowl), since I hate HTML.

#- Installing libDeusPrefs to Theos
- Pre-Compiled `Method 1`
- Download libDeusPrefs from Packix, then move the `libDeusPrefs.dylib` file to `$THEOS/lib/`. Also download the `libDeusPrefs.h` header from this repo and place in `$THEOS/include/`.

- Compiling From Source `Method 2`
- Download the [source code](https://github.com/LacertosusRepo/libDeusPrefs), then compile with `make install-to-theos`.

*Easy! Right?*

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

#- License
Licensed under the [Apache License](https://github.com/LacertosusRepo/libDeusPrefs/blob/main/LICENSE).
