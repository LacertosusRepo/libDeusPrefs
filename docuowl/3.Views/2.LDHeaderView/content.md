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
  - Name of the large icon file (should be 225x225**px**) or alternatively an SFSymbol image name can be used instead. If no icon is desired ignore this key.

  - LDHeaderOptionTitleFontSize `float`
  - Font size of the title label. <span style="color:#DE2218">*Default is 35.*</span>

  - LDHeaderOptionTitleFontColor `UIColor`
  - Font color of the title label.

  - LDHeaderOptionSubtitleFontSize `float`
  - Font size of the subtitle label. <span style="color:#DE2218">*Default is 13.*</span>

  - LDHeaderOptionSubtitleFontColor `UIColor`
  - Font color of the subtitle label.

  - LDHeaderOptionAddInterpolatingMotion `bool`
  - Adds slight interpolating motion when the device is moved. <span style="color:#DE2218">*Default is NO.*</span>

  - LDHeaderOptionAddMaterialBackground `bool`
  - Adds a blurred background to the header. Use the `LDHeaderOptionBackgroundImageFileName` key to define an image to be blurred. <span style="color:#DE2218">*Default is NO.*</span>

  - LDHeaderOptionBackgroundImageFileName `string`
  - Define the name of the image file to be blurred behind the material view. <span style="color:#DE2218">*Alternatively, set to 'DeviceWallpaper' to use the wallpaper of the device.*</span>

  - LDHeaderOptionHeaderStyle `LDHeaderStyle`
  - Set the style of the header view. Must be converted to a `NSNumber`.  <span style="color:#DE2218">*Default is LDHeaderStyleVertical.*</span>
      - <span style="color:#DE2218">LDHeaderStyleVertical</span>
      - Vertical style with the icon center above the title and subtitle.

      - <span style="color:#DE2218">LDHeaderStyleHorizontalIconRight</span>
      - Horizontal style with the icon to the right of the title and subtitle.

      - <span style="color:#DE2218">LDHeaderStyleHorizontalIconLeft</span>
      - Horizontal style with the icon to the left of the title and subtitle.
