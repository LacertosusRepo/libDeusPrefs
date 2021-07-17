---
Title: LDLayoutConstants
---
Struct with constants for each anchor. Multiple helper functions to allow to create `LDLayoutConstants`.

#- Parameters
- width `float`
- Width anchor constant.

- height `float`
- Height anchor constant.

- x `float`
- Center X anchor constant.

- y `float`
- Center Y anchor constant.

- top `float`
- Top anchor constant.

- bottom `float`
- Bottom anchor constant.

- leading `float`
- Leading anchor constant.

- trailing `float`
- Trailing anchor constant.

- Return Value `LDLayoutConstants`
- Constants to be used with ParvusConstraint.

---
#- Functions
- LDLayoutConstantsMake()
- Function with parameters for each constant. Very long.

- LDSelectConstantsMake()
- Function using a dictionary to set only specific constants.
  - <span style="color:#DE2218">w</span>
  - Width Constant

  - <span style="color:#DE2218">h</span>
  - Height Constant

  - <span style="color:#DE2218">x</span>
  - Center X Constant

  - <span style="color:#DE2218">y</span>
  - Center Y Constant

  - <span style="color:#DE2218">tp</span>
  - Top Constant

  - <span style="color:#DE2218">b</span>
  - Bottom Constant

  - <span style="color:#DE2218">l</span>
  - Leading Constant

  - <span style="color:#DE2218">tl</span>
  - Trailing Constant

- LDSizeConstantsMake()
- Function with parameters only for width and height constants.

- LDEdgeConstantsMake()
- Function with parameters for top, bottom, leading, and trailing constants.
