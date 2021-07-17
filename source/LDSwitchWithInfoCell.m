#import <Preferences/PSListController.h>
#import <Preferences/PSSwitchTableCell.h>

#import "sources/Common.h"
#import "NSLayoutConstraint+ParvusConstraint.h"
#import "LDSwitchWithInfoCell.h"

  CGFloat safeWidth;
  CGSize expectedLabelSize;

@implementation LDSwitchWithInfoCell {
  UIButton *_infoButton;
  UILabel *_label;
  NSBundle *_bundle;
  NSString *_localizationTable;
  BOOL _useAlternativeStyle;
}

  -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
    _useAlternativeStyle = ([[specifier propertyForKey:@"infoAlternativeStyle"] boolValue]) ?: NO;
    if(_useAlternativeStyle) {
      style = UITableViewCellStyleSubtitle;
    }

    self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

    if(self) {
      _bundle = [specifier.target bundle];
      _localizationTable = [specifier propertyForKey:@"localizationTable"];

      NSString *label = [specifier propertyForKey:PSTitleKey];
      NSString *localizedTitle = [_bundle localizedStringForKey:label value:label table:_localizationTable];

      if(_useAlternativeStyle) {
        NSString *detail = ([specifier propertyForKey:@"cellSubtitleText"]) ?: @"Tap for more information";

        self.titleLabel.text = localizedTitle;
        self.detailTextLabel.text = [_bundle localizedStringForKey:detail value:detail table:_localizationTable];

      } else {
        self.titleLabel.hidden = YES;

        _label = [[UILabel alloc] init];
        _label.font = self.titleLabel.font;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 2;
        _label.text = localizedTitle;
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_label];

        _infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        _infoButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_infoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [_infoButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_infoButton];

        [NSLayoutConstraint ld_constrainView:_infoButton toView:self.contentView anchors:@"y, trailing" constants:LDSelectConstantsMake(@{@"tl" : @-4})];

        [NSLayoutConstraint activateConstraints:@[
          [_label.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
          [_label.trailingAnchor constraintEqualToAnchor:_infoButton.leadingAnchor constant:-4],
          [_label.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],
        ]];
      }
    }

    return self;
  }

  -(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(selected && _useAlternativeStyle) {
      [self infoButtonTapped];
    }
  }

  -(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    if(_useAlternativeStyle) {
      [UIView animateWithDuration:0.1 animations:^{
        if(highlighted) {
          self.titleLabel.alpha = 0.5;
          self.detailTextLabel.alpha = 0.5;
        } else {
          self.titleLabel.alpha = 1;
          self.detailTextLabel.alpha = 1;
        }
      } completion:nil];
    }
  }

  -(IBAction)infoButtonTapped {
    NSString *title = ([self.specifier propertyForKey:@"infoTitle"]) ?: [self.specifier propertyForKey:PSTitleKey];
    NSString *message = ([self.specifier propertyForKey:@"infoMessage"]) ?: @"No information provided for this cell.";

    NSString *localizedTitle = [_bundle localizedStringForKey:title value:title table:_localizationTable];
    NSString *localizedMessage = [_bundle localizedStringForKey:message value:message table:_localizationTable];

    UIAlertController *infoAlert = [UIAlertController alertControllerWithTitle:localizedTitle message:[localizedMessage stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];

    [infoAlert addAction:cancelAction];

    UIViewController *rootViewController = self._viewControllerForAncestor ?: [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:infoAlert animated:YES completion:nil];
  }

  -(void)tintColorDidChange {
    [super tintColorDidChange];

    _infoButton.tintColor = self.tintColor;
  }

  -(void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
    [super refreshCellContentsWithSpecifier:specifier];

    if([self respondsToSelector:@selector(tintColor)]) {
      _infoButton.tintColor = self.tintColor;
    }
  }
@end
