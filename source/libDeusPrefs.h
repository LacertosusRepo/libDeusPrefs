#import <UIKit/UIKit.h>
#import <Preferences/PSTableCell.h>

#pragma mark - LDAnimatedTitleView

@interface LDAnimatedTitleView : UIView
-(instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color minimumScrollOffsetRequired:(CGFloat)minimumOffset;
-(void)adjustLabelPositionToScrollOffset:(CGFloat)offset;
@end

#pragma mark - LDHeaderView

  extern NSString *const LDHeaderOptionIconFileName;
  extern NSString *const LDHeaderOptionTitleFontSize;
  extern NSString *const LDHeaderOptionTitleFontColor;
  extern NSString *const LDHeaderOptionSubtitleFontSize;
  extern NSString *const LDHeaderOptionSubtitleFontColor;
  extern NSString *const LDHeaderOptionAddInterpolatingMotion;
  extern NSString *const LDHeaderOptionAddMaterialBackground;
  extern NSString *const LDHeaderOptionBackgroundImageFileName;
  extern NSString *const LDHeaderOptionHeaderStyle;

typedef NS_ENUM(NSInteger, LDHeaderStyle) {
  LDHeaderStyleVertical = 1,
  LDHeaderStyleHorizontalIconRight,
  LDHeaderStyleHorizontalIconLeft,
};

@interface LDHeaderView : UIView
-(instancetype)initWithTitle:(NSString *)title subtitles:(NSArray<NSString *> *)subtitles bundle:(NSBundle *)bundle options:(NSDictionary<NSString *, id> *)options;
@end

#pragma mark - LDStylePickerView

@interface LDStyleOptionView : UIView
-(void)setDisabled:(BOOL)disabled;
@end

@interface LDStylePickerView : PSTableCell
-(void)selectedOption:(LDStyleOptionView *)option;
-(LDStyleOptionView *)optionViewForID:(NSString *)identifier;
@end

#pragma mark - ParvusConstraint

struct LDLayoutConstants {
  CGFloat width;
  CGFloat height;
  CGFloat x;
  CGFloat y;
  CGFloat top;
  CGFloat bottom;
  CGFloat leading;
  CGFloat trailing;
};

typedef struct LDLayoutConstants LDLayoutConstants;

  LDLayoutConstants LDLayoutConstantsMake(CGFloat width, CGFloat height, CGFloat x, CGFloat y, CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);
  LDLayoutConstants LDSelectConstantsMake(NSDictionary <NSString *, NSNumber *>*constantsDict);
  LDLayoutConstants LDSizeConstantsMake(CGFloat width, CGFloat height);
  LDLayoutConstants LDEdgeConstantsMake(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);

@interface NSLayoutConstraint (ParvusConstraint)
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors constants:(LDLayoutConstants)constants;
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors;
+(NSArray <NSLayoutConstraint *>*)ld_centerView:(UIView *)primaryView inView:(UIView *)secondaryView constants:(LDLayoutConstants)constants;
+(NSArray <NSLayoutConstraint *>*)ld_sizeView:(UIView *)primaryView constants:(LDLayoutConstants)constants;
@end
