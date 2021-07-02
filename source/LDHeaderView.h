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
-(void)configureViewsForStyle:(LDHeaderStyle)style;
-(UIImage *)getImageNamed:(NSString *)name;
-(void)addInterpolatingMotionToView;
@end
