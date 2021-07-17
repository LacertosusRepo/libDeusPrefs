#import <UIKit/UIKit.h>

#import "../sources/Common.h"
#import "../NSLayoutConstraint+ParvusConstraint.h"
#import "LDStyleCheckView.h"

@implementation LDStyleCheckView {
  UIImageView *_circleImageView;
  UIImageView *_checkmarkImageView;
}

  -(instancetype)init {
    self = [super init];

    if(self) {
      UIImage *circleImage = (IS_IOS_OR_NEWER(iOS_13_0)) ? [UIImage systemImageNamed:@"circle"] : [[UIImage kitImageNamed:@"UIRemoveControlMultiNotCheckedImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      _circleImageView = [[UIImageView alloc] initWithImage:circleImage];
      _circleImageView.contentMode = UIViewContentModeScaleAspectFit;
      _circleImageView.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_circleImageView];

      UIImage *checkedImage = (IS_IOS_OR_NEWER(iOS_13_0)) ? [UIImage systemImageNamed:@"checkmark.circle.fill"] : [[UIImage kitImageNamed:@"UITintedCircularButtonCheckmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      _checkmarkImageView = [[UIImageView alloc] initWithImage:checkedImage];
      _checkmarkImageView.contentMode = UIViewContentModeScaleAspectFit;
      _checkmarkImageView.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_checkmarkImageView];

      [NSLayoutConstraint ld_centerView:_circleImageView inView:self constants:LDSizeConstantsMake(22, 22)];
      [NSLayoutConstraint ld_centerView:_checkmarkImageView inView:self constants:LDSizeConstantsMake(22, 22)];
    }

    return self;
  }

  -(void)setSelected:(BOOL)selected {
    [UIView animateWithDuration:0.2 animations:^{
      _checkmarkImageView.alpha = (selected) ? 1.0 : 0.0;
    }];
  }
@end
