#import <UIKit/UIKit.h>

#import "NSLayoutConstraint+ParvusConstraint.h"
#import "LDAnimatedTitleView.h"

@implementation LDAnimatedTitleView {
  UILabel *_titleLabel;
  NSLayoutConstraint *_yConstraint;
  CGFloat _minimumOffsetRequired;
}

  -(instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color minimumScrollOffsetRequired:(CGFloat)minimumOffset {
    self = [super init];

    if(self) {
      _minimumOffsetRequired = minimumOffset;

      _titleLabel = [[UILabel alloc] init];
      _titleLabel.text = title;
			_titleLabel.textAlignment = NSTextAlignmentCenter;
			_titleLabel.textColor = color;
			_titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightHeavy];
			_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
      [_titleLabel sizeToFit];

      [self addSubview:_titleLabel];

      [NSLayoutConstraint ld_constrainView:self toView:_titleLabel anchors:@"w, h"];
      [NSLayoutConstraint ld_constrainView:_titleLabel toView:self anchors:@"x"];

      [NSLayoutConstraint activateConstraints:@[
        _yConstraint = [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:100],
      ]];
    }

    return self;
  }

  -(void)adjustLabelPositionToScrollOffset:(CGFloat)offset {
    CGFloat adjustment = 100 - (offset - _minimumOffsetRequired);
    if(offset >= _minimumOffsetRequired) {
      if(adjustment <= 0) {
        _yConstraint.constant = 0;

      } else {
        _yConstraint.constant = adjustment;
      }

    } else {
      _yConstraint.constant = -100;
    }
  }
@end
