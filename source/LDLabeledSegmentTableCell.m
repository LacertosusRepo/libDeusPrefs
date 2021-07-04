#import <Preferences/PSSpecifier.h>
#import "sources/Common.h"
#import "LDLabeledSegmentTableCell.h"

@implementation LDLabeledSegmentTableCell {
	UIStackView *_stackView;
	UILabel *_segmentLabel;
}

	-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
		self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

		if(self) {
			[specifier setProperty:@64 forKey:@"height"];

			NSBundle *bundle = [specifier.target bundle];
			NSString *label = [specifier propertyForKey:@"label"];
			NSString *localizationTable = [specifier propertyForKey:@"localizationTable"];

			_segmentLabel = [[UILabel alloc] init];
			_segmentLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
			_segmentLabel.text = [bundle localizedStringForKey:label value:label table:localizationTable];
			_segmentLabel.translatesAutoresizingMaskIntoConstraints = NO;

			_stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_segmentLabel, self.control]];
			_stackView.alignment = UIStackViewAlignmentCenter;
			_stackView.axis = UILayoutConstraintAxisVertical;
			_stackView.distribution = UIStackViewDistributionEqualCentering;
			_stackView.spacing = 5;
			_stackView.translatesAutoresizingMaskIntoConstraints = NO;
			[self.contentView addSubview:_stackView];

			[NSLayoutConstraint activateConstraints:@[
				[_stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4],
				[_stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
				[_stackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-15],
				[_stackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4],

				[self.control.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor],
			]];
		}

		return self;
	}

	-(void)tintColorDidChange {
		[super tintColorDidChange];

		_segmentLabel.textColor = self.tintColor;
	}

	-(void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
		[super refreshCellContentsWithSpecifier:specifier];

		if([self respondsToSelector:@selector(tintColor)]) {
			_segmentLabel.textColor = self.tintColor;
		}
	}
@end
