---
Title: ld_sizeView
---
Constrain view's width and height anchors to constants.

#- Parameters
- primaryView `UIView`
- View to be anchored.

- constants `LDLayoutConstants`
- Struct with constants for each anchor. Multiple helper functions to allow to create `LDLayoutConstants`.

- Return Value `array`
- Array of constraints added to the `primaryView`. Each constraint's identifier is set to the corresponding anchor used for the constraint.
