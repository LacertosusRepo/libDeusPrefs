#import <UIKit/UIKit.h>
#import "LDStyleCheckView.h"

@implementation LDStyleCheckView {
  UIImageView *_circleImageView;
  UIImageView *_checkmarkImageView;
}

  -(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if(self) {
      UIImage *unchecked = [[UIImage kitImageNamed:@"UIRemoveControlMultiNotCheckedImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      _circleImageView = [[UIImageView alloc] initWithImage:unchecked];
      _circleImageView.translatesAutoresizingMaskIntoConstraints = NO;
      [_circleImageView sizeToFit];
      [self addSubview:_circleImageView];

      UIImage *checked = [[UIImage kitImageNamed:@"UITintedCircularButtonCheckmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      _checkmarkImageView = [[UIImageView alloc] initWithImage:checked];
      _checkmarkImageView.translatesAutoresizingMaskIntoConstraints = NO;
      [_checkmarkImageView sizeToFit];
      [self addSubview:_checkmarkImageView];
    }

    return self;
  }

  -(void)setSelected:(BOOL)selected {
    [UIView animateWithDuration:0.1 animations:^{
      _checkmarkImageView.alpha = (selected) ? 1.0 : 0.0;
    }];
  }
@end
