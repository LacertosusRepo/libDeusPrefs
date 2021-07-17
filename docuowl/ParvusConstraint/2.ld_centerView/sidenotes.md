#! Declaration
```objc
+(NSArray <NSLayoutConstraint *>*)ld_centerView:(UIView *)primaryView inView:(UIView *)secondaryView constants:(LDLayoutConstants)constants;
```

#! Example Usage
```objc
[NSLayoutConstraint ld_centerView:firstView inView:otherView constants:LDSizeConstantsMake(200, 40)];
```
