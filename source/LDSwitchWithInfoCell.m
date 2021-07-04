#import <Preferences/PSListController.h>
#import <Preferences/PSSwitchTableCell.h>

#import "sources/Common.h"
#import "LDSwitchWithInfoCell.h"

  CGFloat safeWidth;
  CGSize expectedLabelSize;

@implementation LDSwitchWithInfoCell {
  UIButton *_infoButton;
  UILabel *_label;
  NSBundle *_bundle;
  NSString *_localizationTable;
}

  -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

    if(self) {
      _bundle = [specifier.target bundle];
      _localizationTable = [specifier propertyForKey:@"localizationTable"];

      self.titleLabel.hidden = YES;

      NSString *localizedLabel = [_bundle localizedStringForKey:[specifier propertyForKey:@"label"] value:[specifier propertyForKey:@"label"] table:_localizationTable];
      _label = [[UILabel alloc] init];
      _label.font = self.titleLabel.font;
      _label.lineBreakMode = NSLineBreakByWordWrapping;
      _label.numberOfLines = 2;
      _label.text = localizedLabel;
      _label.translatesAutoresizingMaskIntoConstraints = NO;
      [self.contentView addSubview:_label];

      _infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
      _infoButton.translatesAutoresizingMaskIntoConstraints = NO;
      [_infoButton addTarget:self action:@selector(infoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
      [_infoButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
      [self.contentView addSubview:_infoButton];

      [NSLayoutConstraint activateConstraints:@[
        [_label.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [_label.trailingAnchor constraintEqualToAnchor:_infoButton.leadingAnchor constant:-4],
        [_label.leadingAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leadingAnchor],

        [_infoButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [_infoButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4],
      ]];
    }

    return self;
  }

  -(IBAction)infoButtonTapped {
    NSString *title = ([self.specifier propertyForKey:@"infoTitle"]) ?: [self.specifier propertyForKey:@"label"];
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
