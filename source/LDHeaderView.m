#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <version.h>

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
	NSString *const LDHeaderOptionBackgroundImageFileName = @"LDHeaderOptionBackgroundImageFileName";
	NSString *const LDHeaderOptionHeaderStyle = @"LDHeaderOptionHeaderStyle";

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
			_bundle = bundle;

				//Create stack view
			_stackView = [[UIStackView alloc] init];
			_stackView.distribution = UIStackViewDistributionEqualSpacing;
			_stackView.spacing = 0;
			_stackView.translatesAutoresizingMaskIntoConstraints = NO;
			[self addSubview:_stackView];

				//Icon view (225x255)
			NSString *iconFileName = options[LDHeaderOptionIconFileName];
			if(iconFileName.length > 0 && _bundle) {
				_iconView = [[UIImageView alloc] initWithImage:[self getImageNamed:iconFileName]];
				_iconView.alpha = 0;
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
			_titleLabel.alpha = 0;

				//Subtitle label
			CGFloat subtitleFontSize = [options[LDHeaderOptionSubtitleFontSize] floatValue] ?: 13;
			UIColor *subtitleFontColor = options[LDHeaderOptionSubtitleFontColor] ?: [UIColor secondaryLabelColor];
			_subtitleLabel = [[UILabel alloc] init];
			_subtitleLabel.numberOfLines = 1;
			_subtitleLabel.font = [UIFont systemFontOfSize:subtitleFontSize weight:UIFontWeightLight];
			_subtitleLabel.text = subtitles[arc4random_uniform(subtitles.count)];
			_subtitleLabel.textColor = subtitleFontColor;
			_subtitleLabel.backgroundColor = [UIColor clearColor];
			_subtitleLabel.alpha = 0;

				//Add constraints
			[NSLayoutConstraint activateConstraints:@[
				[_stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-75],
				[_stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
				[_stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
			]];

				//Configure views for layout
			[self configureViewsForStyle:[options[LDHeaderOptionHeaderStyle] intValue]];

				//Add interpolation if wanted
			BOOL addInterpolatingMotion = [options[LDHeaderOptionAddInterpolatingMotion] boolValue] ?: NO;
			if(addInterpolatingMotion) {
				[self addInterpolatingMotionToView];
			}

				//Add blurred material view with image if applicable
			BOOL addMaterialBackground = [options[LDHeaderOptionAddMaterialBackground] boolValue] ?: NO;
			if(addMaterialBackground) {
				MTMaterialView *materialView;
				if(IS_IOS_OR_NEWER(iOS_13_0)) {
					materialView = [objc_getClass("MTMaterialView") materialViewWithRecipe:1 configuration:1 initialWeighting:1];
		      materialView.recipeDynamic = YES;
		      [materialView setRecipeName:@"plattersDark"];
				} else {
					materialView = [objc_getClass("MTMaterialView") materialViewWithRecipe:MTMaterialRecipeNotifications options:MTMaterialOptionsBlur];
					materialView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
				}
				materialView.clipsToBounds = YES;
				materialView.layer.cornerRadius = 10;
				materialView.translatesAutoresizingMaskIntoConstraints = NO;
				[self insertSubview:materialView atIndex:0];

				UIImage *materialBackgroundImage;
				NSString *materialBackgroundImageFileName = options[LDHeaderOptionBackgroundImageFileName] ?: nil;
				if([materialBackgroundImageFileName isEqualToString:@"DeviceWallpaper"]) {
					NSData *wallpaperData = [NSData dataWithContentsOfFile:@"/User/Library/SpringBoard/OriginalLockBackground.cpbitmap"];
					if(wallpaperData) {
						CFArrayRef wallpaperArrayRef = CPBitmapCreateImagesFromData((__bridge CFDataRef)wallpaperData, NULL, 1, NULL);
						NSArray *wallpaperArray = (__bridge NSArray *)wallpaperArrayRef;
						materialBackgroundImage = [[UIImage alloc] initWithCGImage:(__bridge CGImageRef)(wallpaperArray[0])];
						CFRelease(wallpaperArrayRef);
					}

				} else if(materialBackgroundImageFileName.length > 0) {
					materialBackgroundImage = [self getImageNamed:materialBackgroundImageFileName];
				}

				UIImageView *materialBackgroundImageView = [[UIImageView alloc] initWithImage:materialBackgroundImage];
				materialBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
				materialBackgroundImageView.clipsToBounds = YES;
				materialBackgroundImageView.layer.cornerRadius = 10;
				materialBackgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
				[materialBackgroundImageView setContentCompressionResistancePriority:0 forAxis:UILayoutConstraintAxisHorizontal];
				[materialBackgroundImageView setContentCompressionResistancePriority:0 forAxis:UILayoutConstraintAxisVertical];
				[self insertSubview:materialBackgroundImageView atIndex:0];

				[NSLayoutConstraint activateConstraints:@[
					[materialBackgroundImageView.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor constant:50],
					[materialBackgroundImageView.heightAnchor constraintEqualToAnchor:_stackView.heightAnchor constant:20],
					[materialBackgroundImageView.centerXAnchor constraintEqualToAnchor:_stackView.centerXAnchor],
					[materialBackgroundImageView.centerYAnchor constraintEqualToAnchor:_stackView.centerYAnchor],

					[materialView.widthAnchor constraintEqualToAnchor:_stackView.widthAnchor constant:50],
					[materialView.heightAnchor constraintEqualToAnchor:_stackView.heightAnchor constant:20],
					[materialView.centerXAnchor constraintEqualToAnchor:_stackView.centerXAnchor],
					[materialView.centerYAnchor constraintEqualToAnchor:_stackView.centerYAnchor],
				]];
			}
		}

		return self;
	}

	-(void)configureViewsForStyle:(LDHeaderStyle)style {
		switch (style) {
			default:
			case LDHeaderStyleVertical:
			{
				_titleLabel.textAlignment = NSTextAlignmentCenter;
				_subtitleLabel.textAlignment = NSTextAlignmentCenter;

				_stackView.axis = UILayoutConstraintAxisVertical;
				_stackView.alignment = UIStackViewAlignmentCenter;

				if(_iconView) {
					[_stackView addArrangedSubview:_iconView];

					[NSLayoutConstraint activateConstraints:@[
						[_iconView.heightAnchor constraintEqualToConstant:65],
						[_iconView.widthAnchor constraintEqualToConstant:65],
					]];
				}

				[_stackView addArrangedSubview:_titleLabel];

				if(_subtitleLabel.text.length > 0) {
					[_stackView addArrangedSubview:_subtitleLabel];
				}
			}
			break;

			case LDHeaderStyleHorizontalIconRight:
			{
				_titleLabel.textAlignment = NSTextAlignmentLeft;
				_subtitleLabel.textAlignment = NSTextAlignmentLeft;

				UIStackView *textStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_titleLabel]];
				textStackView.axis = UILayoutConstraintAxisVertical;
				textStackView.distribution = UIStackViewDistributionEqualSpacing;
				textStackView.alignment = UIStackViewAlignmentLeading;
				textStackView.spacing = 0;

				if(_subtitleLabel.text.length > 0) {
					[textStackView addArrangedSubview:_subtitleLabel];
				}

				_stackView.axis = UILayoutConstraintAxisHorizontal;
				_stackView.alignment = UIStackViewAlignmentFill;
				_stackView.spacing = 15;
				[_stackView addArrangedSubview:textStackView];

				if(_iconView) {
					[_stackView addArrangedSubview:_iconView];

					[NSLayoutConstraint activateConstraints:@[
						[_iconView.heightAnchor constraintEqualToConstant:65],
						[_iconView.widthAnchor constraintEqualToConstant:65],
					]];
				}
			}
			break;

			case LDHeaderStyleHorizontalIconLeft:
			{
				_titleLabel.textAlignment = NSTextAlignmentRight;
				_subtitleLabel.textAlignment = NSTextAlignmentRight;

				UIStackView *textStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_titleLabel]];
				textStackView.axis = UILayoutConstraintAxisVertical;
				textStackView.distribution = UIStackViewDistributionEqualSpacing;
				textStackView.alignment = UIStackViewAlignmentTrailing;
				textStackView.spacing = 0;

				if(_subtitleLabel.text.length > 0) {
					[textStackView addArrangedSubview:_subtitleLabel];
				}

				_stackView.axis = UILayoutConstraintAxisHorizontal;
				_stackView.alignment = UIStackViewAlignmentFill;
				_stackView.spacing = 15;
				[_stackView addArrangedSubview:textStackView];

				if(_iconView) {
					[_stackView insertArrangedSubview:_iconView atIndex:0];

					[NSLayoutConstraint activateConstraints:@[
						[_iconView.heightAnchor constraintEqualToConstant:65],
						[_iconView.widthAnchor constraintEqualToConstant:65],
					]];
				}
			}
			break;
		}
	}

		//Get image from bundle or from SFSymbols
	-(UIImage *)getImageNamed:(NSString *)name {
		UIImage *image;

		if(_bundle) {
			image = [UIImage imageNamed:name inBundle:_bundle compatibleWithTraitCollection:nil];
		}

		if(!image) {
			if(IS_IOS_OR_NEWER(iOS_13_0) && !image) {
				image = [UIImage systemImageNamed:name];
			}
		}

		return image;
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
@end
