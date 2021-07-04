#import <Preferences/PSSpecifier.h>
#import <libDeusPrefs.h>
#import "LDPRootListController.h"

@implementation LDPRootListController
	-(NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

		}

		return _specifiers;
	}

		//Prevent from writing to file;
	-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		return;
	}

		//Override defaults for cells
	-(id)readPreferenceValue:(PSSpecifier *)specifier {
		switch ([[specifier propertyForKey:@"id"] intValue]) {
			case 1:
				return @3;
			break;

			case 2:
				return @2;
			break;

			case 3:
				return @5;
			break;

			case 4:
				return @"optionOneValue";
			break;

			case 5:
				return @YES;
			break;

			case 6:
				return @4584;
			break;
		}

		return nil;
	}

#pragma mark - LDAnimatedTitleView

	-(void)viewDidAppear:(BOOL)animated {
		[super viewDidAppear:animated];

		if(!self.navigationItem.titleView) {
			LDAnimatedTitleView *animatedTitleView = [[LDAnimatedTitleView alloc] initWithTitle:@"Scrolling Title" textColor:[UIColor systemBlueColor] minimumScrollOffsetRequired:-50];
			self.navigationItem.titleView = animatedTitleView;
		}
	}

	-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
		if([self.navigationItem.titleView respondsToSelector:@selector(adjustLabelPositionToScrollOffset:)]) {
			[(LDAnimatedTitleView *)self.navigationItem.titleView adjustLabelPositionToScrollOffset:scrollView.contentOffset.y];
		}
	}

#pragma mark - LDHeaderView

	-(void)viewDidLoad {
		[super viewDidLoad];

		NSArray *subtitles = @[@"Array of subtitles", @"A random one will be selected"];
		NSArray *arrayOfOptions = @[
			@{LDHeaderOptionIconFileName : @"touchid", LDHeaderOptionTitleFontSize : @25, LDHeaderOptionTitleFontColor : [UIColor systemBlueColor]},
			@{LDHeaderOptionIconFileName : @"touchid", LDHeaderOptionHeaderStyle : @(LDHeaderStyleHorizontalIconRight), LDHeaderOptionTitleFontColor : [UIColor systemBlueColor]},
			@{LDHeaderOptionIconFileName : @"touchid", LDHeaderOptionAddInterpolatingMotion : @YES, LDHeaderOptionAddMaterialBackground : @YES, LDHeaderOptionBackgroundImageFileName : @"DeviceWallpaper"},
		];

		NSDictionary *selectedOption = arrayOfOptions[arc4random_uniform(arrayOfOptions.count)];
		LDHeaderView *header = [[LDHeaderView alloc] initWithTitle:@"Example Title" subtitles:subtitles bundle:[self bundle] options:selectedOption];

		CGFloat height = (selectedOption.count > 3) ? 150 : 125;
		header.frame = CGRectMake(0, 0, header.bounds.size.width, height);

		self.table.tableHeaderView = header;
	}
@end
