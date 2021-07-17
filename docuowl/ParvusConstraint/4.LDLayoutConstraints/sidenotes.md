#! Declaration
```objc
struct LDLayoutConstants {
  CGFloat width;
  CGFloat height;
  CGFloat x;
  CGFloat y;
  CGFloat top;
  CGFloat bottom;
  CGFloat leading;
  CGFloat trailing;
};
```

#! Example Usage
```objc
LDLayoutConstants constants;
constants.width = 100;
constants.top = -5;
constants.y = 23;
```

#! Functions
```objc
LDLayoutConstants LDLayoutConstantsMake(CGFloat width, CGFloat height, CGFloat x, CGFloat y, CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);
LDLayoutConstants LDSelectConstantsMake(NSDictionary <NSString *, NSNumber *>*constantsDict);
LDLayoutConstants LDSizeConstantsMake(CGFloat width, CGFloat height);
LDLayoutConstants LDEdgeConstantsMake(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);
```
