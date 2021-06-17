@interface LDAnimatedTitleView : UIView
-(instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color minimumScrollOffsetRequired:(CGFloat)minimumOffset;
-(void)adjustLabelPositionToScrollOffset:(CGFloat)offset;
@end
