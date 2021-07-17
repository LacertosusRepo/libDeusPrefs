  /*
   * Based off of Boo-dev's libstylepicker
   * https://github.com/boo-dev/libstylepicker
   */
#import <UIKit/UIKit.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>

#import "../sources/Common.h"
#import "../NSLayoutConstraint+ParvusConstraint.h"
#import "LDStyleOptionView.h"
#import "LDStyleOptionViewDelegate.h"
#import "LDStylePickerCell.h"

@implementation LDStylePickerCell {
  UIStackView *_stackView;
}

  -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier specifier:specifier];

    if(self) {
      [specifier setProperty:@215 forKey:@"height"];

      NSMutableArray *optionViewArray = [[NSMutableArray alloc] init];
      NSBundle *bundle = [specifier.target bundle];
      NSArray *options = [specifier propertyForKey:@"options"];
      NSString *localizationTable = [specifier propertyForKey:@"localizationTable"];

      for(NSDictionary *styleProperties in options) {
        LDStyleOptionView *optionView = [[LDStyleOptionView alloc] initWithAppearanceOption:[styleProperties objectForKey:@"appearanceOption"]];
        optionView.delegate = self;
        optionView.label.text = [bundle localizedStringForKey:[styleProperties objectForKey:@"label"] value:[styleProperties objectForKey:@"label"] table:localizationTable];
        optionView.previewImage = [UIImage imageNamed:[styleProperties objectForKey:@"image"] inBundle:bundle compatibleWithTraitCollection:nil];
        optionView.previewImageAlt = [UIImage imageNamed:[styleProperties objectForKey:@"imageAlt"] inBundle:bundle compatibleWithTraitCollection:nil];
        optionView.highlighted = [optionView.appearanceOption isEqual:[specifier performGetter]];
        optionView.identifier = [styleProperties objectForKey:@"id"];
        optionView.translatesAutoresizingMaskIntoConstraints = NO;
        [optionViewArray addObject:optionView];
      }

      _stackView = [[UIStackView alloc] initWithArrangedSubviews:optionViewArray];
      _stackView.alignment = UIStackViewAlignmentCenter;
      _stackView.axis = UILayoutConstraintAxisHorizontal;
      _stackView.distribution = UIStackViewDistributionFillEqually;
      _stackView.spacing = 0;
      _stackView.translatesAutoresizingMaskIntoConstraints = NO;
      [self.contentView addSubview:_stackView];

      [NSLayoutConstraint ld_constrainView:_stackView toView:self.contentView anchors:@"top, bottom, leading, trailing"];
    }

    return self;
  }

  -(void)selectedOption:(LDStyleOptionView *)option {
    [self.specifier performSetterWithValue:option.appearanceOption];

    for(LDStyleOptionView *view in _stackView.arrangedSubviews) {
      [view updateViewForOption:option.appearanceOption];
    }
  }

  -(LDStyleOptionView *)optionViewForID:(NSString *)identifier {
    for(LDStyleOptionView *view in _stackView.arrangedSubviews) {
      if([view.identifier isEqualToString:identifier]) {
        return view;
      }
    }

    return nil;
  }
@end
