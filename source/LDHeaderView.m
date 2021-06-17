#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "sources/Common.h"
#import "sources/MTMaterialView.h"
#import "LDHeaderView.h"

	NSString *const LDHeaderOptionIconFileName = @"LDHeaderOptionIconFileName";
	NSString *const LDHeaderOptionTitleFontSize = @"LDHeaderOptionTitleFontSize";
	NSString *const LDHeaderOptionTitleFontColor = @"LDHeaderOptionTitleFontColor";
	NSString *const LDHeaderOptionSubtitleFontSize = @"LDHeaderOptionSubtitleFontSize";
	NSString *const LDHeaderOptionSubtitleFontColor = @"LDHeaderOptionSubtitleFontColor";
	NSString *const LDHeaderOptionAddInterpolatingMotion = @"LDHeaderOptionAddInterpolatingMotion";
	NSString *const LDHeaderOptionAddMaterialBackground = @"LDHeaderOptionAddMaterialBackground";

	extern CFArrayRef CPBitmapCreateImagesFromData(CFDataRef cpbitmap, void*, int, void*);

@implementation LDHeaderView {
	NSBundle *_bundle;
	UIStackView *_stackView;
	UIImageView *_iconView;
	UILabel *_titleLabel;
	UILabel *_subtitleLabel;
}

	-(instancetype)initWithTitle:(NSString *)title subtitles:(NSArray<NSString *> *)subtitles bundle:(NSBundle *)bundle options:(NSDictionary<NSString *, id> *)options {
		self = [super init];

		if(self) {
				//Create stack view
			_stackView = [[UIStackView alloc] init];
			_stackView.axis = UILayoutConstraintAxisVertical;
			_stackView.distribution = UIStackViewDistributionEqualSpacing;
			_stackView.alignment = UIStackViewAlignmentCenter;
			_stackView.translatesAutoresizingMaskIntoConstraints = NO;
			_stackView.spacing = 0;
			[self addSubview:_stackView];

				//Icon view (225x255)
			NSString *iconFileName = options[LDHeaderOptionIconFileName];
			if(iconFileName && bundle) {
				_iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconFileName inBundle:bundle compatibleWithTraitCollection:nil]];
				_iconView.alpha = 0;
				[_stackView addArrangedSubview:_iconView];

				[NSLayoutConstraint activateConstraints:@[
					[_iconView.heightAnchor constraintEqualToConstant:65],
					[_iconView.widthAnchor constraintEqualToConstant:65],
				]];
			}

				//Main label
			CGFloat titleFontSize = [options[LDHeaderOptionTitleFontSize] floatValue] ?: 35;
			UIColor *titleFontColor = options[LDHeaderOptionTitleFontColor] ?: [UIColor labelColor];
			_titleLabel = [[UILabel alloc] init];
			_titleLabel.numberOfLines = 1;
			_titleLabel.font = [UIFont systemFontOfSize:titleFontSize weight:UIFontWeightSemibold];
			_titleLabel.text = title;
			_titleLabel.textColor = titleFontColor;
			_titleLabel.backgroundColor = [UIColor clearColor];
			_titleLabel.textAlignment = NSTextAlignmentCenter;
			_titleLabel.alpha = 0;
			[_stackView addArrangedSubview:_titleLabel];

				//Subtitle label
			CGFloat subtitleFontSize = [options[LDHeaderOptionSubtitleFontSize] floatValue] ?: 13;
			UIColor *subtitleFontColor = options[LDHeaderOptionSubtitleFontColor] ?: [UIColor secondaryLabelColor];
			_subtitleLabel = [[UILabel alloc] init];
			_subtitleLabel.numberOfLines = 1;
			_subtitleLabel.font = [UIFont systemFontOfSize:subtitleFontSize weight:UIFontWeightLight];
			_subtitleLabel.text = subtitles[arc4random_uniform(subtitles.count)];
			_subtitleLabel.textColor = subtitleFontColor;
			_subtitleLabel.backgroundColor = [UIColor clearColor];
			_subtitleLabel.textAlignment = NSTextAlignmentCenter;
			_subtitleLabel.alpha = 0;
			[_stackView addArrangedSubview:_subtitleLabel];

				//Add constraints
			[NSLayoutConstraint activateConstraints:@[
				[_stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
				[_stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
			]];

			BOOL addInterpolatingMotion = [options[LDHeaderOptionAddInterpolatingMotion] boolValue] ?: NO;
			if(addInterpolatingMotion) {
				[self addInterpolatingMotionToView];
			}

			BOOL addMaterialBackground = [options[LDHeaderOptionAddMaterialBackground] boolValue] ?: NO;
			if(addMaterialBackground) {
				NSData *wallpaperData = [NSData dataWithContentsOfFile:@"/User/Library/SpringBoard/OriginalLockBackground.cpbitmap"];
				UIImage *wallpaper;
				if(wallpaperData) {
					CFArrayRef wallpaperArrayRef = CPBitmapCreateImagesFromData((__bridge CFDataRef)wallpaperData, NULL, 1, NULL);
					NSArray *wallpaperArray = (__bridge NSArray *)wallpaperArrayRef;
					wallpaper = [[UIImage alloc] initWithCGImage:(__bridge CGImageRef)(wallpaperArray[0])];
					CFRelease(wallpaperArrayRef);
				}

					//Add wallpaper
				UIImageView *wallpaperView = [[UIImageView alloc] initWithImage:wallpaper];
				wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
				wallpaperView.clipsToBounds = YES;
				wallpaperView.layer.cornerRadius = 10;
				wallpaperView.translatesAutoresizingMaskIntoConstraints = NO;
				[wallpaperView setContentCompressionResistancePriority:0 forAxis:UILayoutConstraintAxisHorizontal];
				[wallpaperView setContentCompressionResistancePriority:0 forAxis:UILayoutConstraintAxisVertical];
				[self insertSubview:wallpaperView atIndex:0];

					//Create blur
				MTMaterialView *blurView;
				if([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){13, 0, 0}]) {
					blurView = [objc_getClass("MTMaterialView") materialViewWithRecipe:1 configuration:1 initialWeighting:1];
		      blurView.recipeDynamic = YES;
		      [blurView setRecipeName:@"plattersDark"];
				} else {
					blurView = [objc_getClass("MTMaterialView") materialViewWithRecipe:MTMaterialRecipeNotifications options:MTMaterialOptionsBlur];
					blurView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
				}
				blurView.translatesAutoresizingMaskIntoConstraints = NO;
				[wallpaperView addSubview:blurView];

				[NSLayoutConstraint activateConstraints:@[
					[wallpaperView.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor constant:50],
					[wallpaperView.heightAnchor constraintEqualToAnchor:_stackView.heightAnchor constant:20],
					[wallpaperView.centerXAnchor constraintEqualToAnchor:_stackView.centerXAnchor],
					[wallpaperView.centerYAnchor constraintEqualToAnchor:_stackView.centerYAnchor],

					[blurView.widthAnchor constraintEqualToAnchor:wallpaperView.widthAnchor],
					[blurView.heightAnchor constraintEqualToAnchor:wallpaperView.heightAnchor],
					[blurView.centerXAnchor constraintEqualToAnchor:wallpaperView.centerXAnchor],
					[blurView.centerYAnchor constraintEqualToAnchor:wallpaperView.centerYAnchor],
				]];
			}
		}

		return self;
	}

	-(void)didMoveToSuperview {
		[super didMoveToSuperview];

		[UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
			if(_iconView) {
				_iconView.alpha = 1;
			}

			_titleLabel.alpha = 1;
		} completion:nil];

		[UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
			_subtitleLabel.alpha = 1;
		} completion:nil];
	}

	-(void)addInterpolatingMotionToView {
		UIInterpolatingMotionEffect *horizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
		horizontal.minimumRelativeValue = @-5;
		horizontal.maximumRelativeValue = @5;

		UIInterpolatingMotionEffect *vertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
		vertical.minimumRelativeValue = @-5;
		vertical.maximumRelativeValue = @5;

		UIMotionEffectGroup *effectsGroup = [[UIMotionEffectGroup alloc] init];
		effectsGroup.motionEffects = @[horizontal, vertical];

		[self addMotionEffect:effectsGroup];
	}
@end
