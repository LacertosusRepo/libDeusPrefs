#! Declaration
```objc
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors constants:(LDLayoutConstants)constants;
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors;
```

#! Example Usage
```objc
[NSLayoutConstraint ld_constrainView:firstView toView:otherView anchors:@"w, h" constants:LDSizeConstantsMake(100, 50)];

[NSLayoutConstraint ld_constrainView:firstView toView:otherView anchors:@"x, leading, trailing"];
```
