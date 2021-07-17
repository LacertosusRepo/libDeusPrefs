#! Declaration
```objc
+(NSArray <NSLayoutConstraint *>*)ld_sizeView:(UIView *)primaryView inView:(UIView *)secondaryView constants:(LDLayoutConstants)constants;
```

#! Example Usage
```objc
[NSLayoutConstraint ld_sizeView:firstView inView:otherView constants:LDSizeConstantsMake(96, 82)];
```
