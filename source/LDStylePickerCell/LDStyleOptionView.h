@class LDStyleOptionView;
@protocol LDStyleOptionViewDelegate <NSObject>
@required
-(void)selectedOption:(LDStyleOptionView *)option;
@end

@interface LDStyleOptionView : UIView <UIGestureRecognizerDelegate>
@property (nonatomic, weak) id<LDStyleOptionViewDelegate> delegate;
@property (nonatomic, retain) id appearanceOption;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, retain) UIImage *previewImage;
@property (nonatomic, retain) UIImage *previewImageAlt;
@property (nonatomic, retain) UILabel *label;
-(instancetype)initWithAppearanceOption:(id)option;
-(void)updateViewForOption:(id)style;
@end
