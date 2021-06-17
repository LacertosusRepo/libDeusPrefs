---
Title: LDHeaderView
---
A table header including an icon, a title label, and randomly selected subtitle label. Can be configured using a dictionary of keys for more options.

#- Parameters
- title `string`
- String used for the header's title label.

- subtitles `string`
- Array of strings used for the header's subtitle. A random string is selected from the array each time the preference pane is loaded.

- bundle `NSBundle`
- Bundle to retrieve the icon from if the icon's file name is specified in the `options` dictionary.

- options `NSDictionary`
- Dictionary of keys and corresponding values containing options used to configure the header view. A list of keys can be found below.
  - LDHeaderOptionIconFileName `string`
  - Name of the large icon file (should be 225**x**225**px**). If no icon is desired ignore this key.

  - LDHeaderOptionTitleFontSize `float`
  - Font size of the title label. *Default is 35.*

  - LDHeaderOptionTitleFontColor `UIColor`
  - Font color of the title label.

  - LDHeaderOptionSubtitleFontSize `float`
  - Font size of the subtitle label. *Default is 13.*

  - LDHeaderOptionSubtitleFontColor `UIColor`
  - Font color of the subtitle label.

  - LDHeaderOptionAddInterpolatingMotion `bool`
  - Adds slight interpolating motion when the device is moved. *Default is NO.*

  - LDHeaderOptionAddMaterialBackground `bool`
  - Adds a blurred background to the header using the user's lockscreen wallpaper. *Default is NO.*
