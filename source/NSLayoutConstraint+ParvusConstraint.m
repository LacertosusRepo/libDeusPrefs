#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+ParvusConstraint.h"

@implementation NSLayoutConstraint (ParvusConstraint)
  +(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors constants:(LDLayoutConstants)constants {
    NSArray *anchorStrings = [anchors componentsSeparatedByString:@", "];
    NSMutableArray *constraints = [NSMutableArray new];

    if([anchorStrings containsObject:@"w"]) {
      NSLayoutConstraint *w = [primaryView.widthAnchor constraintEqualToAnchor:secondaryView.widthAnchor constant:constants.width];
      w.identifier = @"widthAnchor";
      [constraints addObject:w];
    }

    if([anchorStrings containsObject:@"h"]) {
      NSLayoutConstraint *h = [primaryView.heightAnchor constraintEqualToAnchor:secondaryView.heightAnchor constant:constants.height];
      h.identifier = @"heightAnchor";
      [constraints addObject:h];
    }

    if([anchorStrings containsObject:@"x"]) {
      NSLayoutConstraint *x = [primaryView.centerXAnchor constraintEqualToAnchor:secondaryView.centerXAnchor constant:constants.x];
      x.identifier = @"centerXAnchor";
      [constraints addObject:x];
    }

    if([anchorStrings containsObject:@"y"]) {
      NSLayoutConstraint *y = [primaryView.centerYAnchor constraintEqualToAnchor:secondaryView.centerYAnchor constant:constants.y];
      y.identifier = @"centerYAnchor";
      [constraints addObject:y];
    }

    if([anchorStrings containsObject:@"top"]) {
      NSLayoutConstraint *top = [primaryView.topAnchor constraintEqualToAnchor:secondaryView.topAnchor constant:constants.top];
      top.identifier = @"topAnchor";
      [constraints addObject:top];
    }

    if([anchorStrings containsObject:@"bottom"]) {
      NSLayoutConstraint *bottom = [primaryView.bottomAnchor constraintEqualToAnchor:secondaryView.bottomAnchor constant:constants.bottom];
      bottom.identifier = @"bottomAnchor";
      [constraints addObject:bottom];
    }

    if([anchorStrings containsObject:@"leading"]) {
      NSLayoutConstraint *leading = [primaryView.leadingAnchor constraintEqualToAnchor:secondaryView.leadingAnchor constant:constants.leading];
      leading.identifier = @"leadingAnchor";
      [constraints addObject:leading];
    }

    if([anchorStrings containsObject:@"trailing"]) {
      NSLayoutConstraint *trailing = [primaryView.trailingAnchor constraintEqualToAnchor:secondaryView.trailingAnchor constant:constants.trailing];
      trailing.identifier = @"trailingAnchor";
      [constraints addObject:trailing];
    }

    [NSLayoutConstraint activateConstraints:constraints];

    return constraints;
  }

  +(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors {
    return [NSLayoutConstraint ld_constrainView:primaryView toView:secondaryView anchors:anchors constants:LDSelectConstantsMake(@{})];
  }

  +(NSArray <NSLayoutConstraint *>*)ld_centerView:(UIView *)primaryView inView:(UIView *)secondaryView constants:(LDLayoutConstants)constants {
    NSLayoutConstraint *y = [primaryView.centerXAnchor constraintEqualToAnchor:secondaryView.centerXAnchor constant:constants.x];
    y.identifier = @"centerXAnchor";

    NSLayoutConstraint *x = [primaryView.centerYAnchor constraintEqualToAnchor:secondaryView.centerYAnchor constant:constants.x];
    y.identifier = @"centerYAnchor";

    NSLayoutConstraint *w = [primaryView.widthAnchor constraintEqualToConstant:constants.width];
    w.identifier = @"widthAnchor";

    NSLayoutConstraint *h = [primaryView.heightAnchor constraintEqualToConstant:constants.height];
    h.identifier = @"heightAnchor";

    NSArray *constraints = @[y, x, w, h];
    [NSLayoutConstraint activateConstraints:constraints];

    return constraints;
  }

  +(NSArray <NSLayoutConstraint *>*)ld_sizeView:(UIView *)primaryView constants:(LDLayoutConstants)constants {
    NSLayoutConstraint *w = [primaryView.widthAnchor constraintEqualToConstant:constants.width];
    w.identifier = @"widthAnchor";

    NSLayoutConstraint *h = [primaryView.heightAnchor constraintEqualToConstant:constants.height];
    h.identifier = @"heightAnchor";

    NSArray *constraints = @[w, h];
    [NSLayoutConstraint activateConstraints:constraints];

    return constraints;
  }
@end

#pragma mark - LDLayoutConstants functions

LDLayoutConstants LDLayoutConstantsMake(CGFloat width, CGFloat height, CGFloat x, CGFloat y, CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing) {
  LDLayoutConstants constants;
  constants.width = width;
  constants.height = height;
  constants.x = x;
  constants.y = y;
  constants.top = top;
  constants.bottom = bottom;
  constants.leading = leading;
  constants.trailing = trailing;

  return constants;
}

LDLayoutConstants LDSelectConstantsMake(NSDictionary <NSString *, NSNumber *>*constantsDict) {
  LDLayoutConstants constants;
  constants.width = ([constantsDict[@"w"] floatValue]) ?: 0;
  constants.height = ([constantsDict[@"h"] floatValue]) ?: 0;
  constants.x = ([constantsDict[@"x"] floatValue]) ?: 0;
  constants.y = ([constantsDict[@"y"] floatValue]) ?: 0;
  constants.top = ([constantsDict[@"tp"] floatValue]) ?: 0;
  constants.bottom = ([constantsDict[@"b"] floatValue]) ?: 0;
  constants.leading = ([constantsDict[@"l"] floatValue]) ?: 0;
  constants.trailing = ([constantsDict[@"tl"] floatValue]) ?: 0;

  return constants;
}

LDLayoutConstants LDSizeConstantsMake(CGFloat width, CGFloat height) {
  return LDLayoutConstantsMake(width, height, 0, 0, 0, 0, 0, 0);
}

LDLayoutConstants LDEdgeConstantsMake(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing) {
  return LDLayoutConstantsMake(0, 0, 0, 0, top, bottom, leading, trailing);
}
