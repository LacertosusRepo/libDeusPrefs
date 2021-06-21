  extern NSString *const LDHeaderOptionIconFileName;
  extern NSString *const LDHeaderOptionTitleFontSize;
  extern NSString *const LDHeaderOptionTitleFontColor;
  extern NSString *const LDHeaderOptionSubtitleFontSize;
  extern NSString *const LDHeaderOptionSubtitleFontColor;
  extern NSString *const LDHeaderOptionAddInterpolatingMotion;
  extern NSString *const LDHeaderOptionAddMaterialBackground;
  extern NSString *const LDHeaderOptionBackgroundImageFileName;

@interface LDHeaderView : UIView
-(instancetype)initWithTitle:(NSString *)title subtitles:(NSArray<NSString *> *)subtitles bundle:(NSBundle *)bundle options:(NSDictionary<NSString *, id> *)options;
-(void)addInterpolatingMotionToView;
@end
