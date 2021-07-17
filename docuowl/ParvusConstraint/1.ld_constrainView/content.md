---
Title: ld_constrainView
---
Constrain specified anchors from one view to another with optional constants.

#- Parameters
- primaryView `UIView`
- View to be anchored.

- secondaryView `UIView`
- View to be anchored to.

- anchors `string`
- Anchors to add constraints to. Abbreviations are used and each should be separated by a string.
  - <span style="color:#DE2218">w</span>
  - Width Anchor

  - <span style="color:#DE2218">h</span>
  - Height Anchor

  - <span style="color:#DE2218">x</span>
  - Center X Anchor

  - <span style="color:#DE2218">y</span>
  - Center Y Anchor

  - <span style="color:#DE2218">top</span>
  - Top Anchor

  - <span style="color:#DE2218">bottom</span>
  - Bottom Anchor

  - <span style="color:#DE2218">leading</span>
  - Leading Anchor

  - <span style="color:#DE2218">trailing</span>
  - Trailing Anchor

- constants `LDLayoutConstants`
- Struct with constants for each anchor. Multiple helper functions to allow to create `LDLayoutConstants`.

- Return Value `array`
- Array of constraints added to the `primaryView`. Each constraint's identifier is set to the corresponding anchor used for the constraint.
