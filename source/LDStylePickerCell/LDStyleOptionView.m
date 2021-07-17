#import <UIKit/UIKit.h>

#import "../NSLayoutConstraint+ParvusConstraint.h"
#import "LDStyleOptionViewDelegate.h"
#import "LDStyleCheckView.h"
#import "LDStyleOptionView.h"

@implementation LDStyleOptionView {
  UIStackView *_stackView;
  UIImageView *_previewImageView;
  LDStyleCheckView *_checkView;
  UILongPressGestureRecognizer *_pressGesture;
}

  -(instancetype)initWithAppearanceOption:(id)option {
    self = [super init];

    if(self) {
      _appearanceOption = option;

      _previewImageView = [[UIImageView alloc] init];
      _previewImageView.clipsToBounds = YES;
      _previewImageView.contentMode = UIViewContentModeScaleAspectFit;
      _previewImageView.layer.cornerRadius = 8;
      _previewImageView.layer.borderColor = self.tintColor.CGColor;
      _previewImageView.translatesAutoresizingMaskIntoConstraints = NO;

      _label = [[UILabel alloc] init];
      _label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
      _label.numberOfLines = 2;
      _label.textAlignment = NSTextAlignmentCenter;
      _label.translatesAutoresizingMaskIntoConstraints = NO;

      _checkView = [[LDStyleCheckView alloc] init];
      _checkView.translatesAutoresizingMaskIntoConstraints = NO;

      _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_previewImageView, _label, _checkView]];
      _stackView.alignment = UIStackViewAlignmentCenter;
      _stackView.axis = UILayoutConstraintAxisVertical;
      _stackView.distribution = UIStackViewDistributionEqualSpacing;
      _stackView.spacing = 5;
      _stackView.translatesAutoresizingMaskIntoConstraints = NO;
      [self addSubview:_stackView];

      [NSLayoutConstraint ld_constrainView:_stackView toView:self anchors:@"top, bottom, leading, trailing"];
      [NSLayoutConstraint ld_sizeView:_checkView constants:LDSizeConstantsMake(22, 22)];

      _pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePress:)];
      _pressGesture.delegate = self;
      _pressGesture.minimumPressDuration = 0.01;
      _pressGesture.allowableMovement = 0;
      [self addGestureRecognizer:_pressGesture];
    }

    return self;
  }

  -(void)setPreviewImage:(UIImage *)image {
    _previewImage = image;
    _previewImageView.image = _previewImage;
  }

  -(void)setPreviewImageAlt:(UIImage *)image {
    _previewImageAlt = image;

    if(self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && _previewImageAlt) {
      _previewImageView.image = _previewImageAlt;
    }
  }

  -(void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [_checkView setSelected:_highlighted];

    if(_highlighted) {
      CABasicAnimation *showBorder = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
      showBorder.duration = 0.2;
      showBorder.fromValue = @0;
      showBorder.toValue = @3;

      _previewImageView.layer.borderWidth = 3;
      [_previewImageView.layer addAnimation:showBorder forKey:@"Show Border"];

      [UIView transitionWithView:self.label duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
      } completion:nil];

      [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
      } completion:nil];
    }

    if(!_highlighted) {
      if(_previewImageView.layer.borderWidth == 3) {
        CABasicAnimation *hideBorder = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
        hideBorder.duration = 0.2;
        hideBorder.fromValue = @3;
        hideBorder.toValue = @0;

        _previewImageView.layer.borderWidth = 0;
        [_previewImageView.layer addAnimation:hideBorder forKey:@"Hide Border"];
      }

      [UIView transitionWithView:self.label duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
      } completion:nil];

      [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(0.95, 0.95);
      } completion:nil];
    }
  }

  -(void)updateViewForOption:(id)style {
    if([style isKindOfClass:[NSNumber class]]) {
      style = [style stringValue];
    }

    self.highlighted = [style isEqualToString:[_appearanceOption stringValue]];
  }

  -(void)handlePress:(UIGestureRecognizer *)gesture {
    switch (gesture.state) {
      case UIGestureRecognizerStateBegan:
      {
        [UIView animateWithDuration:0.2 animations:^{
          self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
      }
      break;

      case UIGestureRecognizerStateRecognized:
      {
        if(!self.highlighted) {
          [self.delegate selectedOption:self];
        }
      }
      break;

      case UIGestureRecognizerStateFailed:
      case UIGestureRecognizerStateCancelled:
      {
        [UIView animateWithDuration:0.2 animations:^{
          self.transform = CGAffineTransformMakeScale(0.95, 0.95);
        } completion:nil];
      }
      break;

      default:
      break;
    }
  }

  -(BOOL)gestureRecognizer:(UIGestureRecognizer *)gesture shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGesture {
    if([otherGesture isKindOfClass:[UIPanGestureRecognizer class]] && otherGesture.state == UIGestureRecognizerStateBegan) {
      _pressGesture.enabled = NO;
      _pressGesture.enabled = YES;
    }

    return YES;
  }

  -(void)setDisabled:(BOOL)disabled {
    _disabled = disabled;

    if(disabled) {
      _pressGesture.enabled = NO;

      [UIView animateWithDuration:0.2 animations:^{
        _previewImageView.alpha = 0.5;
        _previewImageView.layer.borderColor = [UIColor grayColor].CGColor;
        self.label.alpha = 0.5;
        _checkView.alpha = 0.5;
      }];

    } else {
      _pressGesture.enabled = YES;

      [UIView animateWithDuration:0.2 animations:^{
        _previewImageView.alpha = 1.0;
        _previewImageView.layer.borderColor = self.tintColor.CGColor;
        self.label.alpha = 1.0;
        _checkView.alpha = 1.0;
      }];
    }
  }

  -(void)tintColorDidChange {
    [super tintColorDidChange];

    _previewImageView.layer.borderColor = self.tintColor.CGColor;
  }

  -(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];

    if(self.previewImage && self.previewImageAlt) {
      switch (self.traitCollection.userInterfaceStyle) {
        case UIUserInterfaceStyleUnspecified:
        case UIUserInterfaceStyleLight:
        {
          [UIView transitionWithView:_previewImageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _previewImageView.image = self.previewImage;
          } completion:nil];
        }
        break;

        case UIUserInterfaceStyleDark:
        {
          [UIView transitionWithView:_previewImageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _previewImageView.image = self.previewImageAlt;
          } completion:nil];
        }
        break;
      }
    }
  }
@end
