---
Title: LDStylePickerCell
---
A style picker just like Apple's light/dark mode picker. Useful for visually conveying options.

#- Keys
- options `array`
- Array of options to list. Contains dictionaries with keys listed below.
  - label `string`
  - String to be displayed below the option's image.

  - appearanceOption `string`
  - Value that will be saved when the option is selected.

  - image `string`
  - Name of the image to be displayed for the option.

  - imageAlt `string`
  - Name of an alternative image to be displayed when the device is in dark mode. This is an optional key, if ignored the normal image will be used in both light & dark mode.

- infoMessage `string`
- Message for the info alert.

- localizationTable `string`
- Name of localization table to lookup localization key.
