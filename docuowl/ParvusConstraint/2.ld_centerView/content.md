---
Title: ld_centerView
---
Constrain view to the center X and Y anchors of a specified view. Also add height and width anchors.

#- Parameters
- primaryView `UIView`
- View to be anchored.

- secondaryView `UIView`
- View to be anchored to.

- constants `LDLayoutConstants`
- Struct with constants for each anchor. Multiple helper functions to allow to create `LDLayoutConstants`.

- Return Value `array`
- Array of constraints added to the `primaryView`. Each constraint's identifier is set to the corresponding anchor used for the constraint.
