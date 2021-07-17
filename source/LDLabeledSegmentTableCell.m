#import "sources/Common.h"
#import "NSLayoutConstraint+ParvusConstraint.h"
#import "LDLabeledSegmentTableCell.h"

@implementation LDLabeledSegmentTableCell {
	UIStackView *_stackView;
	UILabel *_segmentLabel;
}

	-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
		self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

		if(self) {
			[specifier setProperty:@64 forKey:PSTableCellHeightKey];

			NSBundle *bundle = [specifier.target bundle];
			NSString *label = [specifier propertyForKey:PSTitleKey];
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

			[NSLayoutConstraint ld_constrainView:_stackView toView:self.contentView anchors:@"top, bottom, leading, trailing" constants:LDEdgeConstantsMake(6, -6, 15, -15)];

			[NSLayoutConstraint activateConstraints:@[
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
